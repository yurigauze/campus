import 'package:campus/controles/dto/aluno.dart';

abstract class AlunoDao {
  Future<Aluno> salvar(Aluno aluno);
  Future<bool> excluir(dynamic id);
  Future<Aluno> consultar(int id);
  Future<List<Aluno>> consultarTodos();
}
