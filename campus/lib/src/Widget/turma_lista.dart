import 'package:campus/src/Widget/BotaoAdc.dart';
import 'package:campus/src/Widget/PainelBotoes.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/turno_dao_inerface.dart';
import 'package:campus/src/controles/sqlite/dao/turno_dao_sqlite.dart';
import 'package:flutter/material.dart';

class TurnoLista extends StatefulWidget {
  const TurnoLista({Key? key}) : super(key: key);

  @override
  State<TurnoLista> createState() => _TurnoListaState();
}

class _TurnoListaState extends State<TurnoLista> {
  TurnoDao dao = TurnoDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Turno")),
      body: criarLista(context),
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: buscarTurno(),
      builder: (context, AsyncSnapshot<List<Turno>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Turnos...');
        List<Turno> listaTurnos = lista.data!;
        return ListView.builder(
          itemCount: listaTurnos.length,
          itemBuilder: (context, indice) {
            var contato = listaTurnos[indice];
            return criarItemLista(context, contato);
          },
        );
      },
    );
  }

  Future<List<Turno>> buscarTurno() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Turno turno) {
    return ItemLista(
        turno: turno,
        alterar: () {},
        detalhes: () {},
        excluir: () {
          dao.excluir(turno.id);
          buscarTurno();
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
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: detalhes,
    );
  }
}
