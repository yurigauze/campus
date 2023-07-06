import 'package:campus/src/controles/dto/aviso.dart';
import 'package:flutter/material.dart';

class DetalhesAvisoScreen extends StatelessWidget {
  final Aviso aviso;

  DetalhesAvisoScreen({required this.aviso});

  String turma = '', turno = '', alunos = '', texto = '';

  void atribuirNome() {
    texto = turma + turno + alunos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Aviso'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  aviso.titulo,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                  Visibility(
                  visible: aviso.informacao != null,
                  child: Column(
                    children: [
                      Text(
                        'Aviso enviado para:',
                        style: TextStyle(fontSize: 16),
                      ),                     
                      if (aviso.informacao != null)
                        Text('Turno: ${aviso.informacao}'),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  aviso.corpo,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
