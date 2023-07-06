import 'package:campus/src/controles/dto/turno.dart';

class Turma {
  final dynamic id;
  final String nome;
  final Turno turno;

  Turma({this.id, required this.nome, required this.turno});

  @override
  String toString() {
    return '''
      $id
      $nome 
      $turno
    ''';
  }
}
