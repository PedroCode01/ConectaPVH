import 'package:flutter/material.dart';
import '../constants/cores.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final configuracoes = <(IconData, String, String)>[
      (Icons.person_outline_rounded, 'Dados do perfil', 'Personalize suas informações'),
      (Icons.notifications_none_rounded, 'Notificações', 'Novidades e oportunidades'),
      (Icons.location_on_outlined, 'Minha região', 'Porto Velho, Rondônia'),
      (Icons.shield_outlined, 'Privacidade e segurança', 'Cuide dos seus dados'),
      (Icons.help_outline_rounded, 'Ajuda e suporte', 'Estamos aqui para ajudar'),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: floresta,
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: lima,
                child: Icon(Icons.person_rounded, color: floresta, size: 34),
              ),
              SizedBox(height: 16),
              Text(
                'Olá, vizinho(a)!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Faça parte de uma comunidade que se conecta.',
                style: TextStyle(color: Color(0xFFDCE9E0), height: 1.4),
              ),
              SizedBox(height: 18),
              Text(
                'PERFIL DEMONSTRATIVO',
                style: TextStyle(
                  color: lima,
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                  letterSpacing: 1.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'Preferências',
          style: TextStyle(
            color: florestaEscuro,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        ...configuracoes.map(
          (item) => Card(
            color: papel,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: linha),
            ),
            child: ListTile(
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: creme,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(item.$1, color: floresta),
              ),
              title: Text(
                item.$2,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: florestaEscuro,
                ),
              ),
              subtitle: Text(
                item.$3,
                style: const TextStyle(color: fosco, fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right_rounded, color: fosco),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.$2}: recurso demonstrativo.')),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'ConectaPVH • Versão 1.0.0',
          textAlign: TextAlign.center,
          style: TextStyle(color: fosco, fontSize: 11),
        ),
      ],
    );
  }
}