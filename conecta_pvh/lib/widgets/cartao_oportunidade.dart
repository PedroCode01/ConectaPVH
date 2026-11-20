import 'package:flutter/material.dart';
import '../constants/cores.dart';
import '../models/oportunidade.dart';

class CartaoOportunidade extends StatelessWidget {
  const CartaoOportunidade({
    super.key,
    required this.oportunidade,
    required this.estaSalvo,
    required this.aoTocar,
    required this.aoAlternarSalvo,
  });

  final Oportunidade oportunidade;
  final bool estaSalvo;
  final VoidCallback aoTocar;
  final VoidCallback aoAlternarSalvo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: papel,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: linha)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: aoTocar,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: oportunidade.corFundo, borderRadius: BorderRadius.circular(16)),
                child: Icon(oportunidade.icone, color: lima, size:26,),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(oportunidade.categoria.toUpperCase(), style: const TextStyle(color: fosco, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1)),
                    const SizedBox(height: 3),
                    Text(oportunidade.titulo, style: const TextStyle(color: florestaEscuro, fontSize: 15, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: fosco),
                        const SizedBox(width: 4),
                        Expanded(child: Text(oportunidade.local, style: const TextStyle(color: fosco, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: aoAlternarSalvo,
                icon: Icon(estaSalvo ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: floresta),
              ),
            ],
          ),
        ),
      ),
    );
  }
}