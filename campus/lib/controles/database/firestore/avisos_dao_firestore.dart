import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvisosDAOFirestore implements AvisoDao {
  CollectionReference avisoCollection;

  AvisosDAOFirestore() {
    avisoCollection = FirebaseFirestore.instance.collection('aviso');
  }

  @override
  Future<Aviso> consultar(int id) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  Future<List<Aviso>> consultarTodos() async {
    var result = await avisoCollection.get();
    return result.docs.map((doc) => Aviso(
        id: doc.reference.id.toString(),
        titulo: doc['titulo'],
        corpo: doc['corpo'],
        informacao: ['informacao']));
  }

  @override
  Future<bool> excluir(id) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  Future<Aviso> salvar(Aviso avisos) {
    // TODO: implement salvar
    throw UnimplementedError();
  }

  @override
  Future<Aviso> salvarAvisoAluno(Aviso avisos, int idAluno) {
    // TODO: implement salvarAvisoAluno
    throw UnimplementedError();
  }

  @override
  Future<Aviso> salvarAvisoTurma(Aviso avisos, int idTurma) {
    // TODO: implement salvarAvisoTurma
    throw UnimplementedError();
  }

  @override
  Future<Aviso> salvarAvisoTurno(Aviso avisos, int idTurno) {
    // TODO: implement salvarAvisoTurno
    throw UnimplementedError();
  }
}
