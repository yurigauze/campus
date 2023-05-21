import 'package:campus/controles/dto/aviso.dart';
import 'package:flutter/material.dart';

class DetalhesAvisoScreen extends StatelessWidget {
  final Aviso aviso;

  const DetalhesAvisoScreen({required this.aviso});

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
                if (aviso.adicional != null && aviso.adicional!.isNotEmpty)
                  Text(
                    'Aviso enviado para:',
                    style: TextStyle(fontSize: 16),
                  ),
                if (aviso.adicional != null && aviso.adicional!.isNotEmpty)
                  Text(aviso.adicional!),
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
