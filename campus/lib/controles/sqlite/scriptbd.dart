const criarAviso = '''
 CREATE TABLE aviso(
    id INTEGER NOT NULL PRIMARY KEY
    ,titulo VARCHAR(200) NOT NULL
    ,corpo CHAR(16) NOT NULL
    ,adicional VARCHAR(150)
  )
''';
//array de inserções
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
