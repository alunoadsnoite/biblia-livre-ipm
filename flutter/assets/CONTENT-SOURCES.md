# Conteúdos e atribuições — Bíblia Livre IPM

O código e o ícone original são MIT. Os textos possuem avisos próprios. Esta auditoria registra as fontes exatas e as transformações de formato; a aceitação pelo F-Droid permanece sujeita aos mantenedores.

## Fontes identificadas e comparação

- **BLIVRE**: [BibliaLivre, tag 2018.2.0](https://github.com/blivre/BibliaLivre/tree/a386942daee9984c654ebc8cea95ec9d3661b183), commit `a386942daee9984c654ebc8cea95ec9d3661b183`, arquivos `textos/f4/tr/*.txt`. Licença CC BY 3.0 Brasil, conforme `LICENCA.md`. Os 31.102 versículos correspondem após remover notas/referências, converter `added` em colchetes, incorporar títulos de salmos e normalizar espaços/aspas. A conversão legada de `tamb~em` para `tamb\u00a0em` em Zc 7:13 é explicitamente tolerada; não se declara que os bytes JSON sejam os bytes do formato F4.
- **JFAAL**: [fonte](https://github.com/BibliaJFAAL/JFAAL/tree/5d41ae97bbe1fee9c48d8a3a36404addbb149621), commit `5d41ae97bbe1fee9c48d8a3a36404addbb149621`, `atualizada/1911-JFAAtualizadaLivre.json`. Todos os 31.102 textos de versículo são idênticos. O repositório publica MIT no LICENSE e também pede atribuição com CC BY 3.0 Brasil no README; ambos os avisos são conservados integralmente, sem descartar um em favor do outro. Crédito: JFAAL, © Marcos Cristiano Alves Ferreira, setembro de 2024.
- **Almeida 1911**: mesmo commit e repositório JFAAL, arquivo `original/1911-JFAAtualizada.json`. Todos os 31.102 textos de versículo são idênticos. A fonte identifica a edição histórica de 1911 como domínio público; a transcrição está no repositório com os avisos MIT e de atribuição preservados. Não se atribui a este arquivo uma tradução moderna de editora comercial.
- **BPM**: [eBible porbrbsl](https://ebible.org/porbrbsl/), [aviso de domínio público](https://ebible.org/porbrbsl/copyright.htm), pacote oficial [porbrbsl_vpl.zip](https://ebible.org/Scriptures/porbrbsl_vpl.zip), obtido em 20/10/2026. O app usa os 66 livros de seu cânone. Os 31.103 espaços de versículo correspondem exatamente, exceto cinco espaços vazios na fonte, exibidos como `[Versículo não incluído nesta tradução.]`. O SHA-256 do pacote obtido está no manifesto; a URL da eBible é mutável.
- **Salmos e Hinos (1880)**: [Psalmos e hymnos, Lisboa: Rua Das Janellas, 1880](https://archive.org/details/psalmosehymnos00unse), digitalizado pela Princeton Theological Seminary Library; [registro bibliográfico](https://openlibrary.org/books/OL33204223M/Psalmos_e_hymnos). Texto histórico da edição de 1880, não o hinário moderno Novo Cântico. O app contém 287 itens. Das 6.837 linhas com pelo menos nove caracteres alfanuméricos, 6.742 foram localizadas no OCR após normalizar caixa, acentos, espaços e pontuação; as 95 restantes correspondem a correções de leitura OCR documentadas, sobretudo `Elie`/`EUe` para `Elle` e `soíTreu` para `soffreu`. A tabela conserva a linha de OCR de cada diferença. Isso identifica a procedência; não certifica revisão editorial integral nem ausência de erros de transcrição. Nenhuma música moderna, partitura ou gravação é incluída.

## Avisos e créditos

Bíblia Livre (BLIVRE), © Diego Santos, Mario Sérgio e Marco Teles, fevereiro de 2018. [Creative Commons Atribuição 3.0 Brasil](https://creativecommons.org/licenses/by/3.0/br/). Fontes: https://sites.google.com/site/biblialivre/ e https://github.com/blivre/BibliaLivre.

Os avisos completos BLIVRE, JFAAL e suas atribuições estão em `docs/licenses/` e também nos assets do aplicativo, em Sobre → Licenças dos conteúdos e dependências. Não se usa a licença MIT do aplicativo como licença geral dos textos.

`redletter.json` é um índice factual de referências para destaque; `boletim.json` contém listas vazias; `logo_livre.png`, os ícones e `design/icon.svg` são arte original desta edição, MIT. Letras e dados importados pelo usuário permanecem locais e não integram a distribuição.

A biblioteca de documentos e os dados de contato/doação da edição da igreja permanecem ausentes. Não são distribuídas ARA, NVI, NTLH, BKJ, Novo Cântico ou o cancioneiro anterior.

