import 'package:campus/src/controles/dto/aluno.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/interface/firebase/turma_interface_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TurmaDAOFirestore implements TurmaFireDao {
  CollectionReference turmaCollection =
      FirebaseFirestore.instance.collection('turma');

  @override
  Future<List<Turma>> consultarTodos() async {
    var result = await turmaCollection.get();
    return result.docs.map((doc) {
      List<Aluno> alunos = (doc['alunos'] as List)
          .map((aluno) => Aluno(
                nome: doc['nome'],
                cpf: doc['cpf'],
                email: doc['email'],
                password: doc['password'],
                telefone: doc['telefone'],
              ))
          .toList();
      return Turma(
        id: doc.reference.id.toString(),
        nome: doc['nome'],
        alunos: alunos,
      );
    }).toList();
  }

  @override
  excluir(id) {
    turmaCollection.doc(id).delete();
  }

  @override
  salvar(Turma turma) {
    turmaCollection.doc(turma.id).set({'nome': turma.nome});
  }

  @override
  Future<Turma> consultar(int id) {
    // TODO: implement consultar
    throw UnimplementedError();
  }
}
