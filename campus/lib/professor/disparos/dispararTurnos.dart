import 'package:flutter/material.dart';

class DispararTurnosProfessor extends StatelessWidget {
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
        body: DispararTurnoProf(),
      ),
    );
  }
}

class DispararTurnoProf extends StatefulWidget {
  @override
  _DispararTurmaProfessorState createState() => _DispararTurmaProfessorState();
}

TextEditingController _Titulo = TextEditingController();
TextEditingController _Texto = TextEditingController();

class _DispararTurmaProfessorState extends State<DispararTurnoProf> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Selecione o Turno:  '),
            DropdownButton<String>(
              value: _selectedItem,
              items: [
                DropdownMenuItem(
                  child: Text("Matutino"),
                  value: "Matutino",
                ),
                DropdownMenuItem(
                  child: Text("Vespertino"),
                  value: "Vespertino",
                ),
                DropdownMenuItem(
                  child: Text("Integral"),
                  value: "Matheus",
                ),
                DropdownMenuItem(
                  child: Text("Noturno"),
                  value: "Noturno",
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
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Enviar para o turno: $_selectedItem"),
                content: Text("Titulo: $titulo \nTexto: $texto"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Fechar"),
                  ),
                ],
              ),
            );
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
}
