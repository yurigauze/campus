import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/turma_dao_interface.dart';
import 'package:campus/src/controles/interface/turno_dao_inerface.dart';
import 'package:campus/src/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:campus/src/controles/sqlite/dao/turno_dao_sqlite.dart';
import 'package:flutter/material.dart';

class TurmaLista extends StatefulWidget {
  TurmaLista({Key? key}) : super(key: key);

  @override
  State<TurmaLista> createState() => _TurmaListaState();
}

class _TurmaListaState extends State<TurmaLista> {
  TurmaDao dao = TurmaDAOSQLite();
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

  Future<List<Turno>> buscarTurnos() async {
    TurnoDao turnoDAO = TurnoDAOSQLite();
    List<Turno> turnos = await turnoDAO.consultarTodos();
    return turnos;
  }

  @override
  Widget criarLista(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          floatingActionButton:
          FloatingActionButton(
            onPressed: () {
              abrirDialogOpcoes(context);
            },
            child: Icon(Icons.add),
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

  late DropdownButton<Turma> campoOpcoes;
  late List<Turma> listaTurma;
  late Turma turmaSelecionado;

  void abrirDialogOpcoes(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        campoOpcoes = criarCampoOpcoes(listaTurma);
        return AlertDialog(
          actions: [
            campoOpcoes,
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  DropdownButton<Turma> criarCampoOpcoes(List<Turma> turma) {
    return DropdownButton<Turma>(
        hint: const Text('Turma'),
        isExpanded: true,
        items: turma
            .map((turma) =>
                DropdownMenuItem(value: turma, child: Text(turma.nome)))
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value != null) turmaSelecionado = value;
          });
        });
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
    turnoSelecionado = turma.turno.id;
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
          Text(turma.turno.nome),
        ],
      ),
    );
  }
}
