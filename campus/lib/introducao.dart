import 'package:flutter/material.dart';
import 'package:campus/app.dart';

class Introducao extends StatelessWidget {

  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (title: const Text("Boas Vindas"),
      automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image.network('https://certificados.paranavai.ifpr.edu.br/resources/img/paranavai-vertical.png'), // Adicione a imagem como filho do Column
                ],
              ),
            ),
            SizedBox(height: 20),
                     Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _cpfController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CPF',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'homeAluno');
              },
              child: Text('Login como Aluno'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'homeProfessor');
              },
              child: Text('Login como Servidor'),
            ),
          ),
        ],
      ),

      ),
    );
  }
}
