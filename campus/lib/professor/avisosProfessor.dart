import 'package:flutter/material.dart';

class AvisosProfessor extends StatelessWidget {
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
        body: AvisosProf(),
      ),
    );
  }
}

class AvisosProf extends StatefulWidget {
  @override
  _AvisosProfessorState createState() => _AvisosProfessorState();
}

class _AvisosProfessorState extends State<AvisosProf> {
  final List<Aviso> avisos = [
    Aviso(titulo: 'Aviso 1', corpo: 'Texto aviso 1'),
    Aviso(titulo: 'Aviso 2', corpo: 'Texto aviso 2'),
    Aviso(titulo: 'Aviso 3', corpo: 'Texto aviso 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class Aviso {
  final String titulo;
  final String corpo;

  Aviso({required this.titulo, required this.corpo});
}
