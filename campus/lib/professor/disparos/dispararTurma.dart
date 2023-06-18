import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:campus/controles/interface/turma_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/aviso_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:flutter/material.dart';

class DispararTurmaProfessor extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disparar para Turma',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Disparar para Turma'),
        ),
        body: DispararTurmaProf(),
      ),
    );
  }
}

class DispararTurmaProf extends StatefulWidget {
  @override
  _DispararTurmaProfessorState createState() => _DispararTurmaProfessorState();
}

class _DispararTurmaProfessorState extends State<DispararTurmaProf> {
  TextEditingController _Titulo = TextEditingController();
  TextEditingController _Texto = TextEditingController();
  String? _selectedItem;
  Turma? turmaSelecionado;
  dynamic id;

  AvisoDao dao = AvisoDAOSQLite();

  List<Turma> turma = [];

  @override
  void initState() {
    super.initState();
    turmaSelecionado = turma.isNotEmpty ? turma[0] : null;
    buscarTurmas();
  }

  Future<void> buscarTurmas() async {
    TurmaDao turmaDao = TurmaDAOSQLite();
    List<Turma> listaTurmas = await turmaDao.consultarTodos();
    setState(() {
      turma = listaTurmas;
    });
  }

  @override
  void dispose() {
    _Titulo.dispose();
    _Texto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 390,
        margin: EdgeInsets.only(top: 16),
        child: Column(children: [
          Row(children: [
            Text('Selecione o Turno:  '),
            DropdownButton<Turma>(
              value: turmaSelecionado,
              onChanged: (Turma? novoTurma) {
                setState(() {
                  turmaSelecionado = novoTurma;
                  _selectedItem = novoTurma?.nome;
                });
              },
              items: turma.map((Turma turma) {
                return DropdownMenuItem<Turma>(
                  value: turma,
                  child: Text(turma.nome),
                );
              }).toList(),
            ),
          ]),
          SizedBox(
            width: 50,
            height: 10, // Espaço desejado
          ),
          TextField(
            controller: _Titulo,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              hintText: 'Titulo do Aviso',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(fontSize: 18),
            maxLength: 50,
          ),
          SizedBox(
            width: 50,
            height: 10, // Espaço desejado
          ),
          Card(
              color: const Color.fromARGB(255, 235, 235, 235),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _Texto,
                  maxLines: 8, //or null
                  maxLength: 500,
                  decoration:
                      InputDecoration.collapsed(hintText: "Qual o aviso?"),
                ),
              )),
          ElevatedButton(
            onPressed: () {
              var titulo = _Titulo.text;
              var texto = _Texto.text;

              if (turmaSelecionado == null || titulo == null || texto == null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content: Text("Campos em branco."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              } else {
                var aviso = preencherDTO();
                AvisoDao dao = AvisoDAOSQLite();
                dao.salvar(aviso);

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("Enviado para a Turma: $_selectedItem"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Fechar"),
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
        ]),
      ),
    );
  }

  Aviso preencherDTO() {
    return Aviso(
      id: id,
      titulo: _Titulo.text,
      corpo: _Texto.text,
      turma: turmaSelecionado,
    );
  }

  void preencherCampos(Aviso aviso) {
    _Titulo.text = aviso.titulo;
    _Texto.text = aviso.corpo;
    turmaSelecionado = aviso.turma;
  }
}
