import 'package:flutter/material.dart';

class Aviso {
  final String titulo;
  final String corpo;

  Aviso({required this.titulo, required this.corpo});
}

class AvisoDAO {
  static List<Aviso> obterAvisos() {
    return [
      Aviso(titulo: 'Aviso 1', corpo: 'Texto aviso 1'),
      Aviso(titulo: 'Aviso 2', corpo: 'Texto aviso 2'),
      Aviso(titulo: 'Aviso 3', corpo: 'Texto aviso 3'),
    ];
  }
}
