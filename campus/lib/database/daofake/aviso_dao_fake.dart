

import 'package:campus/interface/aviso.dart';
import 'package:campus/database/daofake/aviso_fake.dart';
import 'package:campus/interface/aviso_dao.dart';

class AvisoDAOFake implements AvisoDao {
  @override
  Future<Aviso> consultar(int id) {
    return Future.value(avisos[id - 1]);
  }

  @override
  Future<List<Aviso>> consultarTodos() {
    return Future.value(avisos);
  }

  @override
  bool excluir(dynamic id) {
    print('excluir ${avisos[id - 1]}');
    avisos.remove(avisos[id - 1]);
    return true;
  }

  @override
  Aviso salvar(Aviso aviso) {
    if (aviso.id == null) {
      aviso = Aviso(
        id: avisos.length,
        titulo: aviso.titulo,
        corpo: aviso.corpo,
      );
      avisos.add(aviso);
    } else {
      int i = (aviso.id as int) - 1;
      avisos[i] = aviso;
    }
    print(aviso);
    return aviso;
  }
}
