class Aviso{
  final dynamic id;
  final String titulo;
  final String corpo;


  Aviso(
      {this.id,
      required this.titulo,
      required this.corpo});

  @override
  String toString() {
    return '''
      $id
      $titulo 
      $corpo 
    ''';
  }
}
