import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaTurmasScreen extends StatefulWidget {
  final Turno turno;

  ListaTurmasScreen({required this.turno});

  @override
  _ListaTurmasScreenState createState() => _ListaTurmasScreenState();
}

class _ListaTurmasScreenState extends State<ListaTurmasScreen> {
  List<Turma> turmas = [];

  @override
  void initState() {
    super.initState();
    buscarTurmasDoTurno();
  }

  void buscarTurmasDoTurno() async {
    try {
      // Acessar a coleção de turmas no Firestore
      CollectionReference turmasCollection =
          FirebaseFirestore.instance.collection('turmas');

      // Realizar a consulta para buscar as turmas relacionadas ao turno
      QuerySnapshot querySnapshot = await turmasCollection
          .where('idTurno', isEqualTo: widget.turno.id)
          .get();

      // Limpar a lista de turmas
      turmas.clear();

      // Iterar pelos documentos retornados na consulta
      for (DocumentSnapshot doc in querySnapshot.docs) {
        // Extrair os dados do documento e criar um objeto Turma
        Turma turma = Turma(
          id: doc.id,
          nome: doc['nome'],
          alunos: [],
          // Outros campos da turma...
        );

        // Adicionar a turma à lista
        turmas.add(turma);
      }

      // Atualizar a exibição das turmas na tela
      setState(() {});
    } catch (e) {
      // Lidar com possíveis erros durante a busca das turmas
      print('Erro ao buscar turmas do turno: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turmas do Turno'),
      ),
      body: ListView.builder(
        itemCount: turmas.length,
        itemBuilder: (context, index) {
          Turma turma = turmas[index];
          return ListTile(
            title: Text(turma.nome),
            // Outros campos da turma...
          );
        },
      ),
    );
  }
}
