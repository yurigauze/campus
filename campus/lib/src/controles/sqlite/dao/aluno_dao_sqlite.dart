import 'package:campus/src/controles/dto/aluno.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/interface/aluno_dao_interface.dart';
import 'package:campus/src/controles/sqlite/conexao.dart';
import 'package:campus/src/controles/sqlite/dao/turma_dao_sqlite.dart';
import 'package:sqflite/sqflite.dart';

class AlunoDAOSQLite implements AlunoDao {

  Future<Aluno> converter(Map<dynamic, dynamic> resultado) async{
    Turma turma = await TurmaDAOSQLite().consultar(resultado['turma_id']);
    return Aluno(id: resultado['id'], nome: resultado['nome'], cpf: resultado['cpf'], email: resultado['email'], password: resultado['password'], telefone: resultado['telefone'] ,turma: turma, );
  }

  @override
  Future<Aluno> consultar(int id) async {
    Database db = await Conexao.criar();
    Map resultado = (await db.query('aluno', where: 'id = ?', whereArgs: [id])).first;
    if (resultado.isEmpty)
    throw Exception('Não foi encontrado resgistros com esse id');
    return converter(resultado);
  }

  @override
  Future<List<Aluno>> consultarTodos() async{
    Database db = await Conexao.criar();
    List<Map<dynamic, dynamic>> resultadpBD = await db.query('aluno');
    List<Aluno> lista = [];
    for (var registro in resultadpBD) {
      var aluno = await converter(registro);
      lista.add(aluno);
    }
    return lista;
      }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM aluno WHERE id = ?';
    int linhasAfetas = await db.rawDelete(sql, [id]);
    return linhasAfetas >= 0;
  }

  @override
  Future<Aluno> salvar(Aluno alunos) async {
    Database db = await Conexao.criar();
    String sql;
    if (alunos.id == null) {
      sql = "INSERT INTO aluno (nome, cpf, email, password, telefone, turma) VALUES (?,?,?,?,?,?)";
      int id = await db
          .rawInsert(sql, [alunos.nome, alunos.cpf, alunos.email, alunos.password, alunos.telefone, alunos.turma]);
      alunos = Aluno(
          id: id,
          nome: alunos.nome,
          cpf: alunos.cpf,
          email: alunos.email,
          password: alunos.password,
          telefone: alunos.telefone,
          turma: alunos.turma
        );    } else {
      sql = 'UPDATE aluno SET nome = ?, cpf =?, email = ?, password = ?, telefone = ?, turma = ? WHERE id = ?';
      db.rawUpdate(
          sql, [
        alunos.nome,
        alunos.cpf,
        alunos.email,
        alunos.password,
        alunos.telefone,
        alunos.turma
      ]);
    }
    return alunos;
  }
}
