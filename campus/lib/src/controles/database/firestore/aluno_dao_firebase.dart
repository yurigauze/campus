import 'package:campus/src/controles/dto/aluno.dart';
import 'package:campus/src/controles/interface/firebase/aluno_interface_Firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlunoDAOFirebase implements AlunoFireDao {
  CollectionReference alunoCollection =
      FirebaseFirestore.instance.collection('aviso');

  @override
  Future<List<Aluno>> consultarTodos() async {
    var result = await alunoCollection.get();
    return result.docs
        .map((doc) => Aluno(
              id: doc.reference.id.toString(),
              nome: doc['nome'],
              cpf: doc['cpf'],
              email: doc['email'],
              password: doc['password'],
              telefone: doc['telefone'],
            ))
        .toList();
  }

  @override
  excluir(id) {
    alunoCollection.doc(id).delete();
  }

  @override
  salvar(Aluno aluno) {
    alunoCollection.doc((aluno.id).set({
      'nome': aluno.nome,
      'cpf': aluno.cpf,
      'email': aluno.email,
      'password': aluno.password,
      'telefone': aluno.telefone,
    }));
  }

  @override
  Aluno consultar(int id) {
    // TODO: implement consultar
    throw UnimplementedError();
  }
}
