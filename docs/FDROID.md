# F-Droid — edição independente

## Estado em 20/10/2026

Bíblia Livre IPM está em avaliação na [MR !52559](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/52559), relacionada ao [pedido #4547](https://gitlab.com/fdroid/rfp/-/work_items/4547). **A aprovação e a publicação no catálogo oficial continuam pendentes.**

- Application ID: `br.com.valdenor.biblialivreipm`.
- Versão upstream: `5.6.1+35`, tag `v5.6.1`.
- Fonte submetida: `91abbb3a7c04ea8abd7fa6119f0aa2c00fee3e04`.
- Projeto Flutter: `flutter/`; metadados: `fastlane/metadata/android/`.
- Código e ícone original MIT; textos com avisos próprios em [CONTENT_LICENSES.md](CONTENT_LICENSES.md).
- Receita: três APKs por arquitetura, versionCodes 351/352/353; atualizações por tags estáveis.

## Evidências apresentadas

A MR registra aprovação das nove etapas do [pipeline #2967849470](https://gitlab.com/alunoadsnoite/fdroiddata/-/pipelines/2967849470), incluindo compilação e verificação dos três APKs. Registra também análise Flutter e 117 testes aprovados. São resultados já publicados para a fonte acima, não novas execuções feitas ao atualizar este documento.

A procedência exata, as transformações dos textos, as exceções e os avisos completos estão no inventário de conteúdo, no manifesto com checksums e na ferramenta `tools/verify_content_sources.py`. A comparação do hinário com OCR identifica a fonte histórica; não comprova revisão editorial integral.

As capturas são widgets reais renderizados pelo motor de testes Flutter, conforme [SCREENSHOTS.md](SCREENSHOTS.md); não representam validação em aparelho físico.

## Separação

A versão da igreja permanece no projeto `bibliaappipm`, identificador `br.com.valdenor.bibliaapp`. A release 5.5.0 daquele projeto não é este app independente. Documentos da Biblioteca, cancioneiro empacotado e dados de contato/doação da igreja estão ausentes desta edição.

## Compilação

Fixar Flutter em `abaf9c523780a608bd46686fd5e53740a07077f8`, conforme `.flutter-version`, e usar JDK 17.

```sh
cd flutter
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter build apk --release
```

Sem `android/key.properties`, o release não usa chave privada. A receita solicita assinatura pelo F-Droid; não há APK upstream de referência para verificação de assinatura reproduzível. O APK local universal não substitui a validação da receita por arquitetura.

## Pendências atuais

- Revisão funcional independente e decisão de inclusão pelos mantenedores.
- Avaliação das evidências de conteúdo/licenças apresentadas.
- Sincronizar o texto antigo do RFP #4547, que ainda descreve 5.6.0 e validações pendentes, com a MR !52559. Não abrir pedido duplicado.
- Acompanhar o aviso de compatibilidade futura do plugin flutter_tts ao atualizar o SDK; o build fixado acima já tem validação registrada.

Referências: [política de inclusão](https://f-droid.org/en/docs/Inclusion_Policy/) e [guia de envio](https://f-droid.org/docs/Submitting_to_F-Droid_Quick_Start_Guide/).
