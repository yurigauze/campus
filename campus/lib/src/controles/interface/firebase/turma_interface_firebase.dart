import 'package:campus/src/controles/dto/turma.dart';

abstract class TurmaFireDao {
  salvar(Turma turma);
  excluir(dynamic id);
  Future<Turma> consultar(int id);
  Future<List<Turma>> consultarTodos();
}
