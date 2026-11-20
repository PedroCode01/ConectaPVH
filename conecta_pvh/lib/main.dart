import 'package:flutter/material.dart';
import 'constants/cores.dart';
import 'models/configuracoes_acessibilidade.dart';
import 'screens/app_shell.dart';

void main() {
  runApp(const ConectaPVHApp());
}

class ConectaPVHApp extends StatefulWidget {
  const ConectaPVHApp({super.key});

  @override
  State<ConectaPVHApp> createState() => _ConectaPVHAppState();
}

class _ConectaPVHAppState extends State<ConectaPVHApp> {
  final ConfiguracoesAcessibilidade _controller = ConfiguracoesAcessibilidade();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AcessibilidadeScope(
      controller: _controller,
      child: Builder(
        builder: (context) {
          final acessibilidade = AcessibilidadeScope.of(context);
          final mediaQuery = MediaQuery.of(context);
          final altoContrasteAtivo = acessibilidade.altoContraste;
          final modoEscuroAtivo = acessibilidade.modoEscuro;

          const fundoEscuro = Color(0xFF0B1320);
          const superficieEscura = Color(0xFF132238);
          const bordaEscura = Color(0xFF233A5C);
          const textoEscuroSuave = Color(0xFF9FB3C8);

          final temaClaro = ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: altoContrasteAtivo ? Colors.white : creme,
            colorScheme: ColorScheme.fromSeed(
              seedColor: floresta,
              brightness: Brightness.light,
              primary: floresta,
              secondary: lima,
              surface: altoContrasteAtivo ? Colors.white : creme,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: altoContrasteAtivo ? Colors.white : creme,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: papel,
              hintStyle: const TextStyle(color: fosco),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: altoContrasteAtivo ? florestaEscuro : linha,
                  width: altoContrasteAtivo ? 1.5 : 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: altoContrasteAtivo ? florestaEscuro : linha,
                  width: altoContrasteAtivo ? 1.5 : 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: floresta, width: 2),
              ),
            ),
          );

          final temaEscuro = ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor:
                altoContrasteAtivo ? Colors.black : fundoEscuro,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3B82F6),
              brightness: Brightness.dark,
              primary: lima,
              secondary: const Color(0xFF60A5FA),
              surface: altoContrasteAtivo ? Colors.black : superficieEscura,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: altoContrasteAtivo ? Colors.black : fundoEscuro,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: superficieEscura,
              hintStyle: const TextStyle(color: textoEscuroSuave),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: altoContrasteAtivo ? Colors.white : bordaEscura,
                  width: altoContrasteAtivo ? 1.5 : 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: altoContrasteAtivo ? Colors.white : bordaEscura,
                  width: altoContrasteAtivo ? 1.5 : 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: lima, width: 2),
              ),
            ),
          );

          return MaterialApp(
            title: 'ConectaPVH',
            debugShowCheckedModeBanner: false,
            themeMode: modoEscuroAtivo ? ThemeMode.dark : ThemeMode.light,
            theme: temaClaro,
            darkTheme: temaEscuro,
            builder: (context, child) {
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: TextScaler.linear(acessibilidade.escalaFonte),
                  disableAnimations: acessibilidade.reduzirAnimacoes,
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: const AppShell(),
          );
        },
      ),
    );
  }
}

// COMANDO PARA EXECUTAR PELO SIMULADOR DO GITHUB: r