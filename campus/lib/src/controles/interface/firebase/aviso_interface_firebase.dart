import 'package:campus/src/controles/dto/aviso.dart';

abstract class AvisoFireDao {
  salvar(Aviso avisos);
  excluir(dynamic id);
  Aviso consultar(int id);
  Future<List<Aviso>> consultarTodos();
}
