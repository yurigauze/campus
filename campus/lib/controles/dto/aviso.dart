class Aviso {
  final dynamic id;
  final String titulo;
  final String corpo;
  final String? adicional;

  Aviso({this.id, required this.titulo, required this.corpo, this.adicional});

  @override
  String toString() {
    return '''
      $id
      $titulo 
      $corpo
      $adicional
    ''';
  }
}
