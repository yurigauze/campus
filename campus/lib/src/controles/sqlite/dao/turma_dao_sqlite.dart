import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';
import 'package:campus/src/controles/interface/turma_dao_interface.dart';
import 'package:campus/src/controles/sqlite/conexao.dart';
import 'package:campus/src/controles/sqlite/dao/turno_dao_sqlite.dart';
import 'package:sqflite/sqflite.dart';

class TurmaDAOSQLite implements TurmaDao {
  Future<Turma> converter(Map<dynamic, dynamic> resultado) async {
    Turno turno = await TurnoDAOSQLite().consultar(resultado['turno_id']);
    return Turma(id: resultado['id'], nome: resultado['nome'], turno: turno);
  }

  Turma converterTurma(Map<dynamic, dynamic> resultado) {
    return Turma(
        id: resultado['id'],
        nome: resultado['nome'],
        turno: resultado['turno']);
  }

  @override
  Future<Turma> consultar(int id) async {
    Database db = await Conexao.criar();
    Map resultado =
        (await db.query('turma', where: 'id = ?', whereArgs: [id])).first;
    if (resultado.isEmpty)
      throw Exception('Não foi encontrado registros com esse id');
    return converter(resultado);
  }

  @override
  Future<List<Turma>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Map<dynamic, dynamic>> resultadoBD = await db.query('turma');
    List<Turma> lista = [];
    for (var registro in resultadoBD) {
      var turma = await converter(registro);
      lista.add(turma);
    }
    return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM turma WHERE id = ?';
    int linhasAfetas = await db.rawDelete(sql, [id]);
    return linhasAfetas >= 0;
  }

  @override
  Future<Turma> salvar(Turma turma) async {
    Database db = await Conexao.criar();
    String sql;
    if (turma.id == null) {
      sql = "INSERT INTO turma (nome, turno_id) VALUES (?,?)";
      int id = await db.rawInsert(sql, [turma.nome, turma.turno.id]);
      turma = Turma(id: id, nome: turma.nome, turno: turma.turno);
    } else {
      sql = 'UPDATE turma SET nome = ?, turno_id =? WHERE id = ?';
      db.rawUpdate(sql, [turma.nome, turma.turno.id, turma.id]);
    }
    return turma;
  }
}
