import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/turno_dao_inerface.dart';
import 'package:campus/src/controles/sqlite/conexao.dart';
import 'package:sqflite/sqflite.dart';

class TurnoDAOSQLite implements TurnoDao {
  Turno converterTurno(Map<dynamic, dynamic> resultado) {
    return Turno(
        id: resultado['id'],
        nome: resultado['nome'],
        descricao: resultado['descricao']);
  }

  @override
  Future<Turno> consultar(int id) async {
    Database db = await Conexao.criar();
    List<Map> maps = await db.query('turno', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty)
      throw Exception('Não foi encontrado registros com esse id');
    Map<dynamic, dynamic> resultado = maps.first;
    return converterTurno(resultado);
  }

  @override
  Future<List<Turno>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Turno> lista =
        (await db.query('turno')).map<Turno>(converterTurno).toList();
    return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM turno WHERE id = ?';
    int linhasAfetas = await db.rawDelete(sql, [id]);
    return linhasAfetas >= 0;
  }

  @override
  Future<Turno> salvar(Turno turno) async {
    Database db = await Conexao.criar();
    String sql;
    if (turno.id == null) {
      sql = "INSERT INTO turma (nome, descricao) VALUES (?,?)";
      int id = await db.rawInsert(sql, [turno.nome, turno.descricao]);
      turno = Turno(id: id, nome: turno.nome, descricao: turno.descricao);
    } else {
      sql = 'UPDATE turma SET nome = ?, descricao =? WHERE id = ?';
      db.rawUpdate(sql, [turno.nome, turno.descricao, turno.id]);
    }
    return turno;
  }
}
