import 'package:campus/src/controles/dto/turno.dart';

abstract class TurnoFireDao {
  salvar(Turno avisos);
  excluir(dynamic id);
  Turno consultar(int id);
  Future<List<Turno>> consultarTodos();
}
