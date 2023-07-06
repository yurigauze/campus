import 'package:campus/src/controles/dto/aluno.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/firebase/turno_interface_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TurnoDAOFirebase implements TurnoFireDao {
  CollectionReference turnoCollection =
      FirebaseFirestore.instance.collection('turnos');
  @override
  Turno consultar(int id) {
    // TODO: implement consultar
    throw UnimplementedError();
  }

  @override
  Future<List<Turno>> consultarTodos() async {
    QuerySnapshot snapshot = await turnoCollection.get();

    List<Turno> turnos = [];

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      String nomeTurno = doc['nome'] as String;
      Turno turno = Turno(nome: nomeTurno, turmas: []);
      turnos.add(turno);
    }

    return turnos;
  }

  @override
  excluir(id) {
    turnoCollection.doc(id).delete();
  }

  @override
  salvar(Turno turno) {
    // Cria um novo documento na coleção "turno"
    DocumentReference turnoDocRef = turnoCollection.doc();

    // Cria uma lista de mapas contendo os dados dos alunos de cada turma
    List<List<Map<String, dynamic>>> alunosPorTurma = turno.turmas.map((turma) {
      return turma.alunos.map((aluno) {
        return {
          'nome': aluno.nome,
          'cpf': aluno.cpf,
          'email': aluno.email,
          'password': aluno.password,
          'telefone': aluno.telefone,
        };
      }).toList();
    }).toList();

    // Cria um mapa contendo os dados do turno, incluindo a lista de turmas com os alunos
    Map<String, dynamic> turnoData = {
      'nome': turno.nome,
      'turmas': alunosPorTurma,
    };

    // Salva o documento do turno no Firebase
    turnoDocRef.set(turnoData);
  }
}
