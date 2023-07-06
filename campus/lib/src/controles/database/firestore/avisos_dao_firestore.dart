import 'package:campus/src/controles/dto/aviso.dart';
import 'package:campus/src/controles/interface/firebase/aviso_interface_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvisosDAOFirestore implements AvisoFireDao {

CollectionReference avisoCollection =
      FirebaseFirestore.instance.collection('aviso');


  @override
    Aviso  consultar(int id) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  Future<List<Aviso>> consultarTodos() async {
    var result = await avisoCollection.get();
    return result.docs.map(
      (doc) => Aviso(
        id: doc.reference.id.toString(),
        titulo: doc['titulo'],
        corpo: doc['corpo'],
        )).toList();
  }

  @override
  excluir(id)  {
   avisoCollection.doc(id).delete();

  }

  @override
  salvar(Aviso avisos) {
     avisoCollection.doc(avisos.id).set(
      {
        'titulo': avisos.titulo,
        'corpo': avisos.corpo,
      }
    );
    print("enviou?");
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
