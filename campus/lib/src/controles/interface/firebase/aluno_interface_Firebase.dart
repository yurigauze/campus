import 'package:campus/src/controles/dto/aluno.dart';

abstract class AlunoFireDao {
  salvar(Aluno aluno);
  excluir(dynamic id);
  Aluno consultar(int id);
  Future<List<Aluno>> consultarTodos();
}
