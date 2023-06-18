import 'package:campus/controles/dto/aluno.dart';
import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/dto/avisosRelacionamento.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/dto/turno.dart';

abstract class AvisoRelacionamentoDao {
  Future<AvisoRelacionamento> salvar(AvisoRelacionamento relacionamento);
  Future<bool> excluir(dynamic id);
  Future<AvisoRelacionamento> consultar(
      Aviso aviso, Turno? turno, Aluno? aluno, Turma? turma);
  Future<List<AvisoRelacionamento>> consultarTodos();
}
