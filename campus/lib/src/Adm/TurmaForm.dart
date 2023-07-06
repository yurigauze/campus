import 'package:campus/src/Widget/Botao.dart';
import 'package:campus/src/Widget/Campo_nome.dart';
import 'package:campus/src/controles/database/firestore/turma_dao_firestore.dart';
import 'package:campus/src/controles/database/firestore/turno_dao_firestore.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/firebase/turma_interface_firebase.dart';
import 'package:campus/src/controles/interface/turma_dao_interface.dart';

import 'package:flutter/material.dart';

class DetalhesTurmaScreen extends StatefulWidget {
  const DetalhesTurmaScreen({Key? key}) : super(key: key);

  @override
  State<DetalhesTurmaScreen> createState() => _DetalhesTurmaScreenState();
}

class _DetalhesTurmaScreenState extends State<DetalhesTurmaScreen> {
  final formKey = GlobalKey<FormState>();

  dynamic id;

  @override
  Widget build(BuildContext context) {
    Future<List<Turno>> turnos = TurnoDAOFirebase().consultarTodos();
    receberTurmaAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro Turma")),
      body: Center(
          child: Container(
        width: 390,
        margin: EdgeInsets.only(top: 16),
        child: FutureBuilder(
            future: turnos,
            builder: (context, AsyncSnapshot<List<Turno>> lista) {
              if (!lista.hasData || lista.data == null)
                return const Text("Não há turnos cadastrados");
              listaTurnos = lista.data!;
              return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      campoNome,
                      botaoSalvar(context),
                    ],
                  ));
            }),
      )),
    );
  }

  final campoNome = CampoNome(controle: TextEditingController());
  late List<Turno> listaTurnos;
  late Turno turnoSelecionado;

  Widget botaoSalvar(BuildContext context) {
    return Botao(
      context: context,
      salvar: () {
        var formState = formKey.currentState;
        if (formState != null && formState.validate()) {
          var contato = preencherDTO();
          TurmaFireDao dao = TurmaDAOFirestore();
          dao.salvar(contato);
          Navigator.pop(context);
        }
      },
    );
  }

  void receberTurmaAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Turma turma = parametro.settings.arguments as Turma;
      id = turma.id;
      preencherCampos(turma);
    }
  }

  Turma preencherDTO() {
    return Turma(
      id: id,
      nome: campoNome.controle.text,
      alunos: [],
    );
  }

  void preencherCampos(Turma objeto) async {
    campoNome.controle.text = objeto.nome;
  }
}
