import 'package:campus/src/Widget/PainelBotoes.dart';
import 'package:campus/src/controles/database/firestore/turma_dao_firestore.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/interface/firebase/turma_interface_firebase.dart';

import 'package:flutter/material.dart';

class TurmaLista extends StatefulWidget {
  const TurmaLista({Key? key}) : super(key: key);
  @override
  State<TurmaLista> createState() => _TurmaListaState();
}

class _TurmaListaState extends State<TurmaLista> {
  TurmaFireDao dao = TurmaDAOFirestore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Lista de Turmas")),
        body: criarLista(context));
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: buscarTurma(),
      builder: (context, AsyncSnapshot<List<Turma>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Turmas...');
        List<Turma> listaTurma = lista.data!;
        return ListView.builder(
          itemCount: listaTurma.length,
          itemBuilder: (context, indice) {
            var turma = listaTurma[indice];
            return criarItemLista(context, turma);
          },
        );
      },
    );
  }

  Future<List<Turma>> buscarTurma() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Turma turma) {
    return ItemLista(
        turma: turma,
        alterar: () {},
        detalhes: () {},
        excluir: () {
          dao.excluir(turma.id);
          buscarTurma();
        });
  }
}

class ItemLista extends StatelessWidget {
  final Turma turma;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.turma,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(turma.nome),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: detalhes,
    );
  }
}
