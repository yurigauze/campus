import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/dto/turno.dart';

import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:campus/controles/interface/turno_dao_inerface.dart';
import 'package:campus/controles/sqlite/dao/aviso_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turno_dao_sqlite.dart';

import 'package:flutter/material.dart';

class DispararTurnosProfessor extends StatelessWidget {
  DispararTurnosProfessor({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disparar para Turno',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Disparar para Turno'),
        ),
        body: DispararTurnoProf(),
      ),
    );
  }
}

class DispararTurnoProf extends StatefulWidget {
  @override
  _DispararTurmaProfessorState createState() => _DispararTurmaProfessorState();
}

class _DispararTurmaProfessorState extends State<DispararTurnoProf> {
  final formkey = GlobalKey<FormState>();
  dynamic id;
  AvisoDao dao = AvisoDAOSQLite();

  TextEditingController _Titulo = TextEditingController();
  TextEditingController _Texto = TextEditingController();
  String? _selectedItem;
  Turno? turnoSelecionado;
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
            DropdownButton<Turno>(
              value: turnoSelecionado,
              onChanged: (Turno? novoTurno) {
                setState(() {
                  turnoSelecionado = novoTurno;
                  _selectedItem = novoTurno?.nome;
                });
              },
              items: turnos.map((Turno turno) {
                return DropdownMenuItem<Turno>(
                  value: turno,
                  child: Text(turno.nome),
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

              if (turnoSelecionado == null || titulo == null || texto == null) {
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
                int? idTurma = turnoSelecionado?.id;
                var aviso = preencherDTO();
                AvisoDao dao = AvisoDAOSQLite();
                dao.salvarAvisoTurno(aviso, idTurma ?? 0);

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("Enviado para a turno: $_selectedItem"),
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
    );
  }
}
