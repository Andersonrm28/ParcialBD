-- 1. CREATE A TABLESPACE MID_TERM WITH ONE DATAFILE OF 50Mb
CREATE TABLESPACE MID_TERM
    DATAFILE 'DBFile.dbf' SIZE 50M;
    
-- 2. CREATE AN USER WITH 20Mb ASSIGNED TO THE TABLESPACE MID_TERM
CREATE USER INGANDERUSER
    IDENTIFIED BY INGANDERUSER
    DEFAULT TABLESPACE MID_TERM
    QUOTA 20M ON MID_TERM;
    
-- 3. GIVE THE DBA ROLE TO THE USER, ALSO SHOULD BE ABLE TO LOG IN.
GRANT DBA TO INGANDERUSER;
ALTER USER INGANDERUSER 
   GRANT CONNECT THROUGH INGANDERUSER
   WITH ROLE DBA;
   
-- 4. CREATE TWO SEQUENCES:
-- 4.1 COMUNAS_SEQ SHOULD START IN 50 WITH INCREMENTS OF 3
CREATE SEQUENCE COMUNAS_SEQ
    START WITH 50
    INCREMENT BY 3
    NOCYCLE;
-- 4.2 COLEGIOS_SEQ SHOULD START IN 100 WITH INCREMENTS OF 1
CREATE SEQUENCE COLEGIOS_SEQ
    START WITH 100
    INCREMENT BY 1
    NOCYCLE; 
    
-- 5. CREATE THE NEXT TABLES:
CREATE TABLE COMUNAS (
    ID INTEGER PRIMARY KEY,
    NOMBRE VARCHAR2(255)
);

-- 5.1 Insertar Informacion
INSERT INTO COMUNAS VALUES (1,  'POPULAR');
INSERT INTO COMUNAS VALUES (10, 'LA CANDELARIA');
INSERT INTO COMUNAS VALUES (11, 'LAURELES ESTADIO');
INSERT INTO COMUNAS VALUES (12, 'LA AMERICA');
INSERT INTO COMUNAS VALUES (13, 'SAN JAVIER');
INSERT INTO COMUNAS VALUES (14, 'POBLADO');
INSERT INTO COMUNAS VALUES (15, 'GUAYABAL');
INSERT INTO COMUNAS VALUES (16, 'BELÉN');
INSERT INTO COMUNAS VALUES (2,  'SANTA CRUZ');
INSERT INTO COMUNAS VALUES (3,  'MANRIQUE');
INSERT INTO COMUNAS VALUES (4,  'ARANJUEZ');
INSERT INTO COMUNAS VALUES (5,  'CASTILLA');
INSERT INTO COMUNAS VALUES (50, 'PALMITAS');
INSERT INTO COMUNAS VALUES (6,  'DOCE DE OCTUBRE');
INSERT INTO COMUNAS VALUES (60, 'SAN CRISTOBAL');
INSERT INTO COMUNAS VALUES (7,  'ROBLEDO');
INSERT INTO COMUNAS VALUES (70, 'ALTAVISTA');
INSERT INTO COMUNAS VALUES (8,  'VILLA HERMOSA');
INSERT INTO COMUNAS VALUES (80, 'SAN ANTONIO DE PRADO');
INSERT INTO COMUNAS VALUES (9,  'BUENOS AIRES');
INSERT INTO COMUNAS VALUES (90, 'SANTA ELENA');

-- 5.2 creacion de segunda tabla
create table colegios (
    ID integer PRIMARY KEY,
    COMUNA_FK integer,
    consecutivo_dane VARCHAR2(255),
    nombre_sede VARCHAR2(255),
    tipo_sede VARCHAR2(255),
    comuna_id INTEGER,
    prestacion_servicio VARCHAR2(255),
    zona VARCHAR2(255),
    barrio VARCHAR2(255),
    sector VARCHAR2(255),
    direccion_sede VARCHAR2(255),
    telefono_sede VARCHAR2(255),
    rector VARCHAR2(255),
    contador_prejardin_jardin INTEGER,
    contador_transicion INTEGER,
    contador_primaria INTEGER,
    contador_secundaria INTEGER,
    contador_media INTEGER,
    contador_adultos INTEGER,
    jornada_completa VARCHAR(8),
    jornada_manana VARCHAR(8),
    jornada_tarde VARCHAR(8),
    jornada_nocturna VARCHAR(8),
    jornada_fin_de_semana VARCHAR(8),
    jornada_unica VARCHAR(8),
    clasificacion_icfes VARCHAR(8)
);

-- RELACION
ALTER TABLE colegios
    ADD CONSTRAINT FK_COMUNA_COLEGIO FOREIGN KEY (COMUNA_FK) REFERENCES COMUNAS (ID);

--7.1: Traiga el nombre del barrio y el número de colegios ubicados en cada barrio de aquellas instituciones ubicadas en la 
-- comuna de buenos aires ordenado por el número de colegios de mayor a menor.
--   Columnas: barrio, numero_colegios

select colegios.barrio as barrio,
count(*) over (partition by colegios.id) as numero_colegios
from colegios inner join comunas on colegios.COMUNA_FK = comunas.id
where comunas.nombre = 'BUENOS AIRES'
group by colegios.barrio;

    
