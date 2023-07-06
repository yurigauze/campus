import 'package:campus/src/controles/database/firestore/turma_dao_firestore.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/firebase/turma_interface_firebase.dart';
import 'package:campus/src/controles/interface/turma_dao_interface.dart';
import 'package:campus/src/controles/interface/turno_dao_inerface.dart';

import 'package:flutter/material.dart';
import 'package:campus/src/professor/turmas.dart';

class AdicionarTurma extends StatefulWidget {
  AdicionarTurma({Key? key}) : super(key: key);

  @override
  State<AdicionarTurma> createState() => _AdicionarTurmaState();
}

class _AdicionarTurmaState extends State<AdicionarTurma> {
  final formKey = GlobalKey<FormState>();

  dynamic id;

  TurmaFireDao dao = TurmaDAOFirestore();

  TextEditingController _Nome = TextEditingController();

  Turno? turnoSelecionados;
  Turno? turnoSelecionado;

  @override
  void dispose() {
    _Nome.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Turma"),
      ),
      body: Center(
        child: Container(
          width: 390,
          margin: EdgeInsets.only(top: 16),
          child: Column(
            children: [
              TextField(
                controller: _Nome,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  hintText: 'Nome da Turma',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 18),
                maxLength: 50,
              ),
              SizedBox(
                width: 50, // Espaço desejado
              ),
              ElevatedButton(
                onPressed: () async {
                  var titulos = _Nome.text;

                  if (turnoSelecionado == null || _Nome == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Erro"),
                        content: Text("Selecione um turno."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    var turma = preencherDTO();
                    TurmaFireDao dao = TurmaDAOFirestore();
                    dao.salvar(turma);

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Turma Adicionada!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Fecha o AlertDialog
                              Navigator.pop(
                                  context, true); // Retorna à tela anterior
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Container(
                  height: 40,
                  width: 70,
                  child: Row(
                    children: [
                      Text('Enviar'),
                      Text(' '),
                      Icon(Icons.send, size: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Turma preencherDTO() {
    return Turma(
      id: id,
      nome: _Nome.text,
      alunos: [], // Valor padrão caso seja nulo
    );
  }

  void preencherCampos(Turma turma) {
    _Nome.text = turma.nome;
  }
}
