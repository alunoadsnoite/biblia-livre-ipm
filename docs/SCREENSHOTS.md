# Capturas para o F-Droid

As imagens são renderizações das telas reais do aplicativo pelo mecanismo de teste Flutter, sem desenhos ou mockups. Preferências começam vazias; notificações e migração nativa não são exercitadas nesse ambiente. Não constituem teste em aparelho físico. As capturas são em português, idioma do app.

O gerador opt-in em `flutter/tool/fdroid_screenshots_test.dart` usa viewport de 432 × 960 e saída PNG a 2×, fontes MaterialIcons do app e uma fonte sans fornecida pelo ambiente. Exemplo no Linux:

```sh
cd flutter
FDROID_SCREENSHOT_FONT=/caminho/NotoSans-Regular.ttf flutter test tool/fdroid_screenshots_test.dart
```

As imagens mostram Bíblia, hinário histórico e configurações. Dados locais vazios são usados; nenhuma informação pessoal é incluída. As imagens devem ser regeneradas após mudanças de interface.
