import 'package:flutter/material.dart';

const Color floresta = Color(0xFF174D3A);
const Color florestaEscuro = Color(0xFF103829);
const Color lima = Color(0xFFC8F169);
const Color creme = Color(0xFFF7F5EC);
const Color papel = Color(0xFFFFFFFF);
const Color fosco = Color(0xFF68766F);
const Color linha = Color(0xFFE4E8E0);

const List<String> categorias = [
  'Todas',
  'Empregos',
  'Cursos',
  'Eventos',
  'Voluntariado',
  'Comunidade',
];

IconData iconeDaCategoria(String categoria) {
  switch (categoria) {
    case 'Empregos':
      return Icons.work_outline_rounded;
    case 'Cursos':
      return Icons.school_rounded;
    case 'Eventos':
      return Icons.event_available_rounded;
    case 'Voluntariado':
      return Icons.volunteer_activism_rounded;
    case 'Comunidade':
      return Icons.groups_rounded;
    case 'Todas':
    default:
      return Icons.grid_view_rounded;
  }
}