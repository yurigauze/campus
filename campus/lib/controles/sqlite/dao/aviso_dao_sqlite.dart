import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:campus/controles/sqlite/conexao.dart';
import 'package:sqflite/sqflite.dart';

class AvisoDAOSQLite implements AvisoDao {
  Aviso converterAviso(Map<dynamic, dynamic> resultado) {
    return Aviso(
        id: resultado['id'],
        titulo: resultado['titulo'],
        corpo: resultado['corpo'],
        adicional: resultado['resultado']);
  }

  @override
  Future<Aviso> consultar(int id) async {
    Database db = await Conexao.criar();
    List<Map> maps = await db.query('aviso', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty)
      throw Exception('Não foi encontrado registros com esse id');
    Map<dynamic, dynamic> resultado = maps.first;
    return converterAviso(resultado);
  }

  @override
  Future<List<Aviso>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Aviso> lista =
        (await db.query('aviso')).map<Aviso>(converterAviso).toList();
    return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM aviso WHERE id = ?';
    int linhasAfetas = await db.rawDelete(sql, [id]);
    return linhasAfetas >= 0;
  }

  @override
  Future<Aviso> salvar(Aviso avisos) async {
    Database db = await Conexao.criar();
    String sql;
    if (avisos.id == null) {
      sql = "INSERT INTO aviso (titulo, corpo, adicional) VALUES (?,?,?)";
      int id = await db
          .rawInsert(sql, [avisos.titulo, avisos.corpo, avisos.adicional]);
      avisos = Aviso(
          id: id,
          titulo: avisos.titulo,
          corpo: avisos.corpo,
          adicional: avisos.adicional);
    } else {
      sql = 'UPDATE aviso SET titulo = ?, corpo =?, adicional = ? WHERE id = ?';
      db.rawUpdate(
          sql, [avisos.titulo, avisos.corpo, avisos.adicional, avisos.id]);
    }
    return avisos;
  }
}
