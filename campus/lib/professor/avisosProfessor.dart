import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/aviso_dao_sqlite.dart';
import 'package:campus/professor/detalhesAvisos.dart';
import 'package:flutter/material.dart';

class AvisoLista extends StatelessWidget {
  AvisoLista({Key? key}) : super(key: key);
  AvisoDao dao = AvisoDAOSQLite();

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
      builder: (context, AsyncSnapshot<List<Aviso>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há avisos...');
        List<Aviso> listaAvisos = lista.data!;
        return ListView.builder(
          itemCount: listaAvisos.length,
          itemBuilder: (context, indice) {
            var aviso = listaAvisos[indice];
            return criarItemLista(context, aviso);
          },
        );
      },
    );
  }

  Widget criarItemLista(BuildContext context, Aviso aviso) {
    return ItemLista(
        aviso: aviso,
        alterar: () {},
        detalhes: () {},
        excluir: () {
          dao.excluir(aviso.id);
        });
  }
}

class ItemLista extends StatelessWidget {
  final Aviso aviso;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.aviso,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(aviso.titulo),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: aviso.adicional != null,
            child: Text(aviso.adicional ?? ''),
          ),
          Text(aviso.corpo),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesAvisoScreen(aviso: aviso),
          ),
        );
      },
    );
  }
}
