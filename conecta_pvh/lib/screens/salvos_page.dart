import 'package:flutter/material.dart';
import '../constants/cores.dart';
import '../models/oportunidade.dart';
import '../widgets/cartao_oportunidade.dart';

class SalvosPage extends StatelessWidget {
  const SalvosPage({
    super.key,
    required this.oportunidades,
    required this.idsSalvos,
    required this.aoAlternarSalvo,
    required this.aoAbrirDetalhes,
  });

  final List<Oportunidade> oportunidades;
  final Set<int> idsSalvos;
  final ValueChanged<Oportunidade> aoAlternarSalvo;
  final ValueChanged<Oportunidade> aoAbrirDetalhes;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const Text(
          'Seus salvos',
          style: TextStyle(
            color: florestaEscuro,
            fontSize: 31,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.7,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Guarde o que chamou sua atenção.',
          style: TextStyle(color: fosco),
        ),
        const SizedBox(height: 22),
        if (oportunidades.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: Text(
                'Você ainda não salvou oportunidades. Toque no marcador de uma oportunidade para guardá-la aqui.',
                textAlign: TextAlign.center,
                style: TextStyle(color: fosco, fontSize: 13),
              ),
            ),
          )
        else
          ...oportunidades.map(
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
      ],
    );
  }
}