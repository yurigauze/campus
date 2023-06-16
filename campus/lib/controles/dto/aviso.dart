import 'package:campus/controles/dto/aluno.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/dto/turno.dart';

class Aviso {
  final dynamic id;
  final String titulo;
  final String corpo;
  final Turno? turno;
  final Aluno? aluno;
  final Turma? turma;


  Aviso({this.id, required this.titulo, required this.corpo, this.turno, this.aluno, this.turma});

  @override
  String toString() {
    return '''
      $id
      $titulo 
      $corpo
      $turno
      $aluno
      $turma
    ''';
  }
}
