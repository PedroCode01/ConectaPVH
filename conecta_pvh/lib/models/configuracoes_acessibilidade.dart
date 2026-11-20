import 'package:flutter/material.dart';

class ConfiguracoesAcessibilidade extends ChangeNotifier {
  double _escalaFonte = 1.0;
  bool _altoContraste = false;
  bool _reduzirAnimacoes = false;
  bool _modoEscuro = false;

  double get escalaFonte => _escalaFonte;
  bool get altoContraste => _altoContraste;
  bool get reduzirAnimacoes => _reduzirAnimacoes;
  bool get modoEscuro => _modoEscuro;

  void atualizarEscalaFonte(double valor) {
    _escalaFonte = valor.clamp(0.9, 1.3);
    notifyListeners();
  }

  void atualizarAltoContraste(bool valor) {
    _altoContraste = valor;
    notifyListeners();
  }

  void atualizarReduzirAnimacoes(bool valor) {
    _reduzirAnimacoes = valor;
    notifyListeners();
  }

  void atualizarModoEscuro(bool valor) {
    _modoEscuro = valor;
    notifyListeners();
  }

  void restaurarPadrao() {
    _escalaFonte = 1.0;
    _altoContraste = false;
    _reduzirAnimacoes = false;
    _modoEscuro = false;
    notifyListeners();
  }
}

class AcessibilidadeScope extends InheritedNotifier<ConfiguracoesAcessibilidade> {
  const AcessibilidadeScope({
    super.key,
    required ConfiguracoesAcessibilidade controller,
    required super.child,
  }) : super(notifier: controller);

  static ConfiguracoesAcessibilidade of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AcessibilidadeScope>();
    assert(scope != null, 'AcessibilidadeScope não encontrado na árvore.');
    return scope!.notifier!;
  }
}