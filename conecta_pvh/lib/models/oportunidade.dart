import 'package:flutter/material.dart';
import '../constants/cores.dart';

class Oportunidade {
  Oportunidade({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.local,
    required this.data,
    required this.descricao,
    IconData? icone,
    this.corFundo = floresta,
    this.destaque = false,
  }) : icone = icone ?? iconeDaCategoria(categoria);

  final int id;
  final String titulo;
  final String categoria;
  final String local;
  final String data;
  final String descricao;
  final IconData icone;
  final Color corFundo;
  final bool destaque;

  Oportunidade copyWith({
    int? id,
    String? titulo,
    String? categoria,
    String? local,
    String? data,
    String? descricao,
    IconData? icone,
    Color? corFundo,
    bool? destaque,
  }) {
    final novaCategoria = categoria ?? this.categoria;
    return Oportunidade(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      categoria: novaCategoria,
      local: local ?? this.local,
      data: data ?? this.data,
      descricao: descricao ?? this.descricao,
      icone: icone ?? (categoria != null ? iconeDaCategoria(categoria) : this.icone),
      corFundo: corFundo ?? this.corFundo,
      destaque: destaque ?? this.destaque,
    );
  }
}