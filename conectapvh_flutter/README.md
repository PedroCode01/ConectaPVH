# ConectaPVH — Flutter + Dart

Protótipo Android para conectar moradores de Porto Velho a oportunidades comunitárias.

## Funcionalidades incluídas

- Início com categorias e oportunidades de exemplo
- Busca por título, local e categoria
- Explorar com filtros
- Detalhes da oportunidade
- Salvar/remover favoritos
- Formulário para publicar uma oportunidade
- Perfil e preferências demonstrativas
- Navegação inferior com cinco áreas
- Identidade visual verde-floresta, verde-lima e creme

## Requisitos

- Flutter stable (SDK Dart incluído)
- Android Studio ou Android SDK + ferramentas de linha de comando
- Java/JDK compatível com a versão instalada do Flutter

## Rodar localmente

```bash
flutter doctor
flutter pub get
flutter run
```

## Gerar APK de teste

```bash
flutter build apk --debug
```

O APK ficará em `build/app/outputs/flutter-apk/app-debug.apk`.

Para um APK de release:

```bash
flutter build apk --release
```

O APK de release pode precisar de assinatura própria para distribuição pública. Não publique um APK sem testar em um dispositivo real.

## Gerar via GitHub Actions

O workflow `.github/workflows/android-apk.yml` compila um APK debug quando você envia o projeto para o GitHub. Baixe o artefato `conectapvh-debug-apk` na execução do workflow.

## Estado atual / limitações

Esta é uma primeira versão de protótipo:
- Os dados de exemplo e as novas publicações existem somente em memória e desaparecem ao fechar o app.
- Não há login, backend, sincronização entre usuários, upload de fotos, mapa real, notificações ou inscrição/contato funcional.
- O mapa e as imagens fotográficas ainda não estão integrados.
- O perfil é demonstrativo.

## Próximos passos sugeridos

1. Escolher e configurar Firebase ou Supabase para autenticação e banco de dados.
2. Persistir favoritos e publicações.
3. Adicionar imagens e upload.
4. Implementar mapa e localização com permissões.
5. Adicionar moderação, denúncias e políticas de privacidade antes de abrir ao público.
