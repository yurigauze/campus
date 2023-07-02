import 'package:campus/Adm/AlunoLista.dart';
import 'package:campus/Adm/ProfessorLista.dart';
import 'package:campus/Adm/TurmaLista.dart';
import 'package:campus/contatos.dart';
import 'package:campus/introducao.dart';
import 'package:campus/Adm/TurnoLista.dart';
import 'package:flutter/material.dart';

class HomeAdministracao extends StatelessWidget {
  const HomeAdministracao({super.key});

  Widget criarContainer() {
    return Card(
      child: Container(
        alignment: Alignment.center,
        width: 170,
        height: 170,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Início")),
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
                        MaterialPageRoute(builder: (context) => AlunoLista()),
                      );
                    },
                    child: Container(
                      width: 170,
                      height: 170,
                      color: Color.fromARGB(255, 235, 83, 96),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.groups_outlined,
                                size: 50.0, color: Colors.white),
                            Text(
                              'Gerenciar Alunos',
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
                        MaterialPageRoute(builder: (context) => TurmasLista()),
                      );
                    },
                    child: Container(
                      width: 170,
                      height: 170,
                      color: Color.fromARGB(255, 112, 204, 89),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.class_outlined,
                                size: 50.0, color: Colors.white),
                            Text(
                              'Gerenciar Turmas',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfessorLista()),
                      );
                    },
                    child: Container(
                      width: 170,
                      height: 170,
                      color: Colors.blue,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people_outline,
                                size: 50.0, color: Colors.white),
                            Text(
                              'Gerenciar Professores',
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
                              builder: (context) => TurnoLista()));
                    },
                    child: Container(
                      width: 170,
                      height: 170,
                      color: Color.fromARGB(255, 192, 102, 228),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timelapse_outlined,
                                size: 50.0, color: Colors.white),
                            Text(
                              'Gerenciar Turnos',
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
              leading: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.black,
              ),
              title: const Text('Avisos'),
              onTap: () {
                Navigator.popAndPushNamed(context, 'avisosProfessor2');
              },
            ),
            ListTile(
              leading: const Icon(Icons.school_outlined, color: Colors.black),
              title: const Text('Turmas'),
              onTap: () {
                Navigator.popAndPushNamed(context, 'turmas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.school_outlined, color: Colors.black),
              title: const Text('Turnos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TurnoLista()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.phone_outlined, color: Colors.black),
              title: const Text('Contatos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Contatos()),
                );
              },
            ),
            ListTile(
              title: const Text('Sair'),
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
