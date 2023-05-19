import 'package:campus/introducao.dart';
import 'package:campus/professor/disparos/disparosTodos.dart';
import 'package:campus/professor/tumas.dart';
import 'package:flutter/material.dart';

import 'disparos/dispararAlunos.dart';
import 'disparos/dispararTurma.dart';
import 'disparos/dispararTurnos.dart';

class HomeProfessor extends StatelessWidget {
  Widget criarContainer() {
    return Card(
      child: Container(
        alignment: Alignment.center,
        width: 190,
        height: 190,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Disparar Avisos")),
      drawer: buildDrawer(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DispararTodosProfessor()),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Color.fromARGB(255, 235, 83, 96),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.groups_outlined,
                                size: 50.0, color: Colors.white),
                            Text(
                              'Disparar para todos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    15, // Definindo o tamanho da fonte para 20
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DispararTurmaProfessor()),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Color.fromARGB(255, 112, 204, 89),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.class_outlined,
                                size: 50.0, color: Colors.white),
                            Text(
                              'Disparar para turma',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    15, // Definindo o tamanho da fonte para 20
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: InkWell(
                    onTap: () {
                      // ação a ser executada ao clicar no Card
                      Navigator.push(
                        context,  
                        MaterialPageRoute(
                            builder: (context) => DispararAlunosProfessor()),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.blue,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people_outline,
                                size: 50.0, color: Colors.white),
                            Text(
                              'Disparar para alunos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    15, // Definindo o tamanho da fonte para 20
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      // ação a ser executada ao clicar no Card
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DispararTurnosProfessor()),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Color.fromARGB(255, 192, 102, 228),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timelapse_outlined,
                                size: 50.0, color: Colors.white),
                            Text(
                              'Disparar para turnos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    15, // Definindo o tamanho da fonte para 20
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.notifications_active_outlined,
                color: Colors.black,
              ),
              title: const Text('Avisos'),
              onTap: () {
                Navigator.popAndPushNamed(context, 'avisosProfessor2');
              },
            ),
            ListTile(
              leading: Icon(Icons.school_outlined, color: Colors.black),
              title: const Text('Turmas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TurmasProfessor()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Sair'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Introducao()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: SafeArea(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
            title: const Text('Avisos'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'avisosProfessor');
            },
          ),
          ListTile(
            leading: Icon(Icons.message_outlined, color: Colors.black),
            title: const Text('Disparar Avisos'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'dispararprofessor');
            },
          ),
          ListTile(
            leading: Icon(Icons.school_outlined, color: Colors.black),
            title: const Text('Turmas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TurmasProfessor()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Introducao()),
              );
            },
          ),
        ],
      ),
    ),
  );
}
