import 'package:campus/src/Widget/BotaoAdc.dart';
import 'package:campus/src/Widget/PainelBotoes.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/interface/turma_dao_interface.dart';
import 'package:campus/src/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:flutter/material.dart';

class TurmasLista extends StatefulWidget {
  const TurmasLista({Key? key}) : super(key: key);

  @override
  State<TurmasLista> createState() => _TurmasListaState();
}

class _TurmasListaState extends State<TurmasLista> {
  TurmaDao dao = TurmaDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lista Turmas')),
        body: criarLista(context),
        floatingActionButton: BotaoAdicionar(
            acao: () => Navigator.pushNamed(context, 'turmaForm')),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }

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

  Future<List<Turma>> buscarTurma() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Turma turma) {
    return ItemLista(
        turma: turma,
        alterar: () {
          Navigator.pushNamed(context, 'turmaForm', arguments: turma)
              .then((value) => buscarTurma());
        },
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
      subtitle: Text(turma.turno.nome),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: alterar,
    );
  }
}
