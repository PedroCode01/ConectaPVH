import 'package:flutter/material.dart';
import '../constants/cores.dart';
import '../models/configuracoes_acessibilidade.dart';
import '../models/oportunidade.dart';
import '../widgets/cartao_oportunidade.dart';
import 'acessibilidade_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.termoBusca,
    required this.aoMudarBusca,
    required this.categoriaSelecionada,
    required this.aoMudarCategoria,
    required this.oportunidades,
    required this.idsSalvos,
    required this.aoAlternarSalvo,
    required this.aoAbrirDetalhes,
    required this.aoIrParaPublicar,
  });

  final String termoBusca;
  final ValueChanged<String> aoMudarBusca;
  final String categoriaSelecionada;
  final ValueChanged<String> aoMudarCategoria;
  final List<Oportunidade> oportunidades;
  final Set<int> idsSalvos;
  final ValueChanged<Oportunidade> aoAlternarSalvo;
  final ValueChanged<Oportunidade> aoAbrirDetalhes;
  final VoidCallback aoIrParaPublicar;

  @override
  Widget build(BuildContext context) {
    final acessibilidade = AcessibilidadeScope.of(context);
    final modoEscuro = acessibilidade.modoEscuro;
    final altoContraste = acessibilidade.altoContraste;

    const superficieEscura = Color(0xFF132238);
    const bordaEscura = Color(0xFF233A5C);
    const subtextoEscuro = Color(0xFF9FB3C8);

    final corTitulo = modoEscuro
        ? Colors.white
        : (altoContraste ? Colors.black : florestaEscuro);
    final corSubtexto = modoEscuro ? subtextoEscuro : fosco;
    final corChipFundo = modoEscuro
        ? (altoContraste ? Colors.black : superficieEscura)
        : (altoContraste ? Colors.white : papel);
    final corChipBorda = modoEscuro
        ? (altoContraste ? Colors.white : bordaEscura)
        : (altoContraste ? florestaEscuro : linha);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'assets/images/logo_conectapvh.png',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      semanticLabel: 'Logo ConectaPVH',
                      errorBuilder: (_, __, ___) => Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: floresta,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.hub_rounded,
                          color: lima,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'PORTO VELHO • RO',
                    style: TextStyle(
                      color: corSubtexto,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Acessibilidade',
                    iconSize: 28,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(52, 52),
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const AcessibilidadePage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.accessibility_new_rounded,
                      color: modoEscuro ? lima : floresta,
                      semanticLabel: 'Acessibilidade',
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    tooltip: 'Notificações',
                    iconSize: 28,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(52, 52),
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Notificações estarão disponíveis em uma próxima versão.',
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: modoEscuro ? Colors.white : floresta,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: floresta,
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [floresta, florestaEscuro],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: altoContraste
                      ? Border.all(color: lima, width: 1.5)
                      : null,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -12,
                      top: -12,
                      child: Icon(
                        Icons.eco_rounded,
                        size: 112,
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: lima,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'SUA CIDADE, MAIS PERTO',
                            style: TextStyle(
                              color: florestaEscuro,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 17),
                        const Text(
                          'Boas coisas\nacontecem perto.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 29,
                            height: 1.08,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.7,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Descubra oportunidades e faça parte da mudança.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            height: 1.4,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 18),
                        OutlinedButton.icon(
                          onPressed: aoIrParaPublicar,
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: const Text('Compartilhar oportunidade'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: florestaEscuro,
                            backgroundColor: lima,
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: aoMudarBusca,
                decoration: const InputDecoration(
                  hintText: 'Buscar oportunidades, cursos...',
                  prefixIcon: Icon(Icons.search_rounded),
                  suffixIcon: Icon(Icons.tune_rounded),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Explore por categoria',
                style: TextStyle(
                  color: corTitulo,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Encontre o que combina com você',
                style: TextStyle(color: corSubtexto, fontSize: 12),
              ),
              const SizedBox(height: 13),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categorias.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final categoria = categorias[index];
                    final selecionada = categoria == categoriaSelecionada;
                    return ChoiceChip(
                      avatar: Icon(
                        iconeDaCategoria(categoria),
                        size: 16,
                        color: selecionada
                            ? florestaEscuro
                            : (modoEscuro ? lima : florestaEscuro),
                      ),
                      showCheckmark: false,
                      label: Text(categoria),
                      selected: selecionada,
                      onSelected: (_) => aoMudarCategoria(categoria),
                      selectedColor: lima,
                      backgroundColor: corChipFundo,
                      side: BorderSide(
                        color: selecionada ? lima : corChipBorda,
                      ),
                      labelStyle: TextStyle(
                        color: selecionada
                            ? florestaEscuro
                            : (modoEscuro ? Colors.white : florestaEscuro),
                        fontWeight: selecionada
                            ? FontWeight.w800
                            : FontWeight.w500,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perto de você',
                        style: TextStyle(
                          color: corTitulo,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        '${oportunidades.length} oportunidades para descobrir',
                        style: TextStyle(color: corSubtexto, fontSize: 12),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => aoMudarCategoria('Todas'),
                    child: const Text('Ver todas'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (oportunidades.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'Não encontramos oportunidades com esses filtros.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: corSubtexto, fontSize: 13),
                    ),
                  ),
                )
              else
                ...oportunidades.take(4).map(
                  (op) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CartaoOportunidade(
                      oportunidade: op,
                      estaSalvo: idsSalvos.contains(op.id),
                      aoTocar: () => aoAbrirDetalhes(op),
                      aoAlternarSalvo: () => aoAlternarSalvo(op),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                'Feito com carinho para Porto Velho 💚',
                textAlign: TextAlign.center,
                style: TextStyle(color: corSubtexto, fontSize: 11),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}