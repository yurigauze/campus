import 'package:campus/src/controles/dto/aluno.dart';
import 'package:campus/src/controles/dto/turma.dart';
import 'package:campus/src/controles/dto/turno.dart';

class Aviso {
  final dynamic id;
  final String titulo;
  final String corpo;
  final String? informacao;

  Aviso({
    this.id,
    required this.titulo,
    required this.corpo,
    this.informacao,
  });

  @override
  String toString() {
    return '''
      $id
      $titulo 
      $corpo
      $informacao
    ''';
  }
}
