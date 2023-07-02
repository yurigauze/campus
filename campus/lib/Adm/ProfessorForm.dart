import 'package:campus/Widget/Botao.dart';
import 'package:campus/Widget/Campo_CPF.dart';
import 'package:campus/Widget/Campo_Telefone.dart';
import 'package:campus/Widget/Campo_email.dart';
import 'package:campus/Widget/Campo_nome.dart';
import 'package:campus/Widget/Password.dart';
import 'package:campus/controles/dto/professor.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/interface/professor_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/professor_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:flutter/material.dart';

class ProfessorForm extends StatefulWidget {
  const ProfessorForm({Key? key}) : super(key: key);

  @override
  State<ProfessorForm> createState() => _ProfessorForm();
}

class _ProfessorForm extends State<ProfessorForm> {
  final formKey = GlobalKey<FormState>();

  dynamic id;

  @override
  Widget build(BuildContext context) {
    Future<List<Turma>> turma = TurmaDAOSQLite().consultarTodos();
    receberProfessorAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro Professor")),
      body: Center(
          child: Container(
        width: 350,
        margin: const EdgeInsets.only(top: 16),
        child: FutureBuilder(
            future: turma,
            builder: (context, AsyncSnapshot<List<Turma>> lista) {
              if (!lista.hasData || lista.data == null)
                return const Text("Não há turmas cadastradas");
              listaTurma = lista.data!;
              return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      campoNome,
                      campoCPF,
                      campoEmail,
                      campoTelefone,
                      campoSenha,
                      confirmaSenha,
                      campoOpcoes = criarCampoOpcoes(listaTurma),
                      botaoSalvar(context),
                    ],
                  ));
            }),
      )),
    );
  }

  final campoNome = CampoNome(controle: TextEditingController());
  final campoEmail = CampoEmail(controle: TextEditingController());
  final campoSenha = CampoSenha(controle: TextEditingController());
  final confirmaSenha = CampoSenha(controle: TextEditingController());
  final campoCPF = CampoCPF(controle: TextEditingController());
  final campoTelefone = CampoTelefone(controle: TextEditingController());
  late DropdownButton<Turma> campoOpcoes;
  late List<Turma> listaTurma;
  late Turma turmaSelecionado;

  Widget botaoSalvar(BuildContext context) {
    return Botao(
      context: context,
      salvar: () {
        var formState = formKey.currentState;
        if (formState != null && formState.validate()) {
          var professor = preencherDTO();
          ProfessorDao dao = ProfessorDAOSQLite();
          dao.salvar(professor);
          Navigator.pop(context);
        }
      },
    );
  }

  void receberProfessorAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Professor professor = parametro.settings.arguments as Professor;
      id = professor.id;
      preencherCampos(professor);
    }
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

  Professor preencherDTO() {
    return Professor(
      id: id,
      nome: campoNome.controle.text,
      cpf: campoCPF.controle.text,
      email: campoCPF.controle.text,
      telefone: campoEmail.controle.text,
      password: campoSenha.controle.text,
      turma: turmaSelecionado,
    );
  }

  void preencherCampos(Professor objeto) async {
    campoNome.controle.text = objeto.nome;
    campoCPF.controle.text = objeto.cpf;
    campoEmail.controle.text = objeto.email;
    campoSenha.controle.text = objeto.password;
    confirmaSenha.controle.text = objeto.password;
    campoTelefone.controle.text = objeto.telefone;
  }
}
