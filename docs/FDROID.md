# F-Droid — edição independente

Estado em 14/10/2026: preparação e avaliação preliminar no [pedido #4547](https://gitlab.com/fdroid/rfp/-/work_items/4547). **Não aprovado nem publicado no catálogo oficial.**

- Nome: Bíblia Livre IPM.
- Application ID: `br.com.valdenor.biblialivreipm`.
- Versão: `5.6.0`, versionCode `34`.
- Fonte: https://github.com/alunoadsnoite/biblia-livre-ipm (espelho no GitLab de mesmo nome).
- Projeto Flutter: `flutter/`; metadados: `fastlane/metadata/android/`.
- Código/ícone original MIT; textos com licenças próprias, conforme [CONTENT_LICENSES.md](CONTENT_LICENSES.md).

## Separação

A versão da igreja permanece no projeto `bibliaappipm`, identificador `br.com.valdenor.bibliaapp`. A release 5.5.0 daquele projeto foi uma etapa intermediária e ainda continha a Biblioteca. Não deve ser usada como release deste novo app.

A edição independente remove os documentos da Biblioteca do manifesto de assets, do carregamento e da navegação. Não há módulo Java legado ou histórico com os antigos assets. O nome, ícone e identificador são distintos.

## Compilação

Fixar Flutter em `abaf9c523780a608bd46686fd5e53740a07077f8`; usar JDK 17. O Gradle Wrapper inclui checksum da distribuição.

```sh
cd flutter
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter build apk --release
```

Sem `android/key.properties` o release não utiliza assinatura privada. O F-Droid compila do código e assina por conta própria; não enviar chave ou senhas.

## Pendências reais

- Documentar arquivos/revisões exatas e avisos completos das licenças dos textos, conforme o inventário.
- Preparar e validar a receita no ambiente fdroidserver, incluindo scanner e dependências Flutter.
- Atualizar e validar a receita da [merge request existente !52559](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/52559) para a edição independente. A !52558 está fechada; não abrir duplicatas.
- Aguardar avaliação dos mantenedores; APK local e CI verde não equivalem a aprovação.

Referências: [política de inclusão](https://f-droid.org/en/docs/Inclusion_Policy/) e [guia de envio](https://f-droid.org/docs/Submitting_to_F-Droid_Quick_Start_Guide/).

Solicitação de empacotamento existente: [fdroiddata !52559](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/52559), ainda em avaliação.
