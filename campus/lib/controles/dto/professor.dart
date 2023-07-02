import 'package:campus/controles/dto/turma.dart';

class Professor {
  final dynamic id;
  final String nome;
  final String cpf;
  final String email;
  final String password;
  final String telefone;
  final Turma turma;

  Professor({
    this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.password,
    required this.telefone,
    required this.turma,
  });

  @override
  String toString() {
    return '''
      $id
      $nome
      $cpf
      $email
      $password
      $telefone 
      $turma
    ''';
  }
}
