import 'package:campus/controles/dto/avisosRelacionamento.dart';

abstract class AvisoRelacionamentoDao {
  Future<AvisoRelacionamento> salvar(AvisoRelacionamento relacionamento);
  Future<bool> excluir(dynamic id);
  Future<AvisoRelacionamento> consultar(int id);
  Future<List<AvisoRelacionamento>> consultarTodos();
}
