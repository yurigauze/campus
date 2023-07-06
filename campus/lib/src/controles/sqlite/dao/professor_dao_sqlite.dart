import 'package:campus/src/controles/dto/professor.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/interface/professor_dao_interface.dart';
import 'package:campus/src/controles/sqlite/conexao.dart';
import 'package:campus/src/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:sqflite/sqlite_api.dart';

class ProfessorDAOSQLite implements ProfessorDao {
  Future<Professor> converter(Map<dynamic, dynamic> resultado) async {
    Turma turma = await TurmaDAOSQLite().consultar(resultado['turma_id']);
    return Professor(
      id: resultado['id'],
      nome: resultado['nome'],
      cpf: resultado['cpf'],
      email: resultado['email'],
      password: resultado['password'],
      telefone: resultado['telefone'],
      turma: turma,
    );
  }

  Professor converterProfessor(Map<dynamic, dynamic> resultado) {
    return Professor(
        id: resultado['id'],
        nome: resultado['nome'],
        cpf: resultado['cpf'],
        email: resultado['email'],
        password: resultado['password'],
        telefone: resultado['telefone'],
        turma: resultado['turma']);
  }

  @override
  Future<Professor> consultar(int id) async {
    Database db = await Conexao.criar();
    Map resultado =
        (await db.query('professor', where: 'id = ?', whereArgs: [id])).first;
    if (resultado.isEmpty)
      throw Exception('Não foi encontrado resgistros com esse id');
    return converter(resultado);
  }

  @override
  Future<List<Professor>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Map<dynamic, dynamic>> resultadpBD = await db.query('professor');
    List<Professor> lista = [];
    for (var registro in resultadpBD) {
      var professor = await converter(registro);
      lista.add(professor);
    }
    return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM professor WHERE id = ?';
    int linhasAfetas = await db.rawDelete(sql, [id]);
    return linhasAfetas >= 0;
  }

  @override
  Future<Professor> salvar(Professor professor) async {
    Database db = await Conexao.criar();
    String sql;
    if (professor.id == null) {
      sql =
          "INSERT INTO professor (nome, cpf, email, password, telefone, turma_id) VALUES (?,?,?,?,?,?)";
      int id = await db.rawInsert(sql, [
        professor.nome,
        professor.cpf,
        professor.email,
        professor.password,
        professor.telefone,
        professor.turma.id,
      ]);
      professor = Professor(
        id: id,
        nome: professor.nome,
        cpf: professor.cpf,
        email: professor.email,
        password: professor.password,
        telefone: professor.telefone,
        turma: professor.turma,
      );
    } else {
      sql =
          'UPDATE professor SET nome = ?, cpf =?, email = ?, password = ?, telefone = ?, turma_id, WHERE id = ?';
      db.rawUpdate(sql, [
        professor.nome,
        professor.cpf,
        professor.email,
        professor.password,
        professor.telefone,
        professor.turma.id
      ]);
    }
    return professor;
  }
}
