import 'package:flutter/material.dart';

class AvisosProfessor extends StatelessWidget {
  f


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Disparar para Turma'),
      ),
      body: ListView.builder(
        itemCount: avisos.length,
        itemBuilder: (BuildContext context, int index) {
          Aviso aviso = avisos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalhesAvisoScreen(aviso: aviso),
                ),
              );
            },
            child: ListTile(
              title: Text(aviso.titulo),
              subtitle: Text(aviso.corpo),
            ),
          );
        },
      ),
    );
  }
}

class DetalhesAvisoScreen extends StatelessWidget {
  final Aviso aviso;

  DetalhesAvisoScreen({required this.aviso});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do aviso'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              aviso.titulo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              aviso.corpo,
              style: TextStyle(fontSize: 16),
            ),

            
          ],
        ),
      ),
    );
  }
}
