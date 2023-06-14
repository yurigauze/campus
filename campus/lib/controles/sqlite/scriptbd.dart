const criarTabelas = [
  '''
CREATE TABLE turno(
  id INTEGER NOT NULL PRIMARY KEY
  ,nome VARCHAR(200) NOT NULL
  ,descricao VARCHAR(16)
)''',
  '''CREATE TABLE turma(
  id INTEGER NOT NULL PRIMARY KEY
  ,nome VARCHAR(200) NOT NULL
  ,turno_id INTEGER NOT NULL
  ,FOREIGN KEY (turno_id) REFERENCES turno (id)
)''',
  '''
 CREATE TABLE aviso(
    id INTEGER NOT NULL PRIMARY KEY
    ,titulo VARCHAR(200) NOT NULL
    ,corpo CHAR(16) NOT NULL
    ,adicional VARCHAR(150)
  )
'''
];

//array de inserções turno
const insercoes = [
  '''
INSERT INTO turno (nome)
VALUES ('Matutino')
''',
  '''
INSERT INTO turno (nome)
VALUES ('Vespertino')
''',
  '''
INSERT INTO turno (nome)
VALUES ('Integral')
''',
  '''
INSERT INTO turno (nome)
VALUES ('Noturno')
''',
  '''
INSERT INTO turma (nome, turno_id)
VALUES ('1º Engenharia de S.',1)
''',
  '''
INSERT INTO turma (nome, turno_id)
VALUES ('2º Engenharia de S.',1)
''',
  '''
INSERT INTO turma (nome, turno_id)
VALUES ('3º Engenharia de S.',2)
''',
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
