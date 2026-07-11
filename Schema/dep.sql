

CREATE TABLE universidade.dim_professor (
    id_professor SERIAL PRIMARY KEY,
    nome varchar(250),
    tipo_jornada varchar(250),
    formacao varchar(255),
    departamento_lotacao varchar(255)
);

--id 0
INSERT INTO universidade.dim_professor (id_professor, nome) 
VALUES (0, 'Professor não definido');

CREATE TABLE universidade.dim_departamento (	
    departamento_id SERIAL PRIMARY KEY,
    codigo varchar(50), 
    nome varchar(255)
);

INSERT INTO universidade.dim_semestre (semestre_id, ano, periodo) 
VALUES (0, 0, 0);

CREATE TABLE universidade.dim_semestre (
    semestre_id SERIAL PRIMARY KEY,
    ano int,
    periodo int 
);

CREATE TABLE universidade.dim_disciplina (
    disciplina_id SERIAL PRIMARY KEY, 
    codigo varchar(100),
    nome varchar(250),
    departamento_responsavel varchar(250),
    cr_total int
);

CREATE TABLE universidade.compl_turma (
    turma_id SERIAL PRIMARY KEY,
    
    -- conexões (
    id_professor int references universidade.dim_professor(id_professor),
    departamento_id int references universidade.dim_departamento(departamento_id),
    semestre_id int references universidade.dim_semestre(semestre_id),
    disciplina_id int references universidade.dim_disciplina(disciplina_id), 
    
    -- métricas
    discentes_matrc int,
    media_notas float,
    aprovados int,
    reprovados int
); 

-- usuário
CREATE USER usuario_etl WITH PASSWORD 'senha_etl_123';

-- conexões
GRANT CONNECT ON DATABASE "postgres" TO usuario_etl;

GRANT USAGE ON SCHEMA universidade TO usuario_etl; 

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA universidade TO usuario_etl;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA universidade TO usuario_etl;
ALTER DEFAULT PRIVILEGES IN SCHEMA universidade GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO usuario_etl;
ALTER DEFAULT PRIVILEGES IN SCHEMA universidade GRANT USAGE, SELECT ON SEQUENCES TO usuario_etl;
