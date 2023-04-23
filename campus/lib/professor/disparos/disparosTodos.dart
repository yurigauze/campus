import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

TextEditingController _Titulo = TextEditingController();
TextEditingController _Texto = TextEditingController();

class DispararTodosProfessor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avisos para Todos"),
      ),
      body: Center(
        child: Container(
          width: 400,
          margin: EdgeInsets.only(top: 16),
          child: Column(
            children: [
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
              SizedBox(
                width: 50, // Espaço desejado
              ),
              ElevatedButton(
                onPressed: () {
                  var titulo = _Titulo.text;
                  var texto = _Texto.text;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("$titulo"),
                      content: Text("$texto"),
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
          ),
        ),
      ),
    );
  }
}
