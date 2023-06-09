import 'package:campus/controles/sqlite/scriptbd.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class Conexao {
  static late Database _database;
  static bool _fechado = true;

  static Future<Database> criar() async {
    //como estamos utilizando o await dentro da função, precisamos tornar a função assíncrona, colocando async
    if (_fechado) {
      String path = join(await getDatabasesPath(), 'banco.db');
      deleteDatabase(
          path); // precisamos "esperar" (await) o resultado para seguir a execução
      _database = await openDatabase(
        //chamando o método que que abre o database
        path, // informando o caminho
        version: 1, // versão
        onCreate: (db, v) {
          // criando os elementos (tabelas e registros) do BD
          criarTabelas.forEach(db.execute);
          insercoes.forEach(db.execute);
        },
      );
      _fechado = false;
    }
    return _database;
  }
}
