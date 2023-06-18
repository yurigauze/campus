import 'package:campus/controles/dto/aluno.dart';
import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/dto/avisosRelacionamento.dart';
import 'package:campus/controles/dto/turma.dart';
import 'package:campus/controles/dto/turno.dart';
import 'package:campus/controles/interface/avisoRelacionamento_dao_interface.dart';
import 'package:campus/controles/sqlite/conexao.dart';
import 'package:campus/controles/sqlite/dao/aluno_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/aviso_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/turno_dao_sqlite.dart';
import 'package:sqflite/sqflite.dart';

class AvisoRelaDAOSQLite implements AvisoRelacionamentoDao {
  Future<AvisoRelacionamento> converter(Map<dynamic, dynamic> resultado) async {
    Aviso aviso = await AvisoDAOSQLite().consultar((resultado['aviso_id']));
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
    return AvisoRelacionamento(
        aviso: aviso, turma: turma, aluno: aluno, turno: turno);
  }

  @override
  Future<AvisoRelacionamento> consultar(
      Aviso aviso, Turno? turno, Aluno? aluno, Turma? turma) async {
    Database db = await Conexao.criar();
    List<Map> maps = await db.query('avisoRelacionamento',
        where:
            'aviso = ? AND (turno IS NULL OR turno = ?) AND (aluno IS NULL OR aluno = ?) AND (turma IS NULL OR turma = ?)',
        whereArgs: [aviso, turno, aluno, turma]);
    if (maps.isEmpty) throw Exception('Não foi encontrado registros');
    Map<dynamic, dynamic> resultado = maps.first;
    return converter(resultado);
  }

  @override
  Future<List<AvisoRelacionamento>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Map<dynamic, dynamic>> resultadoDB =
        await db.query('avisosreferencias');
    List<AvisoRelacionamento> lista = [];
    for (var registro in resultadoDB) {
      var avisoRel = await converter(registro);
      lista.add(avisoRel);
    }
    return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM avisoreferencias WHERE aviso_id = ?';
    int linhasAfetadas = await db.rawDelete(sql, [id]);
    return linhasAfetadas >= 0;
  }

  @override
  Future<AvisoRelacionamento> salvar(AvisoRelacionamento relacionamento) async {
    Database db = await Conexao.criar();
    String sql;
    if (relacionamento.aviso == null) {
      sql =
          "INSERT INTO avisoreferencias (aviso_id, turno_id, aluno_id, turma_id) VALUES (?,?,?,?)";
      int id = await db.rawInsert(sql, [
        relacionamento.aviso.id,
        relacionamento.turma?.id,
        relacionamento.aluno?.id,
        relacionamento.turma?.id,
      ]);

      relacionamento = AvisoRelacionamento(
        aviso: relacionamento.aviso,
        turno: relacionamento.turno?.id != null
            ? await TurnoDAOSQLite().consultar(relacionamento.turno!.id)
            : null,
        aluno: relacionamento.aluno?.id != null
            ? await AlunoDAOSQLite().consultar(relacionamento.aluno?.id)
            : null,
        turma: relacionamento.turma?.id != null
            ? await TurmaDAOSQLite().consultar(relacionamento.turma?.id)
            : null,
      );
    } else {
      sql =
          'UPDATE avisoreferencias SET aviso_id = ?, turno_id = ?, aluno_id = ?, turma_id = ?';
      db.rawUpdate(sql, [
        relacionamento.aviso.id,
        relacionamento.turma?.id,
        relacionamento.aluno?.id,
        relacionamento.turma?.id,
      ]);
    }
    return relacionamento;
  }
}
