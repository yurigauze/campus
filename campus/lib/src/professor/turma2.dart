import 'package:campus/src/controles/database/firestore/turma_dao_firestore.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/interface/firebase/turma_interface_firebase.dart';
import 'package:campus/src/professor/adicionarTurma.dart';
import 'package:campus/src/professor/detalhesTurma.dart';
import 'package:flutter/material.dart';

class TurmaLista extends StatefulWidget {
  TurmaLista({Key? key}) : super(key: key);

  @override
  State<TurmaLista> createState() => _TurmaListaState();
}

class _TurmaListaState extends State<TurmaLista> {
  TurmaFireDao dao = TurmaDAOFirestore();
  TextEditingController _Nome = TextEditingController();
  String? turnoSelecionado;
  dynamic id;

  @override
  void dispose() {
    _Nome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Turma'),
        ),
        body: criarLista(context));
  }

  @override
  Widget criarLista(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionarTurma()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: dao.consultarTodos(),
        builder: (context, AsyncSnapshot<List<Turma>> lista) {
          if (!lista.hasData) return const CircularProgressIndicator();
          if (lista.data == null) return const Text('Não há turmas...');
          List<Turma> listaTurma = lista.data!;
          return ListView.builder(
            itemCount: listaTurma.length,
            itemBuilder: (context, indice) {
              var aviso = listaTurma[indice];
              return criarItemLista(context, aviso);
            },
          );
        },
      ),
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

  void preencherCampos(Turma turma) {
    _Nome.text = turma.nome;
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesTurmaScreen(turma: turma),
          ),
        );
      },
    );
  }
}
