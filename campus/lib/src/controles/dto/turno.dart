import 'turma.dart';

class Turno {
  final dynamic id;
  final String nome;
  List<Turma>? turmas;
  final String? descricao;

  Turno({this.id, required this.nome, this.turmas, this.descricao});

  @override
  String toString() {
    return '''
      $id
      $nome 
      $turmas
      $descricao
    ''';
  }
}
