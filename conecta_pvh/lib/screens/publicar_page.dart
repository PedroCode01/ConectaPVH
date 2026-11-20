import 'package:flutter/material.dart';
import '../constants/cores.dart';

class PublicarPage extends StatefulWidget {
  const PublicarPage({super.key, required this.aoPublicar});

  final void Function({
    required String titulo,
    required String categoria,
    required String local,
    required String descricao,
  }) aoPublicar;

  @override
  State<PublicarPage> createState() => _PublicarPageState();
}

class _PublicarPageState extends State<PublicarPage> {
  final chaveFormulario = GlobalKey<FormState>();
  final tituloController = TextEditingController();
  final localController = TextEditingController(text: 'Porto Velho, RO');
  final descricaoController = TextEditingController();
  String categoria = 'Comunidade';

  @override
  void dispose() {
    tituloController.dispose();
    localController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      children: [
        const Text(
          'Compartilhe algo bom.',
          style: TextStyle(
            color: florestaEscuro,
            fontSize: 29,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Sua oportunidade pode transformar o dia de alguém.',
          style: TextStyle(color: fosco, height: 1.4),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF0E3),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline_rounded, color: floresta, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Publique oportunidades verdadeiras, com informações claras e um local de contato quando possível.',
                  style: TextStyle(
                    color: florestaEscuro,
                    height: 1.4,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Form(
          key: chaveFormulario,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Título da oportunidade',
                style: TextStyle(
                  color: florestaEscuro,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              TextFormField(
                controller: tituloController,
                validator: (val) =>
                    (val == null || val.trim().isEmpty)
                        ? 'Informe um título.'
                        : null,
                decoration: const InputDecoration(
                  hintText: 'Ex.: Oficina de informática gratuita',
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Categoria',
                style: TextStyle(
                  color: florestaEscuro,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              DropdownButtonFormField<String>(
                initialValue: categoria,
                decoration: const InputDecoration(),
                items: categorias
                    .where((item) => item != 'Todas')
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => categoria = val ?? 'Comunidade'),
              ),
              const SizedBox(height: 18),
              const Text(
                'Local',
                style: TextStyle(
                  color: florestaEscuro,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              TextFormField(
                controller: localController,
                decoration: const InputDecoration(
                  hintText: 'Bairro, rua ou espaço',
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Descrição',
                style: TextStyle(
                  color: florestaEscuro,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 7),
              TextFormField(
                controller: descricaoController,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText:
                      'Conte os detalhes, quem pode participar e como se inscrever...',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    if (!chaveFormulario.currentState!.validate()) return;
                    widget.aoPublicar(
                      titulo: tituloController.text.trim(),
                      categoria: categoria,
                      local: localController.text.trim(),
                      descricao: descricaoController.text.trim(),
                    );
                    tituloController.clear();
                    descricaoController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Oportunidade publicada nesta sessão!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.publish_rounded),
                  label: const Text('Publicar oportunidade'),
                  style: FilledButton.styleFrom(
                    backgroundColor: floresta,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Protótipo: os dados ficam apenas na memória enquanto o app está aberto.',
                textAlign: TextAlign.center,
                style: TextStyle(color: fosco, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }
}