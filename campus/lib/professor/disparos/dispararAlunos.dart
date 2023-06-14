import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/aviso_dao_sqlite.dart';
import 'package:flutter/material.dart';

class DispararAlunosProfessor extends StatelessWidget {
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
        body: DispararAlunosProf(),
      ),
    );
  }
}

class DispararAlunosProf extends StatefulWidget {
  @override
  _DispararTurmaProfessorState createState() => _DispararTurmaProfessorState();
}

class _DispararTurmaProfessorState extends State<DispararAlunosProf> {
  TextEditingController _Titulo = TextEditingController();
  TextEditingController _Texto = TextEditingController();

  @override
  void dispose() {
    _Titulo.dispose();
    _Texto.dispose();
    super.dispose();
  }

  String? _selectedItem;
  dynamic id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Selecione o Aluno:  '),
            DropdownButton<String>(
              value: _selectedItem,
              items: [
                DropdownMenuItem(
                  child: Text("Yuri Gauze"),
                  value: "Yuri Gauze",
                ),
                DropdownMenuItem(
                  child: Text("Pedro Henrique"),
                  value: "Pedro Henrique",
                ),
                DropdownMenuItem(
                  child: Text("Matheus"),
                  value: "Matheus",
                ),
                DropdownMenuItem(
                  child: Text("Paulo"),
                  value: "Paulo",
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
            ),
          ],
        ),
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
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _Texto,
            maxLines: 8, //or null
            maxLength: 500,
            decoration: InputDecoration.collapsed(hintText: "Qual o aviso?"),
          ),
        )),
        ElevatedButton(
          onPressed: () {
            var titulo = _Titulo.text;
            var texto = _Texto.text;

            if (_selectedItem == null || _selectedItem?.isEmpty == true) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Erro"),
                  content: Text("Selecione um aluno."),
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
                  title: Text("Enviar para o(a) Aluno(a) $_selectedItem"),
                  content: Text("Titulo: $titulo \nTexto: $texto"),
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
      ],
    );
  }

  Aviso preencherDTO() {
    return Aviso(
      id: id,
      titulo: _Titulo.text,
      corpo: _Texto.text,
      adicional: _selectedItem ?? "",
    );
  }

  void preencherCampos(Aviso aviso) {
    _Titulo.text = aviso.titulo;
    _Texto.text = aviso.corpo;
    _selectedItem = aviso.adicional;
  }
}
