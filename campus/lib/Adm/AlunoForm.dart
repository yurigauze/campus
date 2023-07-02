import 'package:campus/Widget/Botao.dart';
import 'package:campus/Widget/Campo_CPF.dart';
import 'package:campus/Widget/Campo_Telefone.dart';
import 'package:campus/Widget/Campo_email.dart';
import 'package:campus/Widget/Campo_nome.dart';
import 'package:campus/Widget/Password.dart';
import 'package:campus/controles/dto/aluno.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/interface/aluno_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/aluno_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:flutter/material.dart';

class AlunoForm extends StatefulWidget {
  const AlunoForm({Key? key}) : super(key: key);

  @override
  State<AlunoForm> createState() => _AlunoForm();
}

class _AlunoForm extends State<AlunoForm> {
  final formKey = GlobalKey<FormState>();

  dynamic id;

  @override
  Widget build(BuildContext context) {
    Future<List<Turma>> turma = TurmaDAOSQLite().consultarTodos();
    receberAlunoAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro Aluno")),
      body: Center(
          child: Container(
        width: 350,
        margin: EdgeInsets.only(top: 16),
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
          var aluno = preencherDTO();
          AlunoDao dao = AlunoDAOSQLite();
          dao.salvar(aluno);
          Navigator.pop(context);
        }
      },
    );
  }

  void receberAlunoAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Aluno aluno = parametro.settings.arguments as Aluno;
      id = aluno.id;
      preencherCampos(aluno);
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

  Aluno preencherDTO() {
    return Aluno(
      id: id,
      nome: campoNome.controle.text,
      cpf: campoCPF.controle.text,
      email: campoCPF.controle.text,
      telefone: campoEmail.controle.text,
      password: campoSenha.controle.text,
      turma: turmaSelecionado,
    );
  }

  void preencherCampos(Aluno objeto) async {
    campoNome.controle.text = objeto.nome;
    campoCPF.controle.text = objeto.cpf;
    campoEmail.controle.text = objeto.email;
    campoSenha.controle.text = objeto.password;
    confirmaSenha.controle.text = objeto.password;
    campoTelefone.controle.text = objeto.telefone;
  }
}
