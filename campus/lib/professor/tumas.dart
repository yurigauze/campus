import 'package:flutter/material.dart';

class Turma {
  final String nome;

  Turma({required this.nome});
}

class TurmasProfessor extends StatefulWidget {
  @override
  _ListaAvisosState createState() => _ListaAvisosState();
}

class _ListaAvisosState extends State<TurmasProfessor> {
  List<Turma> _avisos = [
    Turma(nome: '1º ENG Software'),
    Turma(nome: '2º ENG Software'),
  ];

  void _addAviso(Turma aviso) {
    setState(() {
      _avisos.add(aviso);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turmas'),
      ),
      body: ListView.builder(
        itemCount: _avisos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_avisos[index].nome),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) {
              String nome = '';
              return AlertDialog(
                title: Text('Adicionar Turma'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Turma',
                      ),
                      onChanged: (value) {
                        nome = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(Turma(nome: nome));
                    },
                    child: Text('Salvar'),
                  ),
                ],
              );
            },
          );

          if (result != null) {
            _addAviso(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
