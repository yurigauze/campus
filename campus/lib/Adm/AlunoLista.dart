import 'package:campus/Widget/BotaoAdc.dart';
import 'package:campus/Widget/PainelBotoes.dart';
import 'package:campus/controles/dto/aluno.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/interface/aluno_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/aluno_dao_sqlite.dart';
import 'package:flutter/material.dart';

class AlunoLista extends StatefulWidget {
  const AlunoLista({Key? key}) : super(key: key);

  @override
  State<AlunoLista> createState() => _AlunoListaState();
}

class _AlunoListaState extends State<AlunoLista> {
  AlunoDao dao = AlunoDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lista de Alunos')),
        body: criarLista(context),
        floatingActionButton: BotaoAdicionar(
            acao: () => Navigator.pushNamed(context, 'alunoForm')),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarTodos(),
      builder: (context, AsyncSnapshot<List<Aluno>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Alunos...');
        List<Aluno> listaAlunos = lista.data!;
        return ListView.builder(
          itemCount: listaAlunos.length,
          itemBuilder: (context, indice) {
            var aluno = listaAlunos[indice];
            return criarItemLista(context, aluno);
          },
        );
      },
    );
  }

  Future<List<Aluno>> buscarAluno() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Aluno aluno) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(children: [
          ItemLista(
              aluno: aluno,
              alterar: () {
                Navigator.pushNamed(context, 'alunoForm', arguments: aluno)
                    .then((value) => buscarAluno());
              },
              detalhes: () {},
              excluir: () {
                dao.excluir(aluno.id);
                buscarAluno();
              })
        ]),
      ),
    );
  }
}

class ItemLista extends StatelessWidget {
  final Aluno aluno;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.aluno,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(aluno.nome),
      subtitle: Text(aluno.turma.nome),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: alterar,
    );
  }
}
