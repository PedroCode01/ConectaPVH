import 'package:flutter/material.dart';

void main() {
  runApp(const ConectaPVHApp());
}

const Color forest = Color(0xFF174D3A);
const Color forestDark = Color(0xFF103829);
const Color lime = Color(0xFFC8F169);
const Color cream = Color(0xFFF7F5EC);
const Color paper = Color(0xFFFFFFFF);
const Color muted = Color(0xFF68766F);
const Color line = Color(0xFFE4E8E0);

class ConectaPVHApp extends StatelessWidget {
  const ConectaPVHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConectaPVH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          primary: forest,
          secondary: lime,
          surface: cream,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: cream,
          foregroundColor: forestDark,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: paper,
          hintStyle: const TextStyle(color: muted),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: line),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: line),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: forest, width: 1.5),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class Opportunity {
  Opportunity({
    required this.id,
    required this.title,
    required this.category,
    required this.place,
    required this.date,
    required this.description,
    required this.icon,
    required this.tint,
    this.isCommunity = true,
  });

  final int id;
  final String title;
  final String category;
  final String place;
  final String date;
  final String description;
  final IconData icon;
  final Color tint;
  final bool isCommunity;
}

final List<Opportunity> starterOpportunities = [
  Opportunity(
    id: 1,
    title: 'Mutirão de limpeza do igarapé',
    category: 'Voluntariado',
    place: 'Parque Circuito, Porto Velho',
    date: 'Sáb, 8h30',
    description:
        'Junte-se aos moradores para cuidar dos espaços verdes da nossa cidade. Luvas e sacos serão disponibilizados pela organização.',
    icon: Icons.park_rounded,
    tint: Color(0xFFDCEBCB),
  ),
  Opportunity(
    id: 2,
    title: 'Oficina gratuita de currículo',
    category: 'Cursos',
    place: 'Biblioteca Municipal',
    date: 'Ter, 14h',
    description:
        'Aprenda a organizar seu currículo, destacar suas habilidades e se preparar melhor para entrevistas de emprego.',
    icon: Icons.school_rounded,
    tint: Color(0xFFF1E4BE),
  ),
  Opportunity(
    id: 3,
    title: 'Feira de empreendedores locais',
    category: 'Comunidade',
    place: 'Praça das Três Caixas d’Água',
    date: 'Dom, 16h',
    description:
        'Conheça pequenos negócios de Porto Velho, descubra produtos feitos na região e fortaleça a economia local.',
    icon: Icons.storefront_rounded,
    tint: Color(0xFFF3D9CD),
  ),
  Opportunity(
    id: 4,
    title: 'Vaga: assistente administrativo',
    category: 'Empregos',
    place: 'Centro, Porto Velho',
    date: 'Inscrições abertas',
    description:
        'Oportunidade para pessoa organizada, com boa comunicação e conhecimentos básicos de informática. Consulte os requisitos com o anunciante.',
    icon: Icons.work_outline_rounded,
    tint: Color(0xFFD9E6EE),
  ),
  Opportunity(
    id: 5,
    title: 'Aula aberta de dança',
    category: 'Eventos',
    place: 'Espaço cultural do bairro',
    date: 'Sex, 19h',
    description:
        'Uma atividade aberta para todas as idades. Venha conhecer pessoas, se movimentar e aproveitar uma noite em comunidade.',
    icon: Icons.music_note_rounded,
    tint: Color(0xFFE8DDF1),
  ),
];

const List<String> categories = [
  'Todas',
  'Empregos',
  'Cursos',
  'Eventos',
  'Voluntariado',
  'Comunidade',
];

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedTab = 0;
  String query = '';
  String selectedCategory = 'Todas';
  final Set<int> savedIds = <int>{1, 3};

  List<Opportunity> get filteredOpportunities {
    return starterOpportunities.where((opportunity) {
      final matchesCategory = selectedCategory == 'Todas' ||
          opportunity.category == selectedCategory;
      final normalizedQuery = query.trim().toLowerCase();
      final matchesQuery = normalizedQuery.isEmpty ||
          opportunity.title.toLowerCase().contains(normalizedQuery) ||
          opportunity.place.toLowerCase().contains(normalizedQuery) ||
          opportunity.category.toLowerCase().contains(normalizedQuery);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void toggleSaved(Opportunity opportunity) {
    setState(() {
      if (savedIds.contains(opportunity.id)) {
        savedIds.remove(opportunity.id);
      } else {
        savedIds.add(opportunity.id);
      }
    });
  }

  void addOpportunity({
    required String title,
    required String category,
    required String place,
    required String description,
  }) {
    setState(() {
      starterOpportunities.insert(
        0,
        Opportunity(
          id: DateTime.now().microsecondsSinceEpoch,
          title: title,
          category: category,
          place: place.isEmpty ? 'Porto Velho, RO' : place,
          date: 'Publicado agora',
          description: description.isEmpty
              ? 'Mais informações serão adicionadas pelo anunciante.'
              : description,
          icon: category == 'Empregos'
              ? Icons.work_outline_rounded
              : category == 'Cursos'
                  ? Icons.school_rounded
                  : category == 'Eventos'
                      ? Icons.event_rounded
                      : Icons.volunteer_activism_rounded,
          tint: const Color(0xFFDCEBCB),
        ),
      );
      selectedTab = 0;
      selectedCategory = 'Todas';
      query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(
        query: query,
        onQueryChanged: (value) => setState(() => query = value),
        selectedCategory: selectedCategory,
        onCategoryChanged: (value) =>
            setState(() => selectedCategory = value),
        opportunities: filteredOpportunities,
        savedIds: savedIds,
        onToggleSaved: toggleSaved,
        onOpenOpportunity: _openOpportunity,
        onPublish: () => setState(() => selectedTab = 2),
      ),
      ExplorePage(
        query: query,
        onQueryChanged: (value) => setState(() => query = value),
        selectedCategory: selectedCategory,
        onCategoryChanged: (value) =>
            setState(() => selectedCategory = value),
        opportunities: filteredOpportunities,
        savedIds: savedIds,
        onToggleSaved: toggleSaved,
        onOpenOpportunity: _openOpportunity,
      ),
      PublishPage(onPublish: addOpportunity),
      SavedPage(
        opportunities: starterOpportunities
            .where((opportunity) => savedIds.contains(opportunity.id))
            .toList(),
        savedIds: savedIds,
        onToggleSaved: toggleSaved,
        onOpenOpportunity: _openOpportunity,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: selectedTab, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) => setState(() => selectedTab = index),
        backgroundColor: paper,
        indicatorColor: lime.withValues(alpha: 0.65),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore_rounded), label: 'Explorar'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline_rounded), selectedIcon: Icon(Icons.add_circle_rounded), label: 'Publicar'),
          NavigationDestination(icon: Icon(Icons.bookmark_border_rounded), selectedIcon: Icon(Icons.bookmark_rounded), label: 'Salvos'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Perfil'),
        ],
      ),
    );
  }

  void _openOpportunity(Opportunity opportunity) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => OpportunityDetailPage(
          opportunity: opportunity,
          isSaved: savedIds.contains(opportunity.id),
          onToggleSaved: () => toggleSaved(opportunity),
        ),
      ),
    ).then((_) => setState(() {}));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.query,
    required this.onQueryChanged,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.opportunities,
    required this.savedIds,
    required this.onToggleSaved,
    required this.onOpenOpportunity,
    required this.onPublish,
  });

  final String query;
  final ValueChanged<String> onQueryChanged;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final List<Opportunity> opportunities;
  final Set<int> savedIds;
  final ValueChanged<Opportunity> onToggleSaved;
  final ValueChanged<Opportunity> onOpenOpportunity;
  final VoidCallback onPublish;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.hub_rounded, color: lime, size: 25),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('conectaPVH', style: TextStyle(color: forest, fontWeight: FontWeight.w900, fontSize: 19, letterSpacing: -0.5)),
                      Text('PORTO VELHO • RO', style: TextStyle(color: muted, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.4)),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notificações estarão disponíveis em uma próxima versão.'))),
                    icon: const Icon(Icons.notifications_none_rounded, color: forest),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: forest,
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(colors: [forest, forestDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Stack(
                  children: [
                    Positioned(right: -12, top: -12, child: Icon(Icons.eco_rounded, size: 112, color: Colors.white.withValues(alpha: 0.07))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: lime, borderRadius: BorderRadius.circular(30)),
                          child: const Text('SUA CIDADE, MAIS PERTO', style: TextStyle(color: forestDark, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
                        ),
                        const SizedBox(height: 17),
                        const Text('Boas coisas\nacontecem perto.', style: TextStyle(color: Colors.white, fontSize: 29, height: 1.08, fontWeight: FontWeight.w800, letterSpacing: -0.7)),
                        const SizedBox(height: 10),
                        Text('Descubra oportunidades e faça parte da mudança.', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), height: 1.4, fontSize: 13)),
                        const SizedBox(height: 18),
                        OutlinedButton.icon(
                          onPressed: onPublish,
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: const Text('Compartilhar oportunidade'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: forestDark,
                            backgroundColor: lime,
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: onQueryChanged,
                decoration: const InputDecoration(
                  hintText: 'Buscar oportunidades, cursos...',
                  prefixIcon: Icon(Icons.search_rounded),
                  suffixIcon: Icon(Icons.tune_rounded),
                ),
              ),
              const SizedBox(height: 24),
              const SectionHeading(title: 'Explore por categoria', subtitle: 'Encontre o que combina com você'),
              const SizedBox(height: 13),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final selected = category == selectedCategory;
                    return ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      onSelected: (_) => onCategoryChanged(category),
                      selectedColor: lime,
                      backgroundColor: paper,
                      side: BorderSide(color: selected ? lime : line),
                      labelStyle: TextStyle(color: forestDark, fontWeight: selected ? FontWeight.w800 : FontWeight.w500, fontSize: 12),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SectionHeading(
                title: 'Perto de você',
                subtitle: '${opportunities.length} oportunidades para descobrir',
                trailing: TextButton(onPressed: () => onCategoryChanged('Todas'), child: const Text('Ver todas')),
              ),
              const SizedBox(height: 8),
              if (opportunities.isEmpty)
                const EmptyState(message: 'Não encontramos oportunidades com esses filtros.')
              else
                ...opportunities.take(4).map((opportunity) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OpportunityCard(
                    opportunity: opportunity,
                    isSaved: savedIds.contains(opportunity.id),
                    onTap: () => onOpenOpportunity(opportunity),
                    onToggleSaved: () => onToggleSaved(opportunity),
                  ),
                )),
              const SizedBox(height: 10),
              const Text('Feito com carinho para Porto Velho 💚', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 11)),
            ]),
          ),
        ),
      ],
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({
    super.key,
    required this.query,
    required this.onQueryChanged,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.opportunities,
    required this.savedIds,
    required this.onToggleSaved,
    required this.onOpenOpportunity,
  });

  final String query;
  final ValueChanged<String> onQueryChanged;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final List<Opportunity> opportunities;
  final Set<int> savedIds;
  final ValueChanged<Opportunity> onToggleSaved;
  final ValueChanged<Opportunity> onOpenOpportunity;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const Text('Explore', style: TextStyle(color: forestDark, fontSize: 31, fontWeight: FontWeight.w900, letterSpacing: -0.7)),
              const SizedBox(height: 5),
              const Text('Oportunidades que movimentam a cidade.', style: TextStyle(color: muted)),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: query)..selection = TextSelection.collapsed(offset: query.length),
                onChanged: onQueryChanged,
                decoration: const InputDecoration(hintText: 'O que você está procurando?', prefixIcon: Icon(Icons.search_rounded)),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((category) => ChoiceChip(
                  label: Text(category),
                  selected: category == selectedCategory,
                  onSelected: (_) => onCategoryChanged(category),
                  selectedColor: lime,
                  backgroundColor: paper,
                  side: const BorderSide(color: line),
                )).toList(),
              ),
              const SizedBox(height: 22),
              Text('${opportunities.length} resultados', style: const TextStyle(color: muted, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              if (opportunities.isEmpty)
                const EmptyState(message: 'Tente mudar os termos da busca ou a categoria.')
              else
                ...opportunities.map((opportunity) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OpportunityCard(
                    opportunity: opportunity,
                    isSaved: savedIds.contains(opportunity.id),
                    onTap: () => onOpenOpportunity(opportunity),
                    onToggleSaved: () => onToggleSaved(opportunity),
                  ),
                )),
            ]),
          ),
        ),
      ],
    );
  }
}

class PublishPage extends StatefulWidget {
  const PublishPage({super.key, required this.onPublish});

  final void Function({required String title, required String category, required String place, required String description}) onPublish;

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final placeController = TextEditingController(text: 'Porto Velho, RO');
  final descriptionController = TextEditingController();
  String category = 'Comunidade';

  @override
  void dispose() {
    titleController.dispose();
    placeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      children: [
        const Text('Compartilhe algo bom.', style: TextStyle(color: forestDark, fontSize: 29, fontWeight: FontWeight.w900, letterSpacing: -0.8)),
        const SizedBox(height: 7),
        const Text('Sua oportunidade pode transformar o dia de alguém.', style: TextStyle(color: muted, height: 1.4)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(color: const Color(0xFFEAF0E3), borderRadius: BorderRadius.circular(18)),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline_rounded, color: forest, size: 24),
              SizedBox(width: 12),
              Expanded(child: Text('Publique oportunidades verdadeiras, com informações claras e um local de contato quando possível.', style: TextStyle(color: forestDark, height: 1.4, fontSize: 12))),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel('Título da oportunidade'),
              TextFormField(
                controller: titleController,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Informe um título.' : null,
                decoration: const InputDecoration(hintText: 'Ex.: Oficina de informática gratuita'),
              ),
              const SizedBox(height: 18),
              const FieldLabel('Categoria'),
              DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(),
                items: categories.where((item) => item != 'Todas').map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
                onChanged: (value) => setState(() => category = value ?? 'Comunidade'),
              ),
              const SizedBox(height: 18),
              const FieldLabel('Local'),
              TextFormField(controller: placeController, decoration: const InputDecoration(hintText: 'Bairro, rua ou espaço')),
              const SizedBox(height: 18),
              const FieldLabel('Descrição'),
              TextFormField(
                controller: descriptionController,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(hintText: 'Conte os detalhes, quem pode participar e como se inscrever...'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    widget.onPublish(
                      title: titleController.text.trim(),
                      category: category,
                      place: placeController.text.trim(),
                      description: descriptionController.text.trim(),
                    );
                    titleController.clear();
                    descriptionController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Oportunidade publicada nesta sessão!')));
                  },
                  icon: const Icon(Icons.publish_rounded),
                  label: const Text('Publicar oportunidade'),
                  style: FilledButton.styleFrom(backgroundColor: forest, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 17)),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Protótipo: os dados ficam apenas na memória enquanto o app está aberto.', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({
    super.key,
    required this.opportunities,
    required this.savedIds,
    required this.onToggleSaved,
    required this.onOpenOpportunity,
  });

  final List<Opportunity> opportunities;
  final Set<int> savedIds;
  final ValueChanged<Opportunity> onToggleSaved;
  final ValueChanged<Opportunity> onOpenOpportunity;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const Text('Seus salvos', style: TextStyle(color: forestDark, fontSize: 31, fontWeight: FontWeight.w900, letterSpacing: -0.7)),
        const SizedBox(height: 5),
        const Text('Guarde o que chamou sua atenção.', style: TextStyle(color: muted)),
        const SizedBox(height: 22),
        if (opportunities.isEmpty)
          const EmptyState(message: 'Você ainda não salvou oportunidades. Toque no marcador de uma oportunidade para guardá-la aqui.')
        else
          ...opportunities.map((opportunity) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: OpportunityCard(
              opportunity: opportunity,
              isSaved: savedIds.contains(opportunity.id),
              onTap: () => onOpenOpportunity(opportunity),
              onToggleSaved: () => onToggleSaved(opportunity),
            ),
          )),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = <(IconData, String, String)>[
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
          decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(26)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 30, backgroundColor: lime, child: Icon(Icons.person_rounded, color: forest, size: 34)),
              SizedBox(height: 16),
              Text('Olá, vizinho(a)!', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900)),
              SizedBox(height: 6),
              Text('Faça parte de uma comunidade que se conecta.', style: TextStyle(color: Color(0xFFDCE9E0), height: 1.4)),
              SizedBox(height: 18),
              Text('PERFIL DEMONSTRATIVO', style: TextStyle(color: lime, fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 1.3)),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text('Preferências', style: TextStyle(color: forestDark, fontWeight: FontWeight.w900, fontSize: 18)),
        const SizedBox(height: 10),
        ...settings.map((item) => Card(
          color: paper,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: line)),
          child: ListTile(
            leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(13)), child: Icon(item.$1, color: forest)),
            title: Text(item.$2, style: const TextStyle(fontWeight: FontWeight.w700, color: forestDark)),
            subtitle: Text(item.$3, style: const TextStyle(color: muted, fontSize: 12)),
            trailing: const Icon(Icons.chevron_right_rounded, color: muted),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${item.$2}: recurso demonstrativo.'))),
          ),
        )),
        const SizedBox(height: 18),
        const Text('ConectaPVH • Versão 1.0.0', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 11)),
      ],
    );
  }
}

class OpportunityDetailPage extends StatelessWidget {
  const OpportunityDetailPage({
    super.key,
    required this.opportunity,
    required this.isSaved,
    required this.onToggleSaved,
  });

  final Opportunity opportunity;
  final bool isSaved;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        actions: [
          IconButton(
            onPressed: onToggleSaved,
            icon: Icon(isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(color: opportunity.tint, borderRadius: BorderRadius.circular(26)),
            child: Stack(
              children: [
                Positioned(right: 10, bottom: -14, child: Icon(opportunity.icon, size: 170, color: forest.withValues(alpha: 0.13))),
                Center(child: Icon(opportunity.icon, size: 76, color: forest)),
                Positioned(left: 16, top: 16, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(20)), child: Text(opportunity.category, style: const TextStyle(color: forest, fontWeight: FontWeight.w800, fontSize: 12)))),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(opportunity.title, style: const TextStyle(color: forestDark, fontWeight: FontWeight.w900, fontSize: 28, height: 1.12, letterSpacing: -0.5)),
          const SizedBox(height: 18),
          DetailInfo(icon: Icons.calendar_month_rounded, title: 'Quando', value: opportunity.date),
          const SizedBox(height: 12),
          DetailInfo(icon: Icons.location_on_outlined, title: 'Onde', value: opportunity.place),
          const SizedBox(height: 24),
          const Text('Sobre esta oportunidade', style: TextStyle(color: forestDark, fontWeight: FontWeight.w900, fontSize: 18)),
          const SizedBox(height: 8),
          Text(opportunity.description, style: const TextStyle(color: muted, fontSize: 15, height: 1.6)),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Interessado(a)?'),
                content: const Text('Esta versão é demonstrativa. O contato e a inscrição serão conectados em uma próxima etapa.'),
                actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Entendi'))],
              ),
            ),
            style: FilledButton.styleFrom(backgroundColor: forest, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
            child: const Text('Tenho interesse'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: onToggleSaved,
            icon: Icon(isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded),
            label: Text(isSaved ? 'Remover dos salvos' : 'Salvar oportunidade'),
            style: OutlinedButton.styleFrom(foregroundColor: forest, side: const BorderSide(color: forest), padding: const EdgeInsets.symmetric(vertical: 15)),
          ),
        ],
      ),
    );
  }
}

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    super.key,
    required this.opportunity,
    required this.isSaved,
    required this.onTap,
    required this.onToggleSaved,
  });

  final Opportunity opportunity;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: paper,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: line)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 76,
                height: 86,
                decoration: BoxDecoration(color: opportunity.tint, borderRadius: BorderRadius.circular(15)),
                child: Icon(opportunity.icon, color: forest, size: 34),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(opportunity.category.toUpperCase(), style: const TextStyle(color: forest, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    const SizedBox(height: 5),
                    Text(opportunity.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: forestDark, fontSize: 14, fontWeight: FontWeight.w800, height: 1.2)),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.location_on_outlined, size: 13, color: muted),
                      const SizedBox(width: 3),
                      Expanded(child: Text(opportunity.place, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: muted, fontSize: 10))),
                    ]),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.schedule_rounded, size: 13, color: muted),
                      const SizedBox(width: 3),
                      Expanded(child: Text(opportunity.date, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: muted, fontSize: 10))),
                    ]),
                  ],
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onToggleSaved,
                icon: Icon(isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: isSaved ? forest : muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, required this.subtitle, this.trailing});

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: forestDark, fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: -0.3)),
              const SizedBox(height: 3),
              Text(subtitle, style: const TextStyle(color: muted, fontSize: 11)),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(color: forestDark, fontWeight: FontWeight.w800, fontSize: 13)),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: paper, borderRadius: BorderRadius.circular(20), border: Border.all(color: line)),
      child: Column(
        children: [
          const Icon(Icons.search_off_rounded, size: 34, color: forest),
          const SizedBox(height: 10),
          Text(message, textAlign: TextAlign.center, style: const TextStyle(color: muted, height: 1.4)),
        ],
      ),
    );
  }
}

class DetailInfo extends StatelessWidget {
  const DetailInfo({super.key, required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 45, height: 45, decoration: BoxDecoration(color: const Color(0xFFEAF0E3), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: forest)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: muted, fontSize: 11)),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(color: forestDark, fontWeight: FontWeight.w800)),
        ])),
      ],
    );
  }
}
