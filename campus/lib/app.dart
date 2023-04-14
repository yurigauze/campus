import 'package:campus/Avisos.dart';
import 'package:campus/cursos/cursoSuperior.dart';
import 'package:campus/cursos/tecnicoIntegrado.dart';
import 'package:campus/infraestrutura/administracao.dart';
import 'package:campus/infraestrutura/biblioteca.dart';
import 'package:campus/infraestrutura/laboratorios.dart';
import 'package:flutter/material.dart';

import 'cursos/posGraduacao.dart';
import 'cursos/tecnicoSubsequente.dart';
import 'homeAluno.dart';
import 'homeProfessor.dart';
import 'introducao.dart';


class App extends StatelessWidget {
  App({super.key});

  var pessoa = {"nome": "helio", "idade": 20, "funcao": () {}};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => Introducao(),
        'homeAluno':( context) => HomeAluno(),
        'homeProfessor':( context) => HomeProfessor(),
        'avisos':(context) => Avisos(),
        'cursoSuperior':(context) => CursoSuperior(),
        'posGraduacao': (context) => PosGraduacao(),
        'tecnicoIntegrado':(context)=>TecnicoIntegrado(),
        'tecnicoSubsequente':(context)=> TecnicoSubsequente(),
        'laboratorio':(context) => laboratorios(),
        'biblioteca':(context) => Biblioteca(),
        'Administracao':(context) => Administracao(),
        
      },
    );
  }
}
