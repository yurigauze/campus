import 'package:campus/controles/dto/aluno.dart';
import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/dto/turno.dart';

class AvisoRelacionamento {
  final dynamic id;

  final Aviso aviso;
  final Turno? turno;
  final Aluno? aluno;
  final Turma? turma;

  AvisoRelacionamento(
      {this.id, required this.aviso, this.turno, this.aluno, this.turma});

  @override
  String toString() {
    return '''
      $id
      $aviso 
      $turno
      $aluno
      $turma
    ''';
  }
}
