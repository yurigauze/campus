import 'package:campus/introducao.dart';
import 'package:campus/professor/tumas.dart';
import 'package:flutter/material.dart';
import 'package:campus/app.dart';

import 'dispararAvisos.dart';

class HomeProfessor extends StatelessWidget {
  const HomeProfessor({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      drawer: Drawer(
        child: SafeArea(
            child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.message_outlined),
              title: const Text('Avisos'),
              onTap: () {
                Navigator.popAndPushNamed(context, 'avisosProfessor');
              },
            ),
            ListTile(
              leading: Icon(Icons.message_outlined),
              title: const Text('Disparar Avisos'),
              onTap: () {
                Navigator.popAndPushNamed(context, 'dispararprofessor');
              },
            ),
            ListTile(
              leading: Icon(Icons.school_outlined),
              title: const Text('Turmas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TurmasProfessor()),
                );
              },
            ),
            ListTile(
                title: Text('Sair'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Introducao()),
                  );
                }),
          ],
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selecione uma opção",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "No menu lateral ou no botão Adicionar Avisos",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 50,
              height: 50, // Espaço desejado
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DispararAvisos()),
                );
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
