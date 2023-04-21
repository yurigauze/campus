import 'package:campus/introducao.dart';
import 'package:campus/professor/tumas.dart';
import 'package:flutter/material.dart';
import 'package:campus/app.dart';

class HomeProfessor extends StatelessWidget {
  const HomeProfessor({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("O instituto")),
        drawer: Drawer(
          child: SafeArea(
              child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.message_outlined),
                title: const Text('Avisos'),
                onTap: () {
                  Navigator.popAndPushNamed(context, 'avisos');
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
                    MaterialPageRoute(
                        builder: (context) => TurmasProfessor()),
                  );
                },
              ),
              
               ListTile(
                  title: Text('Sair'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Introducao()),);

                  }),
            ],
          )),
        ),
        body: null);
  }
}
