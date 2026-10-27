# ConectaPVH — Flutter + Dart

Aplicativo Flutter que recria a experiência do ConectaPVH com direção visual minimalista e sofisticada.

## Funcionalidades

- Tela inicial com identidade visual verde, busca e filtros por categoria/região.
- Cards de oportunidades com detalhes de horário, organização, bairro e custo.
- Pesquisa por título, organização, bairro, endereço, região, categoria e horário.
- Favoritos persistidos localmente.
- Formulário validado para sugerir oportunidades; sugestões persistidas apenas neste dispositivo.
- Tela de mapa preparada para futura integração e lista de endereços sem marcadores fictícios.
- Layout Material 3 responsivo e estados vazios.

## Executar

Requer Flutter SDK (Dart 3.3+).

```bash
flutter pub get
flutter run
```

Para verificar análise estática:

```bash
flutter analyze
```

## Dependência

`shared_preferences` é usada somente para persistência local de favoritos e sugestões. Não há backend nem serviços externos conectados.

## Limitações explícitas

- Os dados iniciais são exemplos herdados do protótipo e devem ser confirmados antes de uso público.
- O mapa real e a navegação por rotas ainda não estão conectados. A futura implementação exige escolha de provedor, configuração e coordenadas confiáveis.
- O envio de sugestões não publica os dados para outras pessoas.
- A ação de participação não cria uma inscrição; a interface informa essa limitação ao usuário.


## Gerar o APK com GitHub Actions

Este projeto inclui `.github/workflows/build-apk.yml`. Para gerar o APK em um runner com Flutter e Android SDK:

1. Crie um repositório no GitHub e envie o conteúdo desta pasta.
2. Abra a aba **Actions** do repositório.
3. Selecione **Build Android APK** e clique em **Run workflow** (ou faça push para `main`/`master`).
4. Quando a execução terminar com sucesso, abra a execução e baixe o artefato **conectapvh-android-apk**.
5. O arquivo dentro do artefato será `app-release.apk`.

O APK não foi compilado neste ambiente, pois o Flutter SDK/Android SDK não estão instalados e o ambiente não tem acesso à rede para baixá-los. O workflow prepara a compilação em um runner do GitHub; o APK só existirá depois de uma execução bem-sucedida.
