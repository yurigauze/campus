import 'package:campus/src/controles/dto/aluno.dart';
import 'package:campus/src/controles/dto/aviso.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';

class AvisoRelacionamento {
  final Aviso aviso;
  final Turno? turno;
  final Aluno? aluno;
  final Turma? turma;

  AvisoRelacionamento(
      {required this.aviso, this.turno, this.aluno, this.turma});

  @override
  String toString() {
    return '''
      $aviso 
      $turno
      $aluno
      $turma
    ''';
  }
}
