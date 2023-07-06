import 'package:campus/src/controles/dto/aluno.dart';
import 'package:campus/src/controles/dto/turno.dart';

class Turma {
  final dynamic id;
  final String nome;
  List<Aluno>? alunos;

  Turma({this.id, required this.nome, this.alunos});

  @override
  String toString() {
    return '''
      $id
      $nome 
      $alunos
    ''';
  }
}
