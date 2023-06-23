import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class Contatos extends StatelessWidget {

void abrirWhatsApp(numero) async {
    var whatsappUrl = 'https://wa.me/55$numero';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      Fluttertoast.showToast(
        msg: 'Aplicativo não instalado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(161, 6, 6, 6),
        textColor: Colors.white,
      );
    }
  }

  void abrirUrl() async {
    var url = 'https://ifpr.edu.br/paranavai/fale-conosco/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
        Fluttertoast.showToast(
        msg: 'Aplicativo não instalado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(161, 6, 6, 6),
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
      ),
      body: Center(
        child: Container(
          width: 390,
          margin: const EdgeInsets.only(top: 16),
          child: 
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Secretaria Academica',
              style: TextStyle(fontSize: 18)),
              ListTile(
                leading: const Icon(Icons.phone_outlined, color: Colors.black, size: 25,),
                title: const Text('44 3482-0111',
                style: TextStyle(fontSize: 15)),
                onTap: () {
                  launchUrl(Uri(
                      scheme: 'tel',
                      path: '04434820111'
                      )); //<<<<<<<<<<<<<<<<<<<<<<<<<<<
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.email_outlined, color: Colors.black),
                title: const Text('secretaria.paranavai@ifpr.edu.br'),
                onTap: () {
                  launchUrl(Uri(
                      scheme: 'mailto',
                      path: 'secretaria.paranavai@ifpr.edu.br')); // <<<<<<<<<<<<<<<<<<<<<<<<<<<
                },
              ),
              const Divider(),
                ListTile(
                leading: const Icon(Icons.phone_outlined, color: Colors.black),
                title: const Text('44 3482-0121'),
                onTap: () {
                  launchUrl(Uri(
                      scheme: 'tel',
                      path: '044334820121')); //<<<<<<<<<<<<<<<<<<<<<<<<<<<
                },
              ),
              const Divider(),
                  ListTile(
                leading: const Icon(FlutterIcons.whatsapp_mco, color: Colors.black),
                title: const Text('Whatsapp'),
                onTap: (){
                 abrirWhatsApp('04434820121');
                }
              ),
              const Text('Outros numeros:', style: TextStyle(fontSize: 15)), 
              ListTile(
                  leading: const Icon(Icons.info_outline  , color: Colors.black),
                  title: const Text('Fale Conosco'),
                  onTap: () {
                  abrirUrl(); //<<<<<<<<<<<<<<<<<<<<<<<<<<<
                },
              ),
              

            ],
          ),
        ),
      ),
    );
  }
}
