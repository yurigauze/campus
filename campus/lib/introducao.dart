import 'package:flutter/material.dart';
import 'package:campus/app.dart';
import 'package:flutter/services.dart';

class Introducao extends StatelessWidget {

 TextEditingController  _cpfController = TextEditingController();
 TextEditingController _passwordController = TextEditingController();

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
                  Image.network('https://certificados.paranavai.ifpr.edu.br/resources/img/paranavai-vertical.png', width: 500), // Adicione a imagem como filho do Column
                  
                ],
              ),
            ),
            SizedBox(height: 20),
                     Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _cpfController, // Atribuindo o controller criado à propriedade controller
                decoration: InputDecoration(
                  labelText: 'CPF', 
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller:  _passwordController,
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

                var usuario = _cpfController.text;
                var senha = _passwordController.text;
                if (usuario== "111" && senha == "professor") {
                  Navigator.pushNamed(context, 'homeProfessor');
                } else if (usuario == "111" && senha == "aluno") {
                Navigator.pushNamed(context, 'homeAluno');
                } else {
                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Credenciais invalidas"),
                            content: Text("Usuario ou senha informados estão incorretos. $usuario, $senha  ", ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                }
              }, child: const Text("Login"),
            
            ),
          ),
          
        ],
      ),

      ),
    );
  }
}
