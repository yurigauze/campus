class Turno {
  final dynamic id;
  final String nome;
  final String? descricao;

  Turno({this.id, required this.nome, this.descricao});

  @override
  String toString() {
    return '''
      $id
      $nome 
      $descricao
    ''';
  }
}
