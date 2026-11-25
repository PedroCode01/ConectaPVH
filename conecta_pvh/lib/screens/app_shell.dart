import 'package:flutter/material.dart';
import '../constants/cores.dart';
import '../data/oportunidades_fixas.dart'; 
import '../models/configuracoes_acessibilidade.dart';
import '../models/oportunidade.dart';
import 'explorar_page.dart';
import 'home_page.dart';
import 'perfil_page.dart';
import 'publicar_page.dart';
import 'salvos_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    this.oportunidadesIniciais = const <Oportunidade>[],
  });

  final List<Oportunidade> oportunidadesIniciais;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _paginaAtual = 0;
  String _termoBusca = '';
  String _categoriaSelecionada = 'Todas';
  final Set<int> _idsSalvos = <int>{};
  late List<Oportunidade> _oportunidades;

  @override
  void initState() {
    super.initState();
    _oportunidades = widget.oportunidadesIniciais.isNotEmpty
        ? List<Oportunidade>.from(widget.oportunidadesIniciais)
        : List<Oportunidade>.from(oportunidades_fixas);
  }

  List<Oportunidade> get _oportunidadesFiltradas {
    return _oportunidades.where((op) {
      final bateCategoria =
          _categoriaSelecionada == 'Todas' ||
          op.categoria.toLowerCase() == _categoriaSelecionada.toLowerCase();

      final busca = _termoBusca.trim().toLowerCase();
      final bateBusca =
          busca.isEmpty ||
          op.titulo.toLowerCase().contains(busca) ||
          op.categoria.toLowerCase().contains(busca) ||
          op.local.toLowerCase().contains(busca);

      return bateCategoria && bateBusca;
    }).toList();
  }

  void _alternarSalvo(Oportunidade oportunidade) {
    setState(() {
      if (_idsSalvos.contains(oportunidade.id)) {
        _idsSalvos.remove(oportunidade.id);
      } else {
        _idsSalvos.add(oportunidade.id);
      }
    });
  }

  void _abrirDetalhes(Oportunidade oportunidade) {
    final acessibilidade = AcessibilidadeScope.of(context);
    final modoEscuro = acessibilidade.modoEscuro;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: modoEscuro ? const Color(0xFF132238) : papel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                oportunidade.titulo,
                style: TextStyle(
                  color: modoEscuro ? Colors.white : florestaEscuro,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${oportunidade.categoria} • ${oportunidade.local}',
                style: TextStyle(
                  color: modoEscuro ? const Color(0xFF9FB3C8) : fosco,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                oportunidade.descricao,
                style: TextStyle(
                  color: modoEscuro ? Colors.white70 : florestaEscuro,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: lima,
                    foregroundColor: florestaEscuro,
                  ),
                  child: const Text('Fechar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _abrirCentralLibras(BuildContext context) {
    final acessibilidade = AcessibilidadeScope.of(context);
    final modoEscuro = acessibilidade.modoEscuro;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: modoEscuro ? const Color(0xFF132238) : papel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: floresta,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.sign_language_rounded,
                      color: lima,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Central de Libras',
                          style: TextStyle(
                            color: modoEscuro ? Colors.white : florestaEscuro,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Inclusão e comunicação acessível em Porto Velho',
                          style: TextStyle(
                            color: modoEscuro
                                ? const Color(0xFF9FB3C8)
                                : fosco,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'Acesse recursos visuais, glossário de sinais e orientações de atendimento inclusivo para oportunidades na cidade.',
                style: TextStyle(
                  color: modoEscuro ? Colors.white70 : florestaEscuro,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Entendi'),
                  style: FilledButton.styleFrom(
                    backgroundColor: lima,
                    foregroundColor: florestaEscuro,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final acessibilidade = AcessibilidadeScope.of(context);
    final modoEscuro = acessibilidade.modoEscuro;
    final altoContraste = acessibilidade.altoContraste;

    const superficieEscura = Color(0xFF132238);
    const bordaEscura = Color(0xFF233A5C);

    // Ordem visual da barra:
    // 0: Início | 1: Libras (ação modal) | 2: Explorar | 3: Publicar | 4: Salvos | 5: Perfil
    final int indiceVisual = switch (_paginaAtual) {
      0 => 0,
      1 => 2,
      2 => 3,
      3 => 4,
      4 => 0,
      _ => 0,
    };

    final paginas = <Widget>[
      HomePage(
        termoBusca: _termoBusca,
        aoMudarBusca: (valor) => setState(() => _termoBusca = valor),
        categoriaSelecionada: _categoriaSelecionada,
        aoMudarCategoria: (cat) => setState(() => _categoriaSelecionada = cat),
        oportunidades: _oportunidadesFiltradas,
        idsSalvos: _idsSalvos,
        aoAlternarSalvo: _alternarSalvo,
        aoAbrirDetalhes: _abrirDetalhes,
        aoIrParaPublicar: () => setState(() => _paginaAtual = 2),
        aoIrParaPerfil: () => setState(() => _paginaAtual = 4),
        perfilAtivo: _paginaAtual == 4,
      ),
      ExplorarPage(
        termoBusca: _termoBusca,
        aoMudarBusca: (valor) => setState(() => _termoBusca = valor),
        categoriaSelecionada: _categoriaSelecionada,
        aoMudarCategoria: (cat) => setState(() => _categoriaSelecionada = cat),
        oportunidades: _oportunidadesFiltradas,
        idsSalvos: _idsSalvos,
        aoAlternarSalvo: _alternarSalvo,
        aoAbrirDetalhes: _abrirDetalhes,
      ),
      PublicarPage(
        aoPublicar: ({
          required String categoria,
          required String descricao,
          required String local,
          required String titulo,
        }) {
          final proximoId = _oportunidades.isEmpty
              ? 1
              : _oportunidades
                        .map((e) => e.id)
                        .reduce((a, b) => a > b ? a : b) +
                    1;

          final novaOportunidade = Oportunidade(
            id: proximoId,
            titulo: titulo,
            categoria: categoria,
            local: local,
            data: 'Hoje',
            descricao: descricao,
            icone: iconeDaCategoria(categoria),
          );

          setState(() {
            _oportunidades = [novaOportunidade, ..._oportunidades];
            _paginaAtual = 0;
          });
        },
      ),
      SalvosPage(
        oportunidades: _oportunidades
            .where((op) => _idsSalvos.contains(op.id))
            .toList(),
        idsSalvos: _idsSalvos,
        aoAlternarSalvo: _alternarSalvo,
        aoAbrirDetalhes: _abrirDetalhes,
      ),
      const PerfilPage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _paginaAtual,
          children: paginas,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: modoEscuro
                  ? (altoContraste ? Colors.white : bordaEscura)
                  : (altoContraste ? florestaEscuro : linha),
              width: altoContraste ? 1.5 : 1.0,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: indiceVisual,
          backgroundColor: modoEscuro
              ? (altoContraste ? Colors.black : superficieEscura)
              : (altoContraste ? Colors.white : papel),
          indicatorColor: lima,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (visualIndex) {
            if (visualIndex == 1) {
              _abrirCentralLibras(context);
              return;
            }

            setState(() {
              _paginaAtual = switch (visualIndex) {
                0 => 0,
                2 => 1,
                3 => 2,
                4 => 3,
                _ => 0,
              };
            });
          },
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Início',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.sign_language_rounded,
              ),
              selectedIcon: const Icon(
                Icons.sign_language_rounded,
                color: florestaEscuro,
              ),
              label: 'Libras',
            ),
            const NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore_rounded),
              label: 'Explorar',
            ),
            const NavigationDestination(
              icon: Icon(Icons.add_circle_outline),
              selectedIcon: Icon(Icons.add_circle_rounded),
              label: 'Publicar',
            ),
            const NavigationDestination(
              icon: Icon(Icons.bookmark_outline),
              selectedIcon: Icon(Icons.bookmark_rounded),
              label: 'Salvos',
            ),
          ],
        ),
      ),
    );
  }
}