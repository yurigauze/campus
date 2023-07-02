import 'package:campus/controles/dto/turma.dart';
import 'package:flutter/material.dart';

class DetalhesTurmaScreen extends StatelessWidget {
  final Turma turma;

  const DetalhesTurmaScreen({required this.turma});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes da Turma'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  turma.nome,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  turma.turno.nome,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
