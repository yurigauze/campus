import 'package:campus/src/Widget/Botao.dart';
import 'package:campus/src/Widget/Campo_nome.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/turma_dao_interface.dart';
import 'package:campus/src/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:campus/src/controles/sqlite/dao/turno_dao_sqlite.dart';
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
    Future<List<Turno>> turnos = TurnoDAOSQLite().consultarTodos();
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
                      campoOpcoes = criarCampoOpcoes(listaTurnos),
                      botaoSalvar(context),
                    ],
                  ));
            }),
      )),
    );
  }

  final campoNome = CampoNome(controle: TextEditingController());
  late DropdownButton<Turno> campoOpcoes;
  late List<Turno> listaTurnos;
  late Turno turnoSelecionado;

  Widget botaoSalvar(BuildContext context) {
    return Botao(
      context: context,
      salvar: () {
        var formState = formKey.currentState;
        if (formState != null && formState.validate()) {
          var contato = preencherDTO();
          TurmaDao dao = TurmaDAOSQLite();
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

  DropdownButton<Turno> criarCampoOpcoes(List<Turno> turno) {
    return DropdownButton<Turno>(
        hint: const Text('Turno'),
        isExpanded: true,
        items: turno
            .map((turno) =>
                DropdownMenuItem(value: turno, child: Text(turno.nome)))
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value != null) turnoSelecionado = value;
          });
        });
  }

  Turma preencherDTO() {
    return Turma(
      id: id,
      nome: campoNome.controle.text,
      turno: turnoSelecionado,
    );
  }

  void preencherCampos(Turma objeto) async {
    campoNome.controle.text = objeto.nome;
  }
}
