import 'package:flutter/material.dart';
import '../constants/cores.dart';
import '../models/configuracoes_acessibilidade.dart';

class AcessibilidadePage extends StatelessWidget {
  const AcessibilidadePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AcessibilidadeScope.of(context);
    final escalaFonte = controller.escalaFonte;
    final altoContraste = controller.altoContraste;
    final reduzirAnimacoes = controller.reduzirAnimacoes;
    final modoEscuro = controller.modoEscuro;

    const superficieEscura = Color(0xFF132238);
    const bordaEscura = Color(0xFF233A5C);
    const subtextoEscuro = Color(0xFF9FB3C8);

    final corFundoCard = modoEscuro
        ? (altoContraste ? Colors.black : superficieEscura)
        : (altoContraste ? creme : papel);
    final corBordaCard = modoEscuro
        ? (altoContraste ? Colors.white : bordaEscura)
        : (altoContraste ? florestaEscuro : linha);
    final corTextoPrincipal = modoEscuro
        ? Colors.white
        : (altoContraste ? Colors.black : florestaEscuro);
    final corSubtexto = modoEscuro ? subtextoEscuro : fosco;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acessibilidade',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.restaurarPadrao();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Preferências restauradas para o padrão.'),
                ),
              );
            },
            child: const Text('Padrão'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: floresta,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: lima,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'INCLUSÃO E CONFORTO',
                    style: TextStyle(
                      color: florestaEscuro,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Adapte o app ao seu ritmo.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'As alterações aplicadas aqui refletem em todo o aplicativo.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Card(
            color: corFundoCard,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: corBordaCard),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tamanho do texto',
                        style: TextStyle(
                          color: corTextoPrincipal,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${(escalaFonte * 100).round()}%',
                        style: TextStyle(
                          color: modoEscuro ? lima : floresta,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Prévia: Boas coisas acontecem em Porto Velho.',
                    style: TextStyle(color: corTextoPrincipal, fontSize: 12),
                  ),
                  Slider(
                    value: escalaFonte,
                    min: 0.9,
                    max: 1.3,
                    divisions: 4,
                    activeColor: modoEscuro ? lima : floresta,
                    onChanged: controller.atualizarEscalaFonte,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: corFundoCard,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: corBordaCard),
            ),
            child: SwitchListTile(
              activeTrackColor: modoEscuro ? lima : floresta,
              title: Text(
                'Modo escuro',
                style: TextStyle(
                  color: corTextoPrincipal,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                'Reduz o brilho da tela para ambientes com pouca luz',
                style: TextStyle(color: corSubtexto, fontSize: 12),
              ),
              value: modoEscuro,
              onChanged: controller.atualizarModoEscuro,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: corFundoCard,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: corBordaCard),
            ),
            child: SwitchListTile(
              activeTrackColor: modoEscuro ? lima : floresta,
              title: Text(
                'Alto contraste',
                style: TextStyle(
                  color: corTextoPrincipal,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                'Aumenta o destaque entre textos, fundos e bordas',
                style: TextStyle(color: corSubtexto, fontSize: 12),
              ),
              value: altoContraste,
              onChanged: controller.atualizarAltoContraste,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: corFundoCard,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: corBordaCard),
            ),
            child: SwitchListTile(
              activeTrackColor: modoEscuro ? lima : floresta,
              title: Text(
                'Reduzir animações',
                style: TextStyle(
                  color: corTextoPrincipal,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                'Minimiza movimentos de transição na interface',
                style: TextStyle(color: corSubtexto, fontSize: 12),
              ),
              value: reduzirAnimacoes,
              onChanged: controller.atualizarReduzirAnimacoes,
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Preferências ativas em todo o aplicativo!',
                  ),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: modoEscuro ? lima : floresta,
              foregroundColor: modoEscuro ? florestaEscuro : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Confirmar preferências'),
          ),
        ],
      ),
    );
  }
}