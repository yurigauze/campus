import 'package:campus/controles/daofake/aviso_dao_fake.dart';
import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:flutter/material.dart';

class DispararTurmaProfessor extends StatelessWidget {
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
            Text('Selecione a Turma:  '),
            DropdownButton<String>(
              value: _selectedItem,
              items: [
                DropdownMenuItem(
                  child: Text("1º Eng. Software"),
                  value: "1ES",
                ),
                DropdownMenuItem(
                  child: Text("2º Eng. Software"),
                  value: "2ES",
                ),
                DropdownMenuItem(
                  child: Text("3º Eng. Software"),
                  value: "3ES",
                ),
                DropdownMenuItem(
                  child: Text("4º Eng. Software"),
                  value: "4ES",
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
                  content: Text("Selecione uma Turma"),
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
              AvisoDao dao = AvisoDAOFake();
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
