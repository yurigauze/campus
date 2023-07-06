
import 'package:campus/src/controles/daofake/aviso_fake.dart';
import 'package:campus/src/controles/dto/aluno.dart';
import 'package:campus/src/controles/dto/aviso.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';

import 'package:campus/src/controles/interface/aviso_dao_interface.dart';
import 'package:campus/src/controles/sqlite/conexao.dart';
import 'package:campus/src/controles/sqlite/dao/aluno_dao_sqlite.dart';
import 'package:campus/src/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:campus/src/controles/sqlite/dao/turno_dao_sqlite.dart';
import 'package:sqflite/sqflite.dart';

class AvisoDAOSQLite implements AvisoDao {
  Future<Aviso> converter(Map<dynamic, dynamic> resultado) async {

    String? texto;

    Turma? turma;
    if (resultado['turma_id'] != null) {
      turma = await TurmaDAOSQLite().consultar(resultado['turma_id']);
      texto = turma.nome;
    }

    Turno? turno;
    if (resultado['turno_id'] != null) {
      turno = await TurnoDAOSQLite().consultar(resultado['turno_id']);
      texto = turno.nome;
    }

    Aluno? aluno;
    if (resultado['aluno_id'] != null) {
      aluno = await AlunoDAOSQLite().consultar(resultado['aluno_id']);
      texto = aluno.nome;

    }
     return Aviso(
      id: resultado['id'],
      titulo: resultado['titulo'],
      corpo: resultado['corpo'],
      informacao: texto,
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
    List<Map<dynamic, dynamic>> resultadpBD = await db.rawQuery('''SELECT a.*, t.id AS turma_id, al.id AS aluno_id, tn.id AS turno_id
          FROM aviso a
          LEFT JOIN avisosreferencias ar ON a.id = ar.aviso_id
          LEFT JOIN turma t ON ar.turma_id = t.id
          LEFT JOIN aluno al ON ar.aluno_id = al.id
          LEFT JOIN turno tn ON ar.turno_id = tn.id

          ''');
          List<Aviso> lista = [];
          print(resultadpBD);
          for (var registro in resultadpBD){
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
  Future<Aviso> salvarAvisoTurma(Aviso aviso, int idTurma) async {
    Database db = await Conexao.criar();
    String sql;
    if (aviso.id == null) {
      sql = "INSERT INTO aviso (titulo, corpo) VALUES (?, ?)";
      int idAviso = await db.rawInsert(sql, [aviso.titulo, aviso.corpo]);

      sql = "INSERT INTO avisosreferencias (aviso_id, turma_id) VALUES (?, ?)";
      await db.rawInsert(sql, [idAviso, idTurma]);

      aviso = Aviso(
        id: idAviso,
        titulo: aviso.titulo,
        corpo: aviso.corpo,
      );
    }
    return aviso;
  }

  @override
  Future<Aviso> salvarAvisoTurno(Aviso aviso, int idTurno) async {
    Database db = await Conexao.criar();
    String sql;
    if (aviso.id == null) {
      sql = "INSERT INTO aviso (titulo, corpo) VALUES (?, ?)";
      int idAviso = await db.rawInsert(sql, [aviso.titulo, aviso.corpo]);

      sql = "INSERT INTO avisosreferencias (aviso_id, turno_id) VALUES (?, ?)";
      await db.rawInsert(sql, [idAviso, idTurno]);

      aviso = Aviso(
        id: idAviso,
        titulo: aviso.titulo,
        corpo: aviso.corpo,
      );
    }
    return aviso;
  }

    @override
    Future<Aviso> salvarAvisoAluno(Aviso aviso, int idAluno) async {
    Database db = await Conexao.criar();
    String sql;
    if (aviso.id == null) {
      sql = "INSERT INTO aviso (titulo, corpo) VALUES (?, ?)";
      int idAviso = await db.rawInsert(sql, [aviso.titulo, aviso.corpo]);

      sql = "INSERT INTO avisosreferencias (aviso_id, aluno_id) VALUES (?, ?)";
      await db.rawInsert(sql, [idAviso, idAluno]);

      aviso = Aviso(
        id: idAviso,
        titulo: aviso.titulo,
        corpo: aviso.corpo,
      );
    }
    return aviso;
  }




  @override
  Future<Aviso> salvar(Aviso avisos) async {
    Database db = await Conexao.criar();
    String sql;
    if (avisos.id == null) {
      sql =
          "INSERT INTO aviso (titulo, corpo) VALUES (?,?)";
      int id = await db.rawInsert(sql, [
        avisos.titulo,
        avisos.corpo,
      ]);

      avisos = Aviso(
        id: id,
        titulo: avisos.titulo,
        corpo: avisos.corpo,
      
      );
    } else {
      sql =
          'UPDATE aviso SET titulo = ?, corpo =?, turno = ?, aluno = ?, turma = ? WHERE id = ?';
      db.rawUpdate(sql, [
        avisos.titulo,
        avisos.corpo,
        avisos.id
      ]);
    }
    return avisos;
  }
}
