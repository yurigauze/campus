import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main(List<String> args) async {
  runApp(App());

  await Firebase.initializeApp();

  var collection = FirebaseFirestore.instance.collection('turno');
  print(collection);
}


///venda produto item_venda

///select * from item_venda;
///select * from produto where id = ?;
///select * from venda where id = ?;

///select * from venda, produto, item_venda 
///where 
