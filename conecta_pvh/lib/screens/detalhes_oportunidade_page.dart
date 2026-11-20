
import 'package:flutter/material.dart';
import '../constants/cores.dart';
import '../models/oportunidade.dart';

class DetalhesOportunidadePage extends StatelessWidget {
  const DetalhesOportunidadePage({
    super.key,
    required this.oportunidade,
    required this.estaSalvo,
    required this.aoAlternarSalvo,
  });

  final Oportunidade oportunidade;
  final bool estaSalvo;
  final VoidCallback aoAlternarSalvo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        actions: [
          IconButton(
            onPressed: aoAlternarSalvo,
            icon: Icon(
              estaSalvo ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              color: oportunidade.corFundo,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 10,
                  bottom: -14,
                  child: Icon(
                    oportunidade.icone,
                    size: 170,
                    color: floresta.withValues(alpha: 0.13),
                  ),
                ),
                Center(
                  child: Icon(oportunidade.icone, size: 76, color: floresta),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      oportunidade.categoria,
                      style: const TextStyle(
                        color: floresta,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            oportunidade.titulo,
            style: const TextStyle(
              color: florestaEscuro,
              fontWeight: FontWeight.w900,
              fontSize: 28,
              height: 1.12,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: papel,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: linha),
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: floresta,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quando',
                    style: TextStyle(
                      color: fosco,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    oportunidade.data,
                    style: const TextStyle(
                      color: florestaEscuro,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: papel,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: linha),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: floresta,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Onde',
                    style: TextStyle(
                      color: fosco,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    oportunidade.local,
                    style: const TextStyle(
                      color: florestaEscuro,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Sobre esta oportunidade',
            style: TextStyle(
              color: florestaEscuro,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            oportunidade.descricao,
            style: const TextStyle(color: fosco, fontSize: 15, height: 1.6),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Interessado(a)?'),
                content: const Text(
                  'Esta versão é demonstrativa. O contato e a inscrição serão conectados em uma próxima etapa.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Entendi'),
                  ),
                ],
              ),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: floresta,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Participar ou saber mais'),
          ),
        ],
      ),
    );
  }
}