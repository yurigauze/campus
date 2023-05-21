import 'package:campus/controles/dto/aviso.dart';

abstract class AvisoDao {
  Aviso salvar(Aviso avisos);
  bool excluir(dynamic id);
  Future<Aviso> consultar(int id);
  Future<List<Aviso>> consultarTodos();
}
