import 'dart:html';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DispararTodosProfessor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Avisos para Todos"),
        ),
        body: Center(child:  
        
        Container
        (width: 400,
        margin: EdgeInsets.only(top: 16),
        child: Column(
          
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: 'Titulo do Aviso',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 18),
              maxLength: 50,
            ),
            Card(
                color: const Color.fromARGB(255, 235, 235, 235),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 8, //or null
                    maxLength: 500,
                    decoration:
                        InputDecoration.collapsed(hintText: "Qual o aviso?"),
                  ),
                )),
          ],
        ),
        ),
        
        ),

        );
  }
}
