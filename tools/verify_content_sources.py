#!/usr/bin/env python3
"""Compare bundled text with pinned public sources. See docs/CONTENT_LICENSES.md."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import unicodedata
import zipfile

ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / 'flutter/assets'
BLIVRE = 'a386942daee9984c654ebc8cea95ec9d3661b183'
JFAAL = '5d41ae97bbe1fee9c48d8a3a36404addbb149621'
FILES = 'gen exod lev num deut jos juiz rute 1sa 2sa 1rs 2rs 1crn 2crn esd nee est jo sal prov ecl cant isa jer lam eze dan ose joel amos oba jon miq naum hab sof ageu zac mal mat mar luc joao atos rom 1cor 2cor gal efes fil col 1tes 2tes 1tim 2tim tito flm heb tiag 1ped 2ped 1joao 2joao 3joao jud apo'.split()
CODES = 'GEN EXO LEV NUM DEU JOS JDG RUT 1SA 2SA 1KI 2KI 1CH 2CH EZR NEH EST JOB PSA PRO ECC SOL ISA JER LAM EZE DAN HOS JOE AMO OBA JON MIC NAH HAB ZEP HAG ZEC MAL MAT MAR LUK JOH ACT ROM 1CO 2CO GAL EPH PHI COL 1TH 2TH 1TI 2TI TIT PHM HEB JAM 1PE 2PE 1JO 2JO 3JO JUD REV'.split()

def read_asset(name):
    return json.loads((ASSETS / name).read_text())

def raw(repo, commit, name):
    return subprocess.check_output(['git', '-C', str(repo), 'show', f'{commit}:{name}'])

def normalize(s):
    return re.sub(r'\s+', '', unicodedata.normalize('NFC', s).translate(str.maketrans({'“': '"', '”': '"', '‘': "'", '’': "'"})))

def verify(args):
    result = {}
    for asset, source in [('biblia_jfaal.json', 'atualizada/1911-JFAAtualizadaLivre.json'), ('biblia_1911.json', 'original/1911-JFAAtualizada.json')]:
        books = json.loads(raw(args.jfaal, JFAAL, source))['books']
        bundled = read_asset(asset)
        assert len(books) == len(bundled) == 66
        count = 0
        for book, target in zip(books, bundled):
            assert len(book['chapters']) == len(target['chapters'])
            for chapter, verses in zip(book['chapters'], target['chapters']):
                texts = [verse['text'] for verse in chapter['verses']]
                assert texts == verses, (asset, book['nr'], chapter['chapter'])
                count += len(texts)
        result[asset] = {'verses': count, 'comparison': 'exact verse text equality'}

    count = 0
    for book, filename in zip(read_asset('biblia_blivre.json'), FILES):
        text = raw(args.blivre, BLIVRE, f'textos/f4/tr/{filename}.txt').decode('utf-8-sig')
        text = re.sub(r'\\psalm-title\s*\n(.*?)\n\\\*psalm-title\s*\n(\\v[^\n]+\n)', lambda m: m[2] + m[1].strip() + ' ', text, flags=re.S)
        verses = {}
        for m in re.finditer(r'\\v\s+\S+\.(\d+)\.(\d+)\s*\n(.*?)(?=\\v\s|\Z)', text, re.S):
            body = re.sub(r'\\(?:fn|ref)\s*\n.*?\\\*(?:fn|ref)\s*\n', '', m[3], flags=re.S)
            body = re.sub(r'\\added\s*\n(.*?)\n\\\*added', lambda m: '[' + m[1].strip() + ']', body, flags=re.S)
            body = re.sub(r'^\\[^\n]*\n', '', body, flags=re.M)
            verses[(int(m[1]), int(m[2]))] = body
        for chapter, texts in enumerate(book['chapters'], 1):
            for verse, bundled in enumerate(texts, 1):
                source = verses[(chapter, verse)]
                if filename == 'zac' and (chapter, verse) == (7, 13):
                    source = source.replace('tamb~em', 'tamb\u00a0em')
                assert normalize(source) == normalize(bundled), (filename, chapter, verse)
                count += 1
        assert len(verses) == sum(map(len, book['chapters']))
    result['biblia_blivre.json'] = {'verses': count, 'comparison': '2018.2.0 TR, declared markup and typography transformations'}

    with zipfile.ZipFile(args.bpm_zip) as archive:
        lines = archive.read('porbrbsl_vpl.txt').decode('utf-8-sig').splitlines()
    source = {}
    for line in lines:
        m = re.match(r'(\w+) (\d+):(\d+) (.*)', line)
        if m:
            source[(m[1], int(m[2]), int(m[3]))] = m[4]
    count = omitted = 0
    for code, book in zip(CODES, read_asset('biblia_bpm.json')):
        for chapter, texts in enumerate(book['chapters'], 1):
            for verse, bundled in enumerate(texts, 1):
                original = source[(code, chapter, verse)]
                if not original:
                    assert bundled == '[Versículo não incluído nesta tradução.]'
                    omitted += 1
                else:
                    assert original == bundled, (code, chapter, verse)
                count += 1
    result['biblia_bpm.json'] = {'verse_slots': count, 'explicit_empty_verse_placeholders': omitted, 'comparison': 'exact verse text equality'}

    manifest = json.loads((ROOT / 'docs/provenance/source-manifest.json').read_text())
    for name, expected in manifest['asset_sha256'].items():
        assert hashlib.sha256((ASSETS / name).read_bytes()).hexdigest() == expected, name
    assert hashlib.sha256(Path(args.hymnal_ocr).read_bytes()).hexdigest() == manifest['hymnal']['ocr_sha256']
    norm = lambda s: re.sub('[^a-z0-9]', '', unicodedata.normalize('NFKD', s.lower()).encode('ascii', 'ignore').decode())
    ocr = Path(args.hymnal_ocr).read_text()
    compact = norm(ocr)
    corrections = json.loads((ROOT / 'docs/provenance/hymnal-ocr-differences.json').read_text())
    correction_map = {(r['hymn'], r['app_line']): r['ocr_line'] for r in corrections}
    exact = corrected = 0
    hymns = read_asset('hinos.json')
    assert len(hymns) == 287
    for hymn in hymns:
        for stanza in hymn['verses']:
            for line in stanza['lines']:
                if len(norm(line)) < 9:
                    continue
                if norm(line) in compact:
                    exact += 1
                else:
                    original = correction_map[(hymn['num'], line)]
                    assert original in ocr
                    corrected += 1
    result['hinos.json'] = {'hymns': len(hymns), 'normalized_lines_found_in_1880_OCR': exact, 'declared_OCR_corrections': corrected, 'note': 'OCR alignment documents provenance, not a complete editorial proofreading certification.'}
    return result

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for flag in ['blivre', 'jfaal', 'bpm-zip', 'hymnal-ocr']:
        parser.add_argument('--' + flag, type=Path, required=True)
    print(json.dumps(verify(parser.parse_args()), ensure_ascii=False, indent=2))
