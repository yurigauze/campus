import 'package:campus/src/Adm/AlunoForm.dart';
import 'package:campus/src/Adm/AlunoLista.dart';
import 'package:campus/src/Adm/ProfessorForm.dart';
import 'package:campus/src/Adm/ProfessorLista.dart';
import 'package:campus/src/Adm/TurmaForm.dart';
import 'package:campus/src/Adm/homeAdministra%C3%A7%C3%A3o.dart';
import 'package:campus/src/Adm/TurmaLista.dart';
import 'package:campus/src/Avisos.dart';
import 'package:campus/src/contatos.dart';
import 'package:campus/src/cursos/cursoSuperior.dart';
import 'package:campus/src/cursos/tecnicoIntegrado.dart';
import 'package:campus/src/infraestrutura/administracao.dart';
import 'package:campus/src/infraestrutura/biblioteca.dart';
import 'package:campus/src/infraestrutura/laboratorios.dart';
import 'package:campus/src/professor/adicionarTurma.dart';
import 'package:campus/src/professor/avisosProfessor.dart';
import 'package:campus/src/professor/disparos/dispararAlunos.dart';
import 'package:campus/src/professor/disparos/dispararTurma.dart';
import 'package:campus/src/professor/disparos/dispararTurnos.dart';
import 'package:campus/src/professor/disparos/disparosTodos.dart';
import 'package:campus/src/Adm/TurnoLista.dart';
import 'package:flutter/material.dart';

import 'src/cursos/posGraduacao.dart';
import 'src/cursos/tecnicoSubsequente.dart';
import 'src/homeAluno.dart';
import 'src/professor/homeProfessor.dart';
import 'src/introducao.dart';

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
        'homeAluno': (context) => HomeAluno(),
        'homeProfessor': (context) => HomeProfessor(),
        'avisos': (context) => Avisos(),
        'cursoSuperior': (context) => CursoSuperior(),
        'posGraduacao': (context) => PosGraduacao(),
        'tecnicoIntegrado': (context) => TecnicoIntegrado(),
        'tecnicoSubsequente': (context) => TecnicoSubsequente(),
        'laboratorio': (context) => laboratorios(),
        'biblioteca': (context) => Biblioteca(),
        'Administracao': (context) => Administracao(),
        'avisosProfessor2': (context) => AvisoLista(),
        'disparoTodosProfessor': (context) => DispararTodosProfessor(),
        'disparoAlunosProfessor': (context) => DispararAlunosProfessor(),
        'disparoTurmaProfessor': (context) => DispararTurmaProfessor(),
        'disparoTurnoProfessor': (context) => DispararTurnosProfessor(),
        'turmaProfessor': (context) => TurnoLista(),
        'adicionarTurnos': (context) => AdicionarTurma(),
        'contatos': (context) => Contatos(),
        'administrador': (context) => HomeAdministracao(),
        'turmaForm': (context) => DetalhesTurmaScreen(),
        'turmas': (context) => TurmasLista(),
        'alunoLista': (context) => AlunoLista(),
        'alunoForm': (context) => AlunoForm(),
        'professorForm': (context) => ProfessorForm(),
      },
    );
  }
}
