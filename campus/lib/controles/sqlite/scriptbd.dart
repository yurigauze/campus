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
  '''CREATE TABLE aluno(
  id INTEGER NOT NULL PRIMARY KEY
  ,nome VARCHAR(200) NOT NULL
  ,cpf CHAR(12) NOT NULL
  ,email VARCHAR(200) NOT NULL
  ,password VARCHAR(200) NOT NULL
  ,telefone VARCHAR(13) NOT NULL
  ,turma_id INTEGER NOT NULL
  ,FOREIGN KEY (turma_id) REFERENCES turma (id)
)''',
  '''
 CREATE TABLE aviso(
    id INTEGER NOT NULL PRIMARY KEY
    ,titulo VARCHAR(200) NOT NULL
    ,corpo CHAR(16) NOT NULL
    ,turma_id INTEGER
    ,turno_id INTEGER
    ,aluno_id INTEGER

  )
''',
  '''
  CREATE TABLE avisosreferencias(
    aviso_id INTEGER NOT NULL
    ,turma_id INTEGER
    ,turno_id INTEGER
    ,aluno_id INTEGER
    ,FOREIGN KEY (aviso_id) REFERENCES aviso (id)
    ,FOREIGN KEY (turma_id) REFERENCES turma (id)
    ,FOREIGN KEY (turno_id) REFERENCES turno (id)
    ,FOREIGN KEY (aluno_id) REFERENCES aluno (id)
  )
''',
  '''
  CREATE TABLE professor(
   id INTEGER NOT NULL PRIMARY KEY
  ,nome VARCHAR(200) NOT NULL
  ,cpf CHAR(12) NOT NULL
  ,email VARCHAR(200) NOT NULL
  ,password VARCHAR(200) NOT NULL
  ,telefone VARCHAR(13) NOT NULL
  ,turma_id INTEGER NOT NULL
  ,FOREIGN KEY (turma_id) REFERENCES turma (id)
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
INSERT INTO aluno (nome, cpf, email, password, telefone, turma_id)
VALUES ('Yuri Gauze', '00858990032', 'yuri@gmail.com', '12345678', '4499999999', '1')
''',
  '''
INSERT INTO aluno (nome, cpf, email, password, telefone, turma_id)
VALUES ('Pedro Antonio', '19825896043', 'pedro@gmail.com', '12345658', '4499999999', '1')
''',
  '''
INSERT INTO aluno (nome, cpf, email, password, telefone, turma_id)
VALUES ('Ingrid Gauze', '84185822006', 'ingrid@gmail.com', '12345678', '4499999999', '1')
''',
  '''
INSERT INTO professor (nome, cpf, email, password, telefone, turma_id)
VALUES ('Fabricio Almeida', '36707115030', 'email@gmail.com', '12345678', '4499999999', '1')
''',
  ''' 
INSERT INTO professor (nome, cpf, email, password, telefone, turma_id)
VALUES ('Fabricio Almeida', '111', 'email@gmail.com', '111', '4499999999', '1')
''',
  '''
INSERT INTO professor (nome, cpf, email, password, telefone, turma_id)
VALUES ('Amanda Ferreira', '98363327077', 'Amanda@gmail.com', '12345678', '4499999999', '1')
''',
  '''
INSERT INTO professor (nome, cpf, email, password, telefone, turma_id)
VALUES ('Caio Batista', '17716210017', 'Caio@gmail.com', '12345678', '4499999999', '1')
''',
  '''
INSERT INTO aviso (titulo, corpo)
VALUES ('Aviso 1','Corpo Aviso 1')
''',
  '''
INSERT INTO aviso (titulo, corpo)
VALUES ('Aviso 2','Corpo Aviso 2')
''',
  '''
INSERT INTO aviso (titulo, corpo)
VALUES ('Aviso 3','Corpo aviso 3')
''',
  '''
INSERT INTO avisosreferencias (aviso_id,aluno_id)
VALUES (1,1)
''',
  '''
INSERT INTO avisosreferencias (aviso_id,turma_id)
VALUES (2,1)
''',
  '''
INSERT INTO avisosreferencias (aviso_id,turno_id)
VALUES (3,1)
'''
];
