const criarAviso = '''
 CREATE TABLE aviso(
    id INTEGER NOT NULL PRIMARY KEY
    ,titulo VARCHAR(200) NOT NULL
    ,corpo CHAR(16) NOT NULL
    ,adicional VARCHAR(150)
  )
''';

const insercoesAvisos = [
  '''
INSERT INTO aviso (titulo, corpo)
VALUES ('Aviso 1','Corpo Aviso 1')
''',
  '''
INSERT INTO aviso (titulo, corpo, adicional)
VALUES ('Aviso 2','Corpo Aviso 2', 'Noturno')
''',
  '''
INSERT INTO aviso (titulo, corpo)
VALUES ('Aviso 3','Corpo aviso 3')
'''
];

const criarTurma = '''
CREATE TABLE turma(
  id INTEGER NOT NULL PRIMARY KEY
  , nome VARCHAR(200) NOT NULL
  , turno VARCHAR(16) NOT NULL
)''';

//array de inserções
const insercoesTurma = [
  '''
INSERT INTO turma (nome, turno)
VALUES ('1º Engenharia de S.','Noturno')
''',
  '''
INSERT INTO turma (nome, turno)
VALUES ('2º Engenharia de S.','Noturno')
''',
  '''
INSERT INTO turma (nome, turno)
VALUES ('3º Engenharia de S.','Noturno')
'''
];
