import 'package:campus/src/Widget/BotaoAdc.dart';
import 'package:campus/src/Widget/PainelBotoes.dart';
import 'package:campus/src/controles/dto/professor.dart';
import 'package:campus/src/controles/interface/professor_dao_interface.dart';
import 'package:campus/src/controles/sqlite/dao/professor_dao_sqlite.dart';
import 'package:flutter/material.dart';

class ProfessorLista extends StatefulWidget {
  const ProfessorLista({Key? key}) : super(key: key);

  @override
  State<ProfessorLista> createState() => _ProfessorListaState();
}

class _ProfessorListaState extends State<ProfessorLista> {
  ProfessorDao dao = ProfessorDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lista de Professores')),
        body: criarLista(context),
        floatingActionButton: BotaoAdicionar(
            acao: () => Navigator.pushNamed(context, 'professorForm')),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarTodos(),
      builder: (context, AsyncSnapshot<List<Professor>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Professores...');
        List<Professor> listaProfessores = lista.data!;
        return ListView.builder(
          itemCount: listaProfessores.length,
          itemBuilder: (context, indice) {
            var professoraluno = listaProfessores[indice];
            return criarItemLista(context, professoraluno);
          },
        );
      },
    );
  }

  Future<List<Professor>> buscarProfessor() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Professor professor) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(children: [
          ItemLista(
              professor: professor,
              alterar: () {
                Navigator.pushNamed(context, 'professorForm',
                        arguments: professor)
                    .then((value) => buscarProfessor());
              },
              detalhes: () {},
              excluir: () {
                dao.excluir(professor.id);
                buscarProfessor();
              })
        ]),
      ),
    );
  }
}

class ItemLista extends StatelessWidget {
  final Professor professor;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.professor,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(professor.nome),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: alterar,
    );
  }
}
