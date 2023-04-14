import 'package:campus/introducao.dart';
import 'package:flutter/material.dart';
import 'package:campus/app.dart';

class HomeAluno extends StatelessWidget {
  const HomeAluno({super.key});

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
                  Navigator.pushNamed(context, 'avisos');
                },
              ),
              ExpansionTile(
                title: Text("Cursos ofertados"),
                leading: Icon(Icons.info_outline), //add icon
                childrenPadding: EdgeInsets.only(left: 60), //children padding
                children: [
                  ListTile(
                    title: Text("Tecnico Integrado"),
                    onTap: () {
                       Navigator.popAndPushNamed(context, 'tecnicoIntegrado');
                    },
                  ),

                  ListTile(
                    title: Text("Tecnico Subsequente"),
                    onTap: () {
                       Navigator.popAndPushNamed(context, 'tecnicoSubsequente');
                    },
                  ),
                  ListTile(
                    title: Text("Curso Superiores"),
                    onTap: () {
                       Navigator.popAndPushNamed(context, 'cursoSuperior');
                    },
                  ),
                  ListTile(
                    title: Text("Pós Graduação"),
                    onTap: () {
                       Navigator.popAndPushNamed(context, 'posGraduacao');
                    },
                  ),

                  //more child menu
                ],
              ),
              ExpansionTile(
                title: Text("Infraestrutura"),
                leading: Icon(Icons.info_outline), //add icon
                childrenPadding: EdgeInsets.only(left: 60), //children padding
                children: [
                  ListTile(
                    title: Text("Biblioteca"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, 'biblioteca');
                    },
                  ),

                  ListTile(
                    title: Text("Laboratorios"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, 'laboratorio');
                    },
                  ),
                  ListTile(
                    title: Text("Administração"),
                    onTap: () {
                     Navigator.popAndPushNamed(context, 'Administracao');
                    },
                  ),
                  ListTile(
                    title: Text("Quadra Esportiva"),
                    onTap: () {
                      //action on press
                    },
                  ),
                  ListTile(
                    title: Text("Mapa"),
                    onTap: () {
                      //action on press
                    },
                  ),
                  //more child menu
                ],
              ),
              Divider(),
            ListTile(
              title: Text('Sair'),
              onTap: () {
                Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Introducao()),);
              }
            ),
            ],
          )),
        ),
        body: null);
  }
}
