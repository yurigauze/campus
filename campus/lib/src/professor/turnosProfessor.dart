import 'package:campus/src/controles/database/firestore/turno_dao_firestore.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/firebase/turno_interface_firebase.dart';
import 'package:campus/src/controles/interface/turno_dao_inerface.dart';

import 'package:flutter/material.dart';

class TurnoLista extends StatelessWidget {
  TurnoLista({Key? key}) : super(key: key);
  TurnoFireDao dao = TurnoDAOFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Disparar para Turma'),
        ),
        body: criarLista(context));
  }

  @override
  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarTodos(),
      builder: (context, AsyncSnapshot<List<Turno>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Turnos...');
        List<Turno> listaTurno = lista.data!;
        return ListView.builder(
          itemCount: listaTurno.length,
          itemBuilder: (context, indice) {
            var turno = listaTurno[indice];
            return criarItemLista(context, turno);
          },
        );
      },
    );
  }

  Widget criarItemLista(BuildContext context, Turno turno) {
    return ItemLista(
        turno: turno,
        alterar: () {},
        detalhes: () {},
        excluir: () {
          dao.excluir(turno.id);
        });
  }
}

class ItemLista extends StatelessWidget {
  final Turno turno;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.turno,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(turno.nome),
    );
  }
}
