import 'dart:ffi';

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
      String idTurno = doc.id as String;

      Turno turno = Turno(nome: nomeTurno, turmas: [], descricao: idTurno);
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
  }
}
