# F-Droid — edição independente

## Estado em 27/10/2026

Bíblia Livre IPM está [disponível no catálogo oficial](https://f-droid.org/packages/br.com.valdenor.biblialivreipm/) na versão **5.6.1**, com versionCodes **351, 352 e 353** confirmados na [API do catálogo](https://f-droid.org/api/v1/packages/br.com.valdenor.biblialivreipm). A [MR !52559](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/52559) foi integrada em **22/10/2026**; o [pedido #4547](https://gitlab.com/fdroid/rfp/-/work_items/4547) é a referência histórica.

- Application ID: `br.com.valdenor.biblialivreipm`.
- Versão upstream: `5.6.1+35`, tag `v5.6.1`.
- Fonte submetida: `91abbb3a7c04ea8abd7fa6119f0aa2c00fee3e04`.
- Projeto Flutter: `flutter/`; metadados: `fastlane/metadata/android/`.
- Código e ícone original MIT; textos com avisos próprios em [CONTENT_LICENSES.md](CONTENT_LICENSES.md).
- Receita: três APKs por arquitetura, versionCodes 351/352/353; atualizações por tags estáveis.
- Idioma: interface e conteúdo em português do Brasil (`pt-BR`), sem seletor de idioma. O texto `en-US` traduz somente a ficha do catálogo.

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

## Revisão funcional de Joerg

No [comentário de 21/10/2026](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/52559#note_4063260045), Joerg registrou teste da 5.6.1 em Samsung SM-G998B / Android 15, com leitura, plano, temas, áudio e conclusão de capítulo funcionando, sem crash observado. Também registrou ausência de tráfego no intervalo testado e ausência da permissão INTERNET no APK. São resultados atribuídos ao teste dele; não equivalem a uma auditoria de todos os fluxos nem à aprovação de inclusão.

Os códigos por arquitetura são 351 (ARMv7), 352 (ARM64) e 353 (x86_64). `CurrentVersionCode: 353` representa o maior código da receita, não o código que um aparelho ARM64 deve instalar. O `VercodeOperation` atual é intencional.

## Assinatura e builds reproduzíveis

A submissão atual solicita assinatura pelo F-Droid e declara não fornecer APK upstream de produção para a versão submetida. Artefatos assinados pelo CI são referências de teste; não devem ser usados para fixar a chave de produção. A referência antiga 5.6.0 não é uma referência binária para a fonte 5.6.1.

Para habilitar a alternativa com assinatura upstream, é necessário primeiro:

1. Publicar os três APKs de produção da mesma versão/fonte, assinados com a chave de distribuição sob controle do mantenedor.
2. Verificar os certificados e documentar o SHA-256 público da chave de assinatura; nunca publicar a chave privada ou suas senhas.
3. Reproduzir cada APK a partir da receita e verificar a cópia da assinatura, observando Flutter e dependências fixados.
4. Só então adicionar `Binaries` ou `Builds.binary` com URLs existentes para cada ABI e `AllowedAPKSigningKeys` com o certificado efetivamente verificado, e solicitar o reteste ao Joerg.

Os campos não foram preenchidos com URLs ou fingerprints presumidos. A distribuição atual mantém a assinatura do F-Droid. Uma troca posterior de chave pode impedir atualizações sobre instalações existentes. Referência: [Reproducible Builds](https://f-droid.org/docs/Reproducible_Builds/).

## Pendências atuais

- A inclusão está concluída; não há bloqueio de publicação pendente na MR !52559.
- O RFP #4547 e notas de versões antigas são registros históricos; para disponibilidade, consultar o catálogo acima.
- Acompanhar o aviso de compatibilidade futura do plugin flutter_tts ao atualizar o SDK; o build fixado acima já tem validação registrada.

Referências: [política de inclusão](https://f-droid.org/en/docs/Inclusion_Policy/) e [guia de envio](https://f-droid.org/docs/Submitting_to_F-Droid_Quick_Start_Guide/).
