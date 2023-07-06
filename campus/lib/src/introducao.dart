import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Introducao extends StatelessWidget {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void realizarLogin(String cpf, String senha, BuildContext context) async {
    String a = cpf;
    String b = senha;

    if (a == '1' && b == '1') {
      abrirAdm(context);
    }
  }

  void abrirTelaAluno(BuildContext context) {
    print('Abrir tela do aluno');
    Navigator.pushNamed(context, 'homeAluno');
  }

  void abrirTelaProfessor(BuildContext context) {
    print('Abrir tela do professor');
    Navigator.pushNamed(context, 'homeProfessor');
  }

  void abrirAdm(BuildContext context) {
    print('Abrir tela do ADM');
    Navigator.pushNamed(context, 'administrador');
  }

  void exibirMensagemErro(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('CPF ou senha inválidos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boas Vindas"),
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
                  Image.asset('assets/ifpr-logo.png', width: 500),
                  // Adicione a imagem como filho do Column
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller:
                    _cpfController, // Atribuindo o controller criado à propriedade controller
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
                onPressed: () async {
                  var usuario = _cpfController.text;
                  var senha = _passwordController.text;
                  realizarLogin(usuario, senha, context);
                },
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
