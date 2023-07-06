import 'package:campus/src/controles/dto/professor.dart';

abstract class ProfessorDao {
  Future<Professor> salvar(Professor professor);
  Future<bool> excluir(dynamic id);
  Future<Professor> consultar(int id);
  Future<List<Professor>> consultarTodos();
}
