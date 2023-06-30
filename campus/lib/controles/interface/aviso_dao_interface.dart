import 'package:campus/controles/dto/aviso.dart';

abstract class AvisoDao {
  Future<Aviso> salvar(Aviso avisos);
  Future<Aviso> salvarAvisoAluno(Aviso avisos, int idAluno);
  Future<Aviso> salvarAvisoTurno(Aviso avisos, int idTurno);
  Future<Aviso> salvarAvisoTurma(Aviso avisos, int idTurma);
  Future<bool> excluir(dynamic id);
  Future<Aviso> consultar(int id);
  Future<List<Aviso>> consultarTodos();
}
