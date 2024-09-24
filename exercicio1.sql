/*A universidade UFO quer implantar SI para controle de quantidade de carteiras por sala de aula nos seus diversos Campus.
 Atualmente ela possui 5 campus, em locais e cidades diferentes, Em cada um ela possui blocos de salas. Cada campus é
  identificado por um número sequencial e cada bloco é identificado por uma letra. As salas são numeradas sequencialmente 
  dentro de cada bloco. É importante que o sistema forneça algumas informações:

a.    Nome e endereço de cada um dos Campus.

b.    Para cada campus, quais são os blocos de sala de aula e para cada bloco quantas salas esse possui e quantos andares.

c.  De cada sala é necessário saber quantas carteiras temos nela, sua área e quais são as certeiras que estão localizadas 
na sala com: número de patrimônio da carteira e se o braço de apoio é do lado direito ou do lado esquerdo.*/


CREATE TABLE bloco (
    idbloco         INTEGER NOT NULL,
    idcampus        INTEGER NOT NULL,
    letra           VARCHAR2(1) NOT NULL,
    qtd_salas       INTEGER NOT NULL,
    qtd_andares     INTEGER NOT NULL,
    campus_idcampus INTEGER NOT NULL
);

ALTER TABLE bloco ADD CONSTRAINT bloco_pk PRIMARY KEY ( idbloco );

CREATE TABLE campus (
    idcampus INTEGER NOT NULL,
    nome     VARCHAR2(20) NOT NULL,
    endereco VARCHAR2(50) NOT NULL
);

ALTER TABLE campus ADD CONSTRAINT campus_pk PRIMARY KEY ( idcampus );

CREATE TABLE carteira (
    idcarteira  INTEGER NOT NULL,
    idsala      INTEGER NOT NULL,
    num         INTEGER NOT NULL,
    ladobraco   VARCHAR2(10) NOT NULL,
    sala_idsala INTEGER NOT NULL
);

ALTER TABLE carteira ADD CONSTRAINT carteira_pk PRIMARY KEY ( idcarteira );

CREATE TABLE sala (
    idsala        INTEGER NOT NULL,
    idbloco       INTEGER NOT NULL,
    numerosala    INTEGER NOT NULL,
    qtdcarteiras  INTEGER NOT NULL,
    bloco_idbloco INTEGER NOT NULL
);

ALTER TABLE sala ADD CONSTRAINT sala_pk PRIMARY KEY ( idsala );

ALTER TABLE bloco
    ADD CONSTRAINT bloco_campus_fk FOREIGN KEY ( campus_idcampus )
        REFERENCES campus ( idcampus );

ALTER TABLE carteira
    ADD CONSTRAINT carteira_sala_fk FOREIGN KEY ( sala_idsala )
        REFERENCES sala ( idsala );

ALTER TABLE sala
    ADD CONSTRAINT sala_bloco_fk FOREIGN KEY ( bloco_idbloco )
        REFERENCES bloco ( idbloco );

