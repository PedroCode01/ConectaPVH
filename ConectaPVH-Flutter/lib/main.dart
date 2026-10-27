import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color forest = Color(0xFF08634B);
const Color forestDark = Color(0xFF064E3B);
const Color canvas = Color(0xFFF7F8F6);
const Color ink = Color(0xFF17231F);
const Color muted = Color(0xFF6C7973);
const Color line = Color(0xFFE3E9E5);
const Color citrus = Color(0xFFF2B544);

void main() => runApp(const ConectaPvhApp());

class ConectaPvhApp extends StatelessWidget {
  const ConectaPvhApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: forest,
      brightness: Brightness.light,
      surface: Colors.white,
    );
    return MaterialApp(
      title: 'ConectaPVH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: canvas,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: canvas,
          foregroundColor: ink,
          elevation: 0,
          centerTitle: false,
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: forestDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: muted, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
      home: const HomeScreen(),
    );
  }
}

class Opportunity {
  const Opportunity({
    required this.id,
    required this.title,
    required this.host,
    required this.zone,
    required this.district,
    required this.category,
    required this.schedule,
    required this.age,
    required this.status,
    required this.address,
    required this.prerequisites,
    this.isCustom = false,
  });

  final int id;
  final String title;
  final String host;
  final String zone;
  final String district;
  final String category;
  final String schedule;
  final String age;
  final String status;
  final String address;
  final String prerequisites;
  final bool isCustom;

  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'host': host, 'zone': zone,
    'district': district, 'category': category, 'schedule': schedule,
    'age': age, 'status': status, 'address': address,
    'prerequisites': prerequisites, 'isCustom': isCustom,
  };

  factory Opportunity.fromJson(Map<String, dynamic> json) => Opportunity(
    id: json['id'] as int? ?? DateTime.now().microsecondsSinceEpoch,
    title: json['title'] as String? ?? '',
    host: json['host'] as String? ?? '',
    zone: json['zone'] as String? ?? 'Centro',
    district: json['district'] as String? ?? '',
    category: json['category'] as String? ?? 'Cultura',
    schedule: json['schedule'] as String? ?? '',
    age: json['age'] as String? ?? 'Todas as idades',
    status: json['status'] as String? ?? '100% grátis',
    address: json['address'] as String? ?? '',
    prerequisites: json['prerequisites'] as String? ?? '',
    isCustom: json['isCustom'] as bool? ?? true,
  );
}

const List<Opportunity> seedOpportunities = [
  Opportunity(
    id: 1, title: 'Oficina de Robótica para Jovens',
    host: 'IFRO Campus Calama', zone: 'Zona Norte',
    district: 'Flodoaldo Pontes Pinto', category: 'Educação',
    schedule: 'Sábados, 9h às 11h', age: '12 a 17 anos',
    status: '100% grátis', address: 'Av. Calama, 4985 — Porto Velho',
    prerequisites: 'Documento com foto e declaração escolar.',
  ),
  Opportunity(
    id: 2, title: 'Capoeira na Comunidade',
    host: 'CRAS Elizabeth Paranhos', zone: 'Zona Leste',
    district: 'Socialista', category: 'Esporte',
    schedule: 'Terças e quintas, 17h', age: 'A partir de 7 anos',
    status: '100% grátis', address: 'Rua Vila Mariana, 9968 — Socialista',
    prerequisites: 'Roupa confortável. Menores devem estar acompanhados na inscrição.',
  ),
  Opportunity(
    id: 3, title: 'Treino Funcional ao Ar Livre',
    host: 'Espaço Alternativo', zone: 'Zona Norte',
    district: 'Aponiã', category: 'Esporte',
    schedule: 'Seg, qua e sex, 18h30', age: 'Todas as idades',
    status: '100% grátis', address: 'Av. Governador Jorge Teixeira — Aponiã',
    prerequisites: 'Levar garrafa de água e apresentar liberação médica, se necessário.',
  ),
  Opportunity(
    id: 4, title: 'Acolhimento em Saúde Mental',
    host: 'Centro de Atenção Psicossocial', zone: 'Centro',
    district: 'Olaria', category: 'Saúde',
    schedule: 'Seg a sex, 8h às 17h', age: 'A partir de 18 anos',
    status: '100% grátis', address: 'Rua Rafael Vaz e Silva, 3047 — Liberdade',
    prerequisites: 'Atendimento inicial por demanda espontânea. Leve Cartão SUS e documento.',
  ),
  Opportunity(
    id: 5, title: 'Cerâmica e Saberes Amazônicos',
    host: 'Casa da Cultura Ivan Marrocos', zone: 'Centro',
    district: 'Caiari', category: 'Cultura',
    schedule: 'Quartas, 14h às 16h', age: 'A partir de 16 anos',
    status: 'Valor acessível', address: 'Av. Carlos Gomes, 536 — Caiari',
    prerequisites: 'Inscrição prévia. Materiais básicos inclusos.',
  ),
];

const zones = ['Todos', 'Zona Leste', 'Zona Sul', 'Zona Norte', 'Centro', 'Distritos'];
const categories = ['Educação', 'Esporte', 'Cultura', 'Saúde'];

IconData categoryIcon(String category) => switch (category) {
  'Educação' => Icons.menu_book_rounded,
  'Esporte' => Icons.directions_run_rounded,
  'Cultura' => Icons.palette_outlined,
  'Saúde' => Icons.favorite_border_rounded,
  _ => Icons.auto_awesome_outlined,
};

Color categoryColor(String category) => switch (category) {
  'Educação' => const Color(0xFF326C9B),
  'Esporte' => const Color(0xFFB77A20),
  'Cultura' => const Color(0xFF8B5AA6),
  'Saúde' => const Color(0xFFBA5D65),
  _ => forest,
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  String _query = '';
  String _zone = 'Todos';
  String? _category;
  final TextEditingController _searchController = TextEditingController();
  final Set<int> _saved = {};
  final List<Opportunity> _custom = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('conectapvh-saved') ?? [];
    final customJson = prefs.getString('conectapvh-custom');
    setState(() {
      _saved.addAll(ids.map((e) => int.tryParse(e)).whereType<int>());
      if (customJson != null) {
        try {
          final decoded = jsonDecode(customJson) as List<dynamic>;
          _custom.addAll(decoded.map((e) => Opportunity.fromJson(Map<String, dynamic>.from(e as Map))));
        } catch (_) {}
      }
      _loaded = true;
    });
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('conectapvh-saved', _saved.map((e) => e.toString()).toList());
    await prefs.setString('conectapvh-custom', jsonEncode(_custom.map((e) => e.toJson()).toList()));
  }

  List<Opportunity> get _all => [..._custom, ...seedOpportunities];

  List<Opportunity> get _filtered {
    final q = _query.trim().toLowerCase();
    return _all.where((item) {
      final searchable = '${item.title} ${item.host} ${item.district} ${item.address} ${item.zone} ${item.category} ${item.schedule}'.toLowerCase();
      final matchesQuery = q.isEmpty || searchable.contains(q);
      final matchesZone = _zone == 'Todos' || item.zone == _zone;
      final matchesCategory = _category == null || item.category == _category;
      final matchesSaved = _tab != 2 || _saved.contains(item.id);
      return matchesQuery && matchesZone && matchesCategory && matchesSaved;
    }).toList();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _toggleSaved(Opportunity item) async {
    setState(() {
      if (!_saved.add(item.id)) _saved.remove(item.id);
    });
    await _persist();
  }

  void _navigate(int index) {
    if (index == 3) {
      _openSubmitForm();
      return;
    }
    setState(() => _tab = index);
  }

  void _showDetails(Opportunity item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: canvas,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => OpportunityDetails(
        item: item,
        isSaved: _saved.contains(item.id),
        onToggleSaved: () => _toggleSaved(item),
        onAction: () {
          Navigator.pop(context);
          _showMessage('Inscrições online ainda não estão disponíveis. Confirme os detalhes com a organização.');
        },
      ),
    );
  }

  Future<void> _openSubmitForm() async {
    final result = await showModalBottomSheet<Opportunity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: canvas,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => const SubmitOpportunitySheet(),
    );
    if (result == null) return;
    setState(() {
      _custom.insert(0, result);
      _tab = 0;
      _zone = 'Todos';
      _category = null;
      _query = '';
      _searchController.clear();
    });
    await _persist();
    _showMessage('Sugestão salva neste dispositivo. Ela ainda não foi enviada para uma organização.');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: !_loaded
                ? const Center(child: CircularProgressIndicator(color: forest))
                : _tab == 1
                  ? MapPreparationView(items: items, onSelect: _showDetails)
                  : _tab == 2
                    ? _buildList(items, savedMode: true)
                    : _buildHome(items),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: _navigate,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE4F0E9),
        elevation: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map_rounded), label: 'Mapa'),
          NavigationDestination(icon: Icon(Icons.bookmark_border_rounded), selectedIcon: Icon(Icons.bookmark_rounded), label: 'Salvos'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline_rounded), label: 'Sugerir'),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: canvas,
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 23),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  RichText(text: const TextSpan(
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.8, color: ink),
                    children: [TextSpan(text: 'Conecta'), TextSpan(text: 'PVH', style: TextStyle(color: citrus))],
                  )),
                  const SizedBox(height: 4),
                  const Row(children: [
                    Icon(Icons.location_on_outlined, size: 13, color: muted),
                    SizedBox(width: 3),
                    Text('PORTO VELHO — RO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.1, color: muted)),
                  ]),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFFE8F3EC), borderRadius: BorderRadius.circular(30)),
                child: Text('${_all.length} oportunidades', style: const TextStyle(color: forestDark, fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_rounded, color: muted),
              hintText: 'Buscar cursos, locais, bairros...',
              suffixIcon: _query.isEmpty ? null : IconButton(
                tooltip: 'Limpar busca',
                onPressed: () { _searchController.clear(); setState(() => _query = ''); },
                icon: const Icon(Icons.close_rounded, size: 19),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHome(List<Opportunity> items) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 21, 20, 20),
          decoration: BoxDecoration(
            color: forestDark,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              Positioned(right: -18, top: -22, child: Icon(Icons.spa_outlined, size: 118, color: Colors.white.withOpacity(.07))),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(.12), borderRadius: BorderRadius.circular(30)),
                  child: const Text('OPORTUNIDADES PERTO DE VOCÊ', style: TextStyle(color: Color(0xFFE0F2E8), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1.05)),
                ),
                const SizedBox(height: 14),
                const Text('Sua cidade.\nNovas possibilidades.', style: TextStyle(color: Colors.white, fontSize: 27, height: 1.13, fontWeight: FontWeight.w800, letterSpacing: -.8)),
                const SizedBox(height: 10),
                Text('Descubra atividades, serviços e iniciativas que conectam a comunidade.', style: TextStyle(color: Colors.white.withOpacity(.78), height: 1.45, fontSize: 13)),
                const SizedBox(height: 18),
                Row(children: [
                  const Icon(Icons.explore_outlined, size: 16, color: citrus),
                  const SizedBox(width: 7),
                  Text('${items.length} ${items.length == 1 ? 'oportunidade encontrada' : 'oportunidades encontradas'}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                ]),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const SectionHeading(title: 'Explore por categoria', subtitle: 'Encontre o que combina com você'),
        const SizedBox(height: 13),
        SizedBox(
          height: 94,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = categories[index];
              final active = _category == category;
              final color = categoryColor(category);
              return InkWell(
                onTap: () => setState(() {
                  _category = active ? null : category;
                  _tab = 0;
                }),
                borderRadius: BorderRadius.circular(18),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 82,
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  decoration: BoxDecoration(
                    color: active ? const Color(0xFFE5F1E9) : Colors.white,
                    border: Border.all(color: active ? forest : line),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(categoryIcon(category), color: color, size: 23),
                    const SizedBox(height: 8),
                    Text(category, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: active ? forestDark : ink, fontSize: 10, fontWeight: FontWeight.w700)),
                  ]),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeading(title: 'Oportunidades em destaque', subtitle: 'Iniciativas para participar na cidade'),
        const SizedBox(height: 13),
        _buildZoneFilters(),
        const SizedBox(height: 13),
        if (items.isEmpty) _emptyState(
          title: 'Nenhuma oportunidade encontrada',
          message: 'Tente mudar os filtros ou buscar por outro termo.',
          icon: Icons.search_off_rounded,
          onClear: _clearFilters,
        ) else ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OpportunityCard(
            item: item,
            isSaved: _saved.contains(item.id),
            onTap: () => _showDetails(item),
            onSave: () => _toggleSaved(item),
          ),
        )),
      ],
    );
  }

  Widget _buildList(List<Opportunity> items, {bool savedMode = false}) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        SectionHeading(
          title: savedMode ? 'Oportunidades salvas' : 'Oportunidades',
          subtitle: savedMode ? 'Sua lista pessoal neste dispositivo' : 'Explore as opções disponíveis',
        ),
        const SizedBox(height: 17),
        _buildZoneFilters(),
        const SizedBox(height: 13),
        if (items.isEmpty) _emptyState(
          title: savedMode ? 'Sua lista está vazia' : 'Nenhum resultado',
          message: savedMode ? 'Salve uma oportunidade tocando no marcador.' : 'Experimente outros filtros.',
          icon: savedMode ? Icons.bookmark_border_rounded : Icons.search_off_rounded,
          onClear: _clearFilters,
        ) else ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OpportunityCard(
            item: item,
            isSaved: _saved.contains(item.id),
            onTap: () => _showDetails(item),
            onSave: () => _toggleSaved(item),
          ),
        )),
      ],
    );
  }

  Widget _buildZoneFilters() {
    return SizedBox(
      height: 39,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: zones.length,
        separatorBuilder: (_, __) => const SizedBox(width: 7),
        itemBuilder: (context, index) {
          final value = zones[index];
          final active = _zone == value;
          return ChoiceChip(
            label: Text(value),
            selected: active,
            onSelected: (_) => setState(() => _zone = value),
            showCheckmark: false,
            labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: active ? Colors.white : const Color(0xFF56645D)),
            selectedColor: forest,
            backgroundColor: Colors.white,
            side: BorderSide(color: active ? forest : line),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          );
        },
      ),
    );
  }

  Widget _emptyState({required String title, required String message, required IconData icon, required VoidCallback onClear}) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: line)),
      child: Column(children: [
        Container(width: 52, height: 52, decoration: const BoxDecoration(color: Color(0xFFEAF3ED), shape: BoxShape.circle), child: Icon(icon, color: forest, size: 25)),
        const SizedBox(height: 13),
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: ink)),
        const SizedBox(height: 7),
        Text(message, textAlign: TextAlign.center, style: const TextStyle(color: muted, fontSize: 13, height: 1.45)),
        const SizedBox(height: 15),
        TextButton(onPressed: onClear, child: const Text('Limpar filtros')),
      ]),
    );
  }

  void _clearFilters() {
    setState(() {
      _query = '';
      _searchController.clear();
      _zone = 'Todos';
      _category = null;
    });
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(color: ink, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -.4)),
      const SizedBox(height: 4),
      Text(subtitle, style: const TextStyle(color: muted, fontSize: 12)),
    ],
  );
}

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({super.key, required this.item, required this.isSaved, required this.onTap, required this.onSave});
  final Opportunity item;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final color = categoryColor(item.category);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(21),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(21),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), border: Border.all(color: line.withOpacity(.9))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(color: color.withOpacity(.10), borderRadius: BorderRadius.circular(15)),
                child: Icon(categoryIcon(item.category), color: color, size: 23),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Wrap(spacing: 6, runSpacing: 5, children: [
                  _Pill(label: item.category, color: color),
                  _Pill(label: item.status, color: item.status == '100% grátis' ? forest : const Color(0xFF8A5D1D), background: item.status == '100% grátis' ? const Color(0xFFE8F3EC) : const Color(0xFFFFF2D9)),
                ]),
                const SizedBox(height: 7),
                Text(item.title, style: const TextStyle(color: ink, fontSize: 15, fontWeight: FontWeight.w800, height: 1.25, letterSpacing: -.2)),
                const SizedBox(height: 4),
                Text(item.host, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: muted, fontSize: 11)),
              ])),
              IconButton(
                onPressed: onSave,
                tooltip: isSaved ? 'Remover dos salvos' : 'Salvar oportunidade',
                visualDensity: VisualDensity.compact,
                icon: Icon(isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: isSaved ? forest : muted),
              ),
            ]),
            const SizedBox(height: 14),
            const Divider(height: 1, color: line),
            const SizedBox(height: 12),
            Wrap(spacing: 14, runSpacing: 8, children: [
              _Meta(icon: Icons.schedule_rounded, label: item.schedule),
              _Meta(icon: Icons.location_on_outlined, label: '${item.district} · ${item.zone}'),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color, this.background});
  final String label;
  final Color color;
  final Color? background;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(color: background ?? color.withOpacity(.09), borderRadius: BorderRadius.circular(30)),
    child: Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w800)),
  );
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 14, color: muted),
    const SizedBox(width: 5),
    Flexible(child: Text(label, style: const TextStyle(color: muted, fontSize: 10, fontWeight: FontWeight.w600))),
  ]);
}

class OpportunityDetails extends StatelessWidget {
  const OpportunityDetails({super.key, required this.item, required this.isSaved, required this.onToggleSaved, required this.onAction});
  final Opportunity item;
  final bool isSaved;
  final VoidCallback onToggleSaved;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(22, 12, 22, 20 + bottom),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Center(child: Container(width: 42, height: 4, decoration: BoxDecoration(color: const Color(0xFFD6DED9), borderRadius: BorderRadius.circular(8)))),
            const SizedBox(height: 20),
            Row(children: [
              Container(width: 50, height: 50, decoration: BoxDecoration(color: categoryColor(item.category).withOpacity(.1), borderRadius: BorderRadius.circular(16)), child: Icon(categoryIcon(item.category), color: categoryColor(item.category), size: 25)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _Pill(label: item.category, color: categoryColor(item.category)),
                const SizedBox(height: 6),
                Text(item.title, style: const TextStyle(fontSize: 21, height: 1.15, fontWeight: FontWeight.w800, color: ink)),
              ])),
              IconButton(onPressed: onToggleSaved, tooltip: isSaved ? 'Remover dos salvos' : 'Salvar', icon: Icon(isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: forest)),
            ]),
            const SizedBox(height: 8),
            Text(item.host, style: const TextStyle(color: muted, fontSize: 13)),
            const SizedBox(height: 20),
            _DetailRow(icon: Icons.schedule_rounded, title: 'Horário', value: item.schedule),
            _DetailRow(icon: Icons.people_outline_rounded, title: 'Faixa etária', value: item.age),
            _DetailRow(icon: Icons.location_on_outlined, title: 'Endereço', value: '${item.address}\n${item.district} · ${item.zone}'),
            _DetailRow(icon: Icons.payments_outlined, title: 'Custo', value: item.status),
            const SizedBox(height: 8),
            const Text('O que você precisa', style: TextStyle(fontSize: 15, color: ink, fontWeight: FontWeight.w800)),
            const SizedBox(height: 7),
            Text(item.prerequisites, style: const TextStyle(color: muted, fontSize: 13, height: 1.5)),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(color: const Color(0xFFEAF2EC), borderRadius: BorderRadius.circular(15)),
              child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.info_outline_rounded, color: forest, size: 19),
                SizedBox(width: 9),
                Expanded(child: Text('Confirme horários, disponibilidade e requisitos diretamente com a organização. Rotas e inscrições online ainda não estão conectadas.', style: TextStyle(color: forestDark, fontSize: 11, height: 1.45))),
              ]),
            ),
            const SizedBox(height: 17),
            SizedBox(width: double.infinity, child: FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(backgroundColor: forest, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              child: const Text('Como participar', style: TextStyle(fontWeight: FontWeight.w800)),
            )),
          ]),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: line)), child: Icon(icon, color: forest, size: 18)),
      const SizedBox(width: 11),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: muted, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(color: ink, fontSize: 13, height: 1.4, fontWeight: FontWeight.w600)),
      ])),
    ]),
  );
}

class MapPreparationView extends StatelessWidget {
  const MapPreparationView({super.key, required this.items, required this.onSelect});
  final List<Opportunity> items;
  final ValueChanged<Opportunity> onSelect;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
    children: [
      const SectionHeading(title: 'Explore no mapa', subtitle: 'Localização preparada para uma futura integração'),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: line)),
        child: Column(children: [
          Container(width: 54, height: 54, decoration: const BoxDecoration(color: Color(0xFFE8F3EC), shape: BoxShape.circle), child: const Icon(Icons.map_outlined, color: forest, size: 27)),
          const SizedBox(height: 13),
          const Text('Mapa ainda não conectado', textAlign: TextAlign.center, style: TextStyle(color: ink, fontSize: 17, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          const Text('Para exibir pins e calcular rotas com precisão, precisamos integrar um provedor de mapas e obter coordenadas para cada endereço. Por enquanto, veja os endereços abaixo.', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 12, height: 1.5)),
          const SizedBox(height: 13),
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.verified_user_outlined, size: 15, color: forest),
            SizedBox(width: 6),
            Text('Sem marcadores de localização fictícios', style: TextStyle(color: forestDark, fontSize: 10, fontWeight: FontWeight.w700)),
          ]),
        ]),
      ),
      const SizedBox(height: 20),
      const SectionHeading(title: 'Endereços das oportunidades', subtitle: 'Toque em uma opção para ver os detalhes'),
      const SizedBox(height: 12),
      if (items.isEmpty)
        const Padding(padding: EdgeInsets.all(28), child: Text('Nenhum endereço corresponde aos filtros.', textAlign: TextAlign.center, style: TextStyle(color: muted)))
      else
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              onTap: () => onSelect(item),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: line)),
                child: Row(children: [
                  Container(width: 42, height: 42, decoration: BoxDecoration(color: categoryColor(item.category).withOpacity(.1), borderRadius: BorderRadius.circular(13)), child: Icon(Icons.location_on_outlined, color: categoryColor(item.category))),
                  const SizedBox(width: 11),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(item.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: ink)),
                    const SizedBox(height: 4),
                    Text(item.address, style: const TextStyle(fontSize: 11, color: muted, height: 1.35)),
                  ])),
                  const Icon(Icons.chevron_right_rounded, color: muted),
                ]),
              ),
            ),
          ),
        )),
    ],
  );
}

class SubmitOpportunitySheet extends StatefulWidget {
  const SubmitOpportunitySheet({super.key});
  @override
  State<SubmitOpportunitySheet> createState() => _SubmitOpportunitySheetState();
}

class _SubmitOpportunitySheetState extends State<SubmitOpportunitySheet> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _host = TextEditingController();
  final _district = TextEditingController();
  final _schedule = TextEditingController();
  final _age = TextEditingController();
  final _address = TextEditingController();
  final _prerequisites = TextEditingController();
  String _zone = 'Centro';
  String _category = 'Educação';
  String _status = '100% grátis';

  @override
  void dispose() {
    _title.dispose(); _host.dispose(); _district.dispose(); _schedule.dispose();
    _age.dispose(); _address.dispose(); _prerequisites.dispose();
    super.dispose();
  }

  String? _required(String? value) => value == null || value.trim().isEmpty ? 'Preencha este campo' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, Opportunity(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _title.text.trim(),
      host: _host.text.trim(),
      zone: _zone,
      district: _district.text.trim(),
      category: _category,
      schedule: _schedule.text.trim(),
      age: _age.text.trim().isEmpty ? 'Todas as idades' : _age.text.trim(),
      status: _status,
      address: _address.text.trim(),
      prerequisites: _prerequisites.text.trim().isEmpty ? 'Entre em contato com a organização para confirmar.' : _prerequisites.text.trim(),
      isCustom: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(22, 12, 22, 20 + bottom),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Center(child: Container(width: 42, height: 4, decoration: BoxDecoration(color: const Color(0xFFD6DED9), borderRadius: BorderRadius.circular(8)))),
              const SizedBox(height: 20),
              const Text('Sugerir oportunidade', style: TextStyle(color: ink, fontSize: 23, fontWeight: FontWeight.w800, letterSpacing: -.5)),
              const SizedBox(height: 6),
              const Text('Adicione os dados para guardar uma sugestão neste dispositivo.', style: TextStyle(color: muted, fontSize: 12, height: 1.4)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFFFFF3D9), borderRadius: BorderRadius.circular(14)),
                child: const Text('A sugestão não será publicada nem enviada a uma organização. Ela ficará salva apenas neste dispositivo.', style: TextStyle(color: Color(0xFF805B19), fontSize: 11, height: 1.45)),
              ),
              const SizedBox(height: 15),
              _field(_title, 'Nome da oportunidade *', validator: _required),
              _field(_host, 'Organização responsável *', validator: _required),
              _field(_district, 'Bairro *', validator: _required),
              _field(_address, 'Endereço *', validator: _required),
              _field(_schedule, 'Dias e horários *', validator: _required),
              _field(_age, 'Faixa etária (opcional)'),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Categoria'),
                items: categories.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                onChanged: (v) => setState(() => _category = v ?? _category),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _zone,
                decoration: const InputDecoration(labelText: 'Região'),
                items: zones.where((z) => z != 'Todos').map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                onChanged: (v) => setState(() => _zone = v ?? _zone),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Custo'),
                items: const [
                  DropdownMenuItem(value: '100% grátis', child: Text('100% grátis')),
                  DropdownMenuItem(value: 'Valor acessível', child: Text('Valor acessível')),
                ],
                onChanged: (v) => setState(() => _status = v ?? _status),
              ),
              const SizedBox(height: 12),
              _field(_prerequisites, 'Requisitos ou observações', maxLines: 3),
              const SizedBox(height: 17),
              SizedBox(width: double.infinity, child: FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(backgroundColor: forest, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: const Text('Salvar sugestão neste dispositivo', style: TextStyle(fontWeight: FontWeight.w800)),
              )),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, {String? Function(String?)? validator, int maxLines = 1}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: label),
    ),
  );
}
