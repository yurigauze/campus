import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/aviso_dao_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:campus/controles/dto/aviso.dart';

class DispararTodosProfessor extends StatelessWidget {
  DispararTodosProfessor({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  dynamic id;

  TextEditingController _Titulo = TextEditingController();
  TextEditingController _Texto = TextEditingController();

  @override
  void dispose() {
    _Titulo.dispose();
    _Texto.dispose();
  }

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
                  var titulos = _Titulo.text;
                  var textos = _Texto.text;

                  if (titulos == "" && textos == "") {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Erro"),
                        content: Text("Insira um Titulo e uma mensagem"),
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
                    AvisoDao dao = ContatoDAOSQLite();
                    dao.salvar(aviso);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("$titulos"),
                        content: Text("$textos"),
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
          ),
        ),
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

  void preencherCampos(Aviso aviso) {
    _Titulo.text = aviso.titulo;
    _Texto.text = aviso.corpo;
  }
}
