CREATE TABLE empregado (
    nome VARCHAR2(50 CHAR) NOT NULL,
    rg NUMBER(8) NOT NULL PRIMARY KEY,
    cic NUMBER(8) NOT NULL,
    depto INTEGER NOT NULL,
    rg_supervisor NUMBER(8),
    salario NUMBER(7, 2)
);

CREATE TABLE departamento (
    nome VARCHAR2(30 CHAR) NOT NULL,
    numero INTEGER NOT NULL PRIMARY KEY,
    rg_gerente NUMBER(8)
);

CREATE TABLE projeto (
    nome VARCHAR2(30 CHAR) NOT NULL,
    numero INTEGER NOT NULL PRIMARY KEY,
    localizacao VARCHAR2(20 CHAR) NOT NULL
);

CREATE TABLE dependentes (
    rg_responsavel NUMBER(8) NOT NULL,
    nome_dependente VARCHAR2(30 CHAR) NOT NULL,
    nascimento DATE NOT NULL,
    sexo VARCHAR2(10 CHAR),
    PRIMARY KEY (rg_responsavel, nome_dependente)
);

CREATE TABLE departamento_projeto (
    numero_depto INTEGER NOT NULL,
    numero_projeto INTEGER NOT NULL,
    PRIMARY KEY (numero_depto, numero_projeto)
);

CREATE TABLE empregado_projeto (
    rg_empregado NUMBER(8) NOT NULL,
    numero_projeto INTEGER NOT NULL,
    horas INTEGER,
    PRIMARY KEY (rg_empregado, numero_projeto)
);

ALTER TABLE empregado
ADD CONSTRAINT FK_EMPREGADO_DEPARTAMENTO FOREIGN KEY (depto)
REFERENCES departamento(numero);

ALTER TABLE empregado
ADD CONSTRAINT FK_EMPREGADO_SUPERVISOR FOREIGN KEY (rg_supervisor)
REFERENCES empregado(rg);

ALTER TABLE dependentes
ADD CONSTRAINT FK_DEPENDENTES_RESPONSAVEL FOREIGN KEY (rg_responsavel)
REFERENCES empregado(rg);

ALTER TABLE departamento
ADD CONSTRAINT FK_DEPARTAMENTO_GERENTE FOREIGN KEY (rg_gerente)
REFERENCES empregado(rg);

ALTER TABLE departamento_projeto
ADD CONSTRAINT FK_DEPARTAMENTO_PROJETO_DEPARTAMENTO FOREIGN KEY (numero_depto)
REFERENCES departamento(numero);

ALTER TABLE departamento_projeto
ADD CONSTRAINT FK_DEPARTAMENTO_PROJETO_PROJETO FOREIGN KEY (numero_projeto)
REFERENCES projeto(numero);

ALTER TABLE empregado_projeto
ADD CONSTRAINT FK_EMPREGADO_PROJETO_EMPREGADO FOREIGN KEY (rg_empregado)
REFERENCES empregado(rg);

ALTER TABLE empregado_projeto
ADD CONSTRAINT FK_EMPREGADO_PROJETO_PROJETO FOREIGN KEY (numero_projeto)
REFERENCES projeto(numero);
