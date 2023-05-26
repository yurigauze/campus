import 'package:campus/controles/dto/aviso.dart';

abstract class AvisoDao {
  Future<Aviso> salvar(Aviso avisos);
  Future<bool> excluir(dynamic id);
  Future<Aviso> consultar(int id);
  Future<List<Aviso>> consultarTodos();
}
