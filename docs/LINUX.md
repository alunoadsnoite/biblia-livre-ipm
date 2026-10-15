# Bíblia Livre IPM para Linux

Esta edição experimental usa o mesmo código Flutter da edição livre Android.

## Recursos

Leitura offline, pesquisa, comparação de traduções, notas, favoritos e plano de leitura.
Backups JSON podem ser importados pelo seletor de arquivos e exportados pela janela Salvar.
No Linux, compartilhar texto copia o conteúdo para a área de transferência.
Leitura por voz e lembretes agendados ainda não estão disponíveis nesta edição.

## Compilar

Instale Flutter estável compatível com o pubspec, clang, CMake, Ninja, pkg-config e os cabeçalhos GTK 3.

```sh
cd flutter
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter build linux --release
./build/linux/x64/release/bundle/biblia-livre
```

## Gerar AppImage x86_64

Obtenha as ferramentas dos projetos oficiais AppImage/appimagetool e linuxdeploy/linuxdeploy no GitHub.
Informe caminhos absolutos para ambas:

```sh
APPIMAGE_EXTRACT_AND_RUN=1 \
APPIMAGETOOL=/caminho/appimagetool-x86_64.AppImage \
LINUXDEPLOY=/caminho/linuxdeploy-x86_64.AppImage \
scripts/build-appimage.sh
```

O resultado e seu SHA-256 ficam em dist/. O AppImage deve receber permissão de execução.
Se o sistema não disponibilizar FUSE, execute com --appimage-extract-and-run.

## Distribuição

O pacote local é de teste. Antes da release pública, testar leitura, busca, persistência após reinício,
backups e integração gráfica em distribuições suportadas. A compilação inicial foi feita em Debian 13
x86_64; ela não comprova compatibilidade com distribuições anteriores. Para ampliar a compatibilidade,
recompilar em uma base Linux mais antiga suportada e testar o pacote nas distribuições de destino.

Concluir também as pendências documentadas em CONTENT_LICENSES.md; esta portabilidade não resolve
as verificações de origem das transcrições. Publicar o AppImage, SHA256SUMS, licença e notas de versão
no GitHub Releases somente após essas verificações. Não há submissão ao Flathub nesta implementação.

## Validação local em 15/10/2026

- Compilação Linux release concluída com Flutter 3.47.7 em Debian 13 x86_64.
- Análise estática sem problemas.
- Suíte existente: 117 testes aprovados após corrigir overflow do indicador de sequência com fonte ampliada.
- Dois testes adicionais de interface Linux aprovados.
- Metadados AppStream validados e script de empacotamento com sintaxe verificada.
- Executável e AppImage iniciaram em sessão gráfica, observados por 15 segundos cada. Isso não substitui teste manual completo de leitura e persistência.
- AppImage local com aproximadamente 23 MB; SHA-256 em dist/SHA256SUMS.
