import 'package:campus/controles/dto/turno.dart';

abstract class TurnoDao {
  Future<Turno> salvar(Turno turno);
  Future<bool> excluir(dynamic id);
  Future<Turno> consultar(int id);
  Future<List<Turno>> consultarTodos();
}
