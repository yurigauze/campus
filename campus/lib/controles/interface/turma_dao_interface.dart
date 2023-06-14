import 'package:campus/controles/dto/turma.dart';

abstract class TurmaDao {
  Future<Turma> salvar(Turma turma);
  Future<bool> excluir(dynamic id);
  Future<Turma> consultar(int id);
  Future<List<Turma>> consultarTodos();
}
