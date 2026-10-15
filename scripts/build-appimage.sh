#!/usr/bin/env bash
set -euo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
: "${LINUXDEPLOY:?Defina LINUXDEPLOY com o caminho do linuxdeploy}"
: "${APPIMAGETOOL:?Defina APPIMAGETOOL com o caminho do appimagetool}"
cd "$root/flutter"
flutter pub get --enforce-lockfile
flutter build linux --release
cd "$root"
appdir="$root/dist/BibliaLivre.AppDir"
rm -rf -- "$appdir"
mkdir -p "$appdir/usr/bin"
cp -a flutter/build/linux/x64/release/bundle/. "$appdir/usr/bin/"
cp packaging/linux/*.desktop "$appdir/"
mkdir -p "$appdir/usr/share/metainfo"
cp packaging/linux/*.metainfo.xml "$appdir/usr/share/metainfo/"
cp design/icon.svg "$appdir/io.github.alunoadsnoite.biblia-livre-ipm.svg"
cp flutter/assets/logo_livre.png "$appdir/.DirIcon"
mkdir -p "$appdir/usr/share/doc/biblia-livre"
cp LICENSE "$appdir/usr/share/doc/biblia-livre/"
cp -a docs/licenses "$appdir/usr/share/doc/biblia-livre/"
cat > "$appdir/AppRun" <<'RUN'
#!/bin/sh
APPDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
export LD_LIBRARY_PATH="$APPDIR/usr/bin/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
exec "$APPDIR/usr/bin/biblia-livre" "$@"
RUN
chmod +x "$appdir/AppRun"
"$LINUXDEPLOY" --appdir "$appdir" --executable "$appdir/usr/bin/biblia-livre" --desktop-file "$appdir/io.github.alunoadsnoite.biblia-livre-ipm.desktop" --icon-file "$appdir/io.github.alunoadsnoite.biblia-livre-ipm.svg"
ARCH=x86_64 "$APPIMAGETOOL" "$appdir" "$root/dist/Biblia-Livre-IPM-x86_64.AppImage"
cd "$root/dist"
sha256sum Biblia-Livre-IPM-x86_64.AppImage > SHA256SUMS
