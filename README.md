# Bíblia Livre IPM

Aplicativo de Bíblia em português, offline, com hinário histórico, notas, destaques, favoritos, busca, plano de leitura, lembretes locais, leitura por voz e widget Android.

Esta é a edição independente destinada à avaliação pelo F-Droid. **Não empacota documentos da Biblioteca nem cancioneiro de músicas.** A aba Músicas permite cadastrar letras locais; o boletim também é local.

| Edição | Identificador Android | Código e downloads |
| --- | --- | --- |
| Bíblia Livre IPM | `br.com.valdenor.biblialivreipm` | [GitHub](https://github.com/alunoadsnoite/biblia-livre-ipm) · [Releases](https://github.com/alunoadsnoite/biblia-livre-ipm/releases) |
| Bíblia IPM — igreja | `br.com.valdenor.bibliaapp` | [Código da igreja](https://github.com/alunoadsnoite/bibliaappipm/tree/igreja) · [APK 5.4.0](https://github.com/alunoadsnoite/bibliaappipm/releases/tag/v5.4.0) |

Os dois apps podem ser instalados simultaneamente. Cada um tem seus próprios dados; não há migração automática entre os identificadores. Para transferir seus dados pessoais, use exportação/importação de backup. Referências a conteúdos ausentes na edição livre podem ficar indisponíveis.

## Conteúdo

- Bíblias: BLIVRE, Bíblia Portuguesa Mundial, JFAAL e Almeida 1911.
- Hinário: Salmos e Hinos, edição de 1880, 287 hinos (transcrição OCR, sujeita a revisão).
- Sem documentos traduzidos da Biblioteca, letras de músicas pré-instaladas, logomarca, contatos ou chave Pix da igreja.
- Ícone próprio: livro aberto verde, com fonte vetorial em `design/icon.svg`.

[Créditos, fontes e pendências de comprovação](docs/CONTENT_LICENSES.md). A antiguidade de uma obra não comprova a licença de uma tradução moderna.

## Instalação

Baixe o APK e o arquivo SHA-256 em [Releases](https://github.com/alunoadsnoite/biblia-livre-ipm/releases). A edição antiga 5.5.0 no repositório da igreja compartilha o identificador da igreja: **ela não é este app independente**.

**F-Droid:** solicitação [#4547](https://gitlab.com/fdroid/rfp/-/work_items/4547) em avaliação; não há confirmação de inclusão no catálogo oficial. [Estado e instruções](docs/FDROID.md).

## Desenvolvimento

Versão: **5.6.0+34**. Código principal em `flutter/`; não há app Java legado neste repositório.

Flutter fixado no commit `abaf9c523780a608bd46686fd5e53740a07077f8` (Dart compatível com `^3.13.3`). Android usa JDK 17.

```sh
cd flutter
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter run
flutter build apk --release
```

Sem `flutter/android/key.properties`, a compilação release fica sem assinatura para empacotamento externo. Para distribuir seu APK, configure privadamente `storePassword`, `keyPassword`, `keyAlias` e `storeFile`. Arquivos de assinatura são ignorados pelo Git e nunca devem ser enviados ao repositório.

Voz offline depende de uma voz instalada no aparelho. Lembretes são opcionais e podem atrasar conforme a economia de bateria do sistema.

## Repositórios e licença

- [GitHub](https://github.com/alunoadsnoite/biblia-livre-ipm) — desenvolvimento e releases.
- [GitLab](https://gitlab.com/alunoadsnoite/biblia-livre-ipm) — espelho do código.
- Código e ícone original: [MIT](LICENSE). Textos mantêm suas licenças próprias.
- Suporte: [Issues no GitHub](https://github.com/alunoadsnoite/biblia-livre-ipm/issues).

Solicitação de empacotamento existente: [fdroiddata !52559](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/52559), ainda em avaliação.
