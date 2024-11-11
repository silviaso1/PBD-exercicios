
CREATE TABLE conta_comum (
    nro_conta         NUMBER(10) NOT NULL,
    cod_agencia       NUMBER(4) NOT NULL,
    tipo_conta        NUMBER(1) NOT NULL,
    data_abertura     DATE NOT NULL,
    data_encerramento DATE,
    situacao          CHAR(1) NOT NULL,
    senha             INTEGER NOT NULL,
    saldo             NUMBER(11, 2) NOT NULL
);

ALTER TABLE conta_comum
    ADD CONSTRAINT "ck tipo conta" CHECK ( tipo_conta IN ( 1, 2, 3 ) );

ALTER TABLE conta_comum
    ADD CONSTRAINT "ck situacao conta" CHECK ( situacao IN ( '0', '1' ) );

ALTER TABLE conta_comum ADD CONSTRAINT conta_comum_pk PRIMARY KEY ( nro_conta,
                                                                    cod_agencia );

CREATE TABLE conta_especial (
    nro_conta   NUMBER(10) NOT NULL,
    cod_agencia NUMBER(4) NOT NULL,
    limite      NUMBER(11, 2)
);

ALTER TABLE conta_especial ADD CONSTRAINT conta_especial_pk PRIMARY KEY ( nro_conta,
                                                                          cod_agencia );

CREATE TABLE conta_poupanca (
    nro_conta        NUMBER(10) NOT NULL,
    cod_agencia      NUMBER(4) NOT NULL,
    data_aniversario DATE
);

ALTER TABLE conta_poupanca ADD CONSTRAINT conta_poupanca_pk PRIMARY KEY ( nro_conta,
                                                                          cod_agencia );

CREATE TABLE movimento (
    id_movimento            INTEGER NOT NULL,
    tipo_movimento          CHAR(1) NOT NULL,
    data_movimento          DATE NOT NULL,
    hora_movimento          DATE,
    valor_movimentado       NUMBER(11, 2) NOT NULL,
    conta_comum_nro_conta   NUMBER(10) NOT NULL,
    conta_comum_cod_agencia NUMBER(4) NOT NULL
);

ALTER TABLE movimento ADD CONSTRAINT movimento_pk PRIMARY KEY ( id_movimento );

CREATE TABLE pessoa (
    id_pessoa       INTEGER DEFAULT 1 NOT NULL,
    nome            VARCHAR2(80 CHAR) NOT NULL,
    endereco        VARCHAR2(120 CHAR),
    cep             NUMBER(8),
    telefone        NUMBER(8),
    renda_media     NUMBER(11, 2) NOT NULL,
    tipo_pessoa     NUMBER(1) NOT NULL,
    situacao_pessoa NUMBER(1) DEFAULT 1 NOT NULL
);

ALTER TABLE pessoa
    ADD CHECK ( id_pessoa IN ( 1, 2 ) );

ALTER TABLE pessoa
    ADD CONSTRAINT "ck tipo pessoa" CHECK ( tipo_pessoa IN ( 1, 2 ) );

ALTER TABLE pessoa
    ADD CONSTRAINT "ck situacao pessoa" CHECK ( situacao_pessoa IN ( 1, 2 ) );

ALTER TABLE pessoa ADD CONSTRAINT pessoa_pk PRIMARY KEY ( id_pessoa );

CREATE TABLE pessoa_conta (
    pessoa_id_pessoa        INTEGER NOT NULL,
    conta_comum_nro_conta   NUMBER(10) NOT NULL,
    conta_comum_cod_agencia NUMBER(4) NOT NULL,
    titularidade            CHAR(1 BYTE) DEFAULT 'T' NOT NULL
);

ALTER TABLE pessoa_conta
    ADD CONSTRAINT "ck titularidade" CHECK ( titularidade IN ( 'A', 'T' ) );

ALTER TABLE pessoa_conta
    ADD CONSTRAINT pessoa_conta_pk PRIMARY KEY ( pessoa_id_pessoa,
                                                 conta_comum_nro_conta,
                                                 conta_comum_cod_agencia );

CREATE TABLE pessoa_fisica (
    id_pessoa    INTEGER DEFAULT 1 NOT NULL,
    cpf          NUMBER(11) NOT NULL,
    celular      NUMBER(11),
    estado_civil CHAR(1 CHAR) NOT NULL
);

ALTER TABLE pessoa_fisica
    ADD CHECK ( id_pessoa IN ( 1, 2 ) );

ALTER TABLE pessoa_fisica
    ADD CONSTRAINT ck_estado_civil CHECK ( estado_civil IN ( 'c', 'd', 's', 'v', 'x' ) );

ALTER TABLE pessoa_fisica ADD CONSTRAINT pessoa_fisica_pk PRIMARY KEY ( id_pessoa );

ALTER TABLE pessoa_fisica ADD CONSTRAINT pessoa_fisica_pkv1 UNIQUE ( cpf );

CREATE TABLE pessoa_juridica (
    id_pessoa      INTEGER DEFAULT 1 NOT NULL,
    cnpj           NUMBER(14) NOT NULL,
    inscr_estadual NUMBER(12)
);

ALTER TABLE pessoa_juridica
    ADD CHECK ( id_pessoa IN ( 1, 2 ) );

ALTER TABLE pessoa_juridica ADD CONSTRAINT pessoa_juridica_pk PRIMARY KEY ( id_pessoa );

ALTER TABLE pessoa_juridica ADD CONSTRAINT pessoa_juridica_pkv1 UNIQUE ( cnpj );

ALTER TABLE conta_especial
    ADD CONSTRAINT conta_especial_conta_comum_fk FOREIGN KEY ( nro_conta,
                                                               cod_agencia )
        REFERENCES conta_comum ( nro_conta,
                                 cod_agencia );

ALTER TABLE conta_poupanca
    ADD CONSTRAINT conta_poupanca_conta_comum_fk FOREIGN KEY ( nro_conta,
                                                               cod_agencia )
        REFERENCES conta_comum ( nro_conta,
                                 cod_agencia );

ALTER TABLE movimento
    ADD CONSTRAINT movimento_conta_comum_fk FOREIGN KEY ( conta_comum_nro_conta,
                                                          conta_comum_cod_agencia )
        REFERENCES conta_comum ( nro_conta,
                                 cod_agencia );

ALTER TABLE pessoa_conta
    ADD CONSTRAINT pessoa_conta_conta_comum_fk FOREIGN KEY ( conta_comum_nro_conta,
                                                             conta_comum_cod_agencia )
        REFERENCES conta_comum ( nro_conta,
                                 cod_agencia );

ALTER TABLE pessoa_conta
    ADD CONSTRAINT pessoa_conta_pessoa_fk FOREIGN KEY ( pessoa_id_pessoa )
        REFERENCES pessoa ( id_pessoa );

ALTER TABLE pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pessoa_fk FOREIGN KEY ( id_pessoa )
        REFERENCES pessoa ( id_pessoa );

ALTER TABLE pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pessoa_fk FOREIGN KEY ( id_pessoa )
        REFERENCES pessoa ( id_pessoa );
