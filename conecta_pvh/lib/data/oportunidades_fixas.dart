import '../models/oportunidade.dart';

final List<Oportunidade> oportunidades_fixas = [
  Oportunidade(
    id: 1,
    titulo: 'Curso Técnico em Desenvolvimento de Sistemas',
    categoria: 'Cursos',
    local: 'Porto Velho - RO',
    data: 'Inscrições abertas',
    descricao:
        'Formação prática voltada para programação, bancos de dados e desenvolvimento de aplicações.',
    destaque: true,
  ),
  Oportunidade(
    id: 2,
    titulo: 'Mutirão de Empregabilidade e Currículos',
    categoria: 'Empregos',
    local: 'Centro - Porto Velho, RO',
    data: '10/12/2026',
    descricao:
        'Atendimento para orientação profissional, revisão de currículo e encaminhamento para vagas locais.',
    destaque: true,
  ),
  Oportunidade(
    id: 3,
    titulo: 'Oficina de Libras no Atendimento ao Público',
    categoria: 'Cursos',
    local: 'Zona Sul - Porto Velho, RO',
    data: '18/12/2026',
    descricao:
        'Capacitação introdutória com sinais essenciais para comunicação acessível no dia a dia.',
  ),
  Oportunidade(
    id: 4,
    titulo: 'Feira de Empreendedores de Porto Velho',
    categoria: 'Eventos',
    local: 'Espaço Cultural - Porto Velho, RO',
    data: '22/12/2026',
    descricao:
        'Exposição de produtos, troca de experiências e divulgação de negócios da região.',
  ),
];