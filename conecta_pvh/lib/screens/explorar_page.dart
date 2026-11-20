import 'package:flutter/material.dart';
import '../constants/cores.dart';
import '../models/oportunidade.dart';
import '../widgets/cartao_oportunidade.dart';

class ExplorarPage extends StatefulWidget {
  const ExplorarPage({
    super.key,
    required this.termoBusca,
    required this.aoMudarBusca,
    required this.categoriaSelecionada,
    required this.aoMudarCategoria,
    required this.oportunidades,
    required this.idsSalvos,
    required this.aoAlternarSalvo,
    required this.aoAbrirDetalhes,
  });

  final String termoBusca;
  final ValueChanged<String> aoMudarBusca;
  final String categoriaSelecionada;
  final ValueChanged<String> aoMudarCategoria;
  final List<Oportunidade> oportunidades;
  final Set<int> idsSalvos;
  final ValueChanged<Oportunidade> aoAlternarSalvo;
  final ValueChanged<Oportunidade> aoAbrirDetalhes;

  @override
  State<ExplorarPage> createState() => _ExplorarPageState();
}

class _ExplorarPageState extends State<ExplorarPage> {
  late final TextEditingController _buscaController;

  @override
  void initState() {
    super.initState();
    _buscaController = TextEditingController(text: widget.termoBusca);
  }

  @override
  void didUpdateWidget(covariant ExplorarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.termoBusca != _buscaController.text) {
      _buscaController.value = TextEditingValue(
        text: widget.termoBusca,
        selection: TextSelection.collapsed(offset: widget.termoBusca.length),
      );
    }
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const Text(
                'Explore',
                style: TextStyle(
                  color: florestaEscuro,
                  fontSize: 31,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.7,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Oportunidades que movimentam a cidade.',
                style: TextStyle(color: fosco),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _buscaController,
                onChanged: widget.aoMudarBusca,
                decoration: const InputDecoration(
                  hintText: 'O que você está procurando?',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categorias.map((cat) {
                  final selecionada = cat == widget.categoriaSelecionada;
                  return ChoiceChip(
                    avatar: Icon(
                      iconeDaCategoria(cat),
                      size: 16,
                      color: florestaEscuro,
                    ),
                    showCheckmark: false,
                    label: Text(cat),
                    selected: selecionada,
                    onSelected: (_) => widget.aoMudarCategoria(cat),
                    selectedColor: lima,
                    backgroundColor: papel,
                    side: BorderSide(color: selecionada ? lima : linha),
                    labelStyle: TextStyle(
                      color: florestaEscuro,
                      fontWeight:
                          selecionada ? FontWeight.w800 : FontWeight.w500,
                      fontSize: 12,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              Text(
                '${widget.oportunidades.length} resultados',
                style: const TextStyle(
                  color: fosco,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              if (widget.oportunidades.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'Tente mudar os termos da busca ou a categoria.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: fosco, fontSize: 13),
                    ),
                  ),
                )
              else
                ...widget.oportunidades.map(
                  (op) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CartaoOportunidade(
                      oportunidade: op,
                      estaSalvo: widget.idsSalvos.contains(op.id),
                      aoTocar: () => widget.aoAbrirDetalhes(op),
                      aoAlternarSalvo: () => widget.aoAlternarSalvo(op),
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ],
    );
  }
}