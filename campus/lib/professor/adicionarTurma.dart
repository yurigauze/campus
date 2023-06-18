import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/dto/turno.dart';
import 'package:campus/controles/interface/turma_dao_interface.dart';
import 'package:campus/controles/interface/turno_dao_inerface.dart';
import 'package:campus/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turno_dao_sqlite.dart';
import 'package:flutter/material.dart';

class AdicionarTurma extends StatefulWidget {
  AdicionarTurma({Key? key}) : super(key: key);

  @override
  State<AdicionarTurma> createState() => _AdicionarTurmaState();
}

class _AdicionarTurmaState extends State<AdicionarTurma> {
  final formKey = GlobalKey<FormState>();

  dynamic id;

  TurmaDao dao = TurmaDAOSQLite();

  TextEditingController _Nome = TextEditingController();

  Turno? turnoSelecionados;
  Turno? turnoSelecionado;

  @override
  void dispose() {
    _Nome.dispose();
    super.dispose();
  }

  List<Turno> turnos = [];

  @override
  void initState() {
    super.initState();
    turnoSelecionado = turnos.isNotEmpty ? turnos[0] : null;
    buscarTurnos();
  }

  Future<void> buscarTurnos() async {
    TurnoDao turnoDAO = TurnoDAOSQLite();
    List<Turno> listaTurnos = await turnoDAO.consultarTodos();
    setState(() {
      turnos = listaTurnos;
    });
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
              Text('Selecione um turno:'),
              DropdownButton<Turno>(
                value: turnoSelecionado,
                onChanged: (Turno? novoTurno) {
                  setState(() {
                    turnoSelecionado = novoTurno;
                  });
                },
                items: turnos.map((Turno turno) {
                  return DropdownMenuItem<Turno>(
                    value: turno,
                    child: Text(turno.nome),
                  );
                }).toList(),
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
                    TurmaDao dao = TurmaDAOSQLite();
                    dao.salvar(turma);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Turma Adicionada!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Fecha o AlertDialog
                              Navigator.pop(context); // Retorna à tela anterior
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
    final selectedTurno = turnoSelecionado ?? turnos.first;
    return Turma(
      id: id,
      nome: _Nome.text,
      turno: selectedTurno, // Valor padrão caso seja nulo
    );
  }

  void preencherCampos(Turma turma) {
    _Nome.text = turma.nome;
    turnoSelecionados = turma.turno;
  }
}
