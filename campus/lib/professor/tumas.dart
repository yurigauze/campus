import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/interface/turma_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:campus/professor/detalhesTurma.dart';
import 'package:campus/professor/turma/telaTurma.dart';
import 'package:campus/rota.dart';
import 'package:campus/widgets/botaoAdicionar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:flutter/material.dart';

class TurmaLista extends StatefulWidget {
  TurmaLista({Key? key}) : super(key: key);

  @override
  State<TurmaLista> createState() => _TurmaListaState();
}

class _TurmaListaState extends State<TurmaLista> {
  dynamic id;

  String nome = '';

  String turno = '';

  TurmaDao dao = TurmaDAOSQlite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Turmas'),
      ),
      body: criarLista(context),
      floatingActionButton: BotaoAdicionar(
          acao: () => Navigator.pushNamed(context, Rota.turmaForm).then((value) => buscarTurma())),
    );

  }

  
  Future<List<Turma>> buscarTurma() {
    setState(() {});
    return dao.consultarTodos();
  }

  @override
  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarTodos(),
      builder: (context, AsyncSnapshot<List<Turma>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Turmas...');
        List<Turma> listaTurmas = lista.data!;
        return ListView.builder(
          itemCount: listaTurmas.length,
          itemBuilder: (context, indice) {
            var turma = listaTurmas[indice];
            return criarItemLista(context, turma);
          },
        );
      },
    );
  }

    Widget criarItemLista(BuildContext context, Turma turma) {
    return ItemLista(
        turma: turma,
        alterar: () {},
        detalhes: () {},
        excluir: () {
          dao.excluir(turma.id);
        });
  }

  Turma preencherDTO() {
    return Turma(
      id: id,
      nome: nome,
      turno: turno,
    );
  }

  void preencherCampos(Turma turma) {
    nome = turma.nome;
    turno = turma.turno;
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(turma.turno),
        ],
      ),
        onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TurmaForm()
          ),
        );
      },

    );
  }
}

