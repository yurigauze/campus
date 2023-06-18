import 'package:campus/controles/dto/aluno.dart';
import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/dto/turno.dart';
import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:campus/controles/sqlite/conexao.dart';
import 'package:campus/controles/sqlite/dao/aluno_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turno_dao_sqlite.dart';
import 'package:sqflite/sqflite.dart';

class AvisoDAOSQLite implements AvisoDao {
  Future<Aviso> converter(Map<dynamic, dynamic> resultado) async {
    Turma? turma;
    if (resultado['turma_id'] != null) {
      turma = await TurmaDAOSQLite().consultar(resultado['turma_id']);
    }

    Turno? turno;
    if (resultado['turno_id'] != null) {
      turno = await TurnoDAOSQLite().consultar(resultado['turno_id']);
    }

    Aluno? aluno;
    if (resultado['aluno_id'] != null) {
      aluno = await AlunoDAOSQLite().consultar(resultado['aluno_id']);
    }

    return Aviso(
      id: resultado['id'],
      titulo: resultado['titulo'],
      corpo: resultado['corpo'],
      turma: turma,
      aluno: aluno,
      turno: turno,
    );
  }

  @override
  Future<Aviso> consultar(int id) async {
    Database db = await Conexao.criar();
    List<Map> maps = await db.query('aviso', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty)
      throw Exception('Não foi encontrado registros com esse id');
    Map<dynamic, dynamic> resultado = maps.first;
    return converter(resultado);
  }

  @override
  Future<List<Aviso>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Map<dynamic, dynamic>> resultadpBD = await db.query('aviso');
    List<Aviso> lista = [];
    for (var registro in resultadpBD) {
      var aviso = await converter(registro);
      lista.add(aviso);
    }
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
      sql =
          "INSERT INTO aviso (titulo, corpo, turno_id, aluno_id, turma_id) VALUES (?,?,?,?,?)";
      int id = await db.rawInsert(sql, [
        avisos.titulo,
        avisos.corpo,
        avisos.turno?.id,
        avisos.aluno?.id,
        avisos.turma?.id
      ]);

      avisos = Aviso(
        id: id,
        titulo: avisos.titulo,
        corpo: avisos.corpo,
        turno: avisos.turno?.id != null
            ? await TurnoDAOSQLite().consultar(avisos.turno!.id)
            : null,
        aluno: avisos.aluno?.id != null
            ? await AlunoDAOSQLite().consultar(avisos.aluno?.id)
            : null,
        turma: avisos.turma?.id != null
            ? await TurmaDAOSQLite().consultar(avisos.turma?.id)
            : null,
      );
    } else {
      sql =
          'UPDATE aviso SET titulo = ?, corpo =?, turno = ?, aluno = ?, turma = ? WHERE id = ?';
      db.rawUpdate(sql, [
        avisos.titulo,
        avisos.corpo,
        avisos.turno?.id,
        avisos.aluno?.id,
        avisos.turma?.id,
        avisos.id
      ]);
    }
    return avisos;
  }
}
