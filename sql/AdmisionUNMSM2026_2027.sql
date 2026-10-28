/* ============================================================
   ADMISIÓN UNMSM · 2026-II y 2027-I
   ============================================================ */
USE AdmisionUNMSM;
GO

/* 1. Tablas de staging */
DROP TABLE IF EXISTS stg_20262;
CREATE TABLE stg_20262 (
    cod_escuela     NVARCHAR(10),
    escuela         NVARCHAR(200),
    codigo          NVARCHAR(10),
    puntaje         NVARCHAR(20),
    merito          NVARCHAR(20),
    observacion     NVARCHAR(200),
    ausente         NVARCHAR(10),
    alcanzo_vacante NVARCHAR(10),
    articulo_5      NVARCHAR(10)
);

DROP TABLE IF EXISTS stg_20271;
CREATE TABLE stg_20271 (
    cod_escuela     NVARCHAR(10),
    escuela         NVARCHAR(200),
    codigo          NVARCHAR(10),
    puntaje         NVARCHAR(20),
    merito          NVARCHAR(20),
    observacion     NVARCHAR(200),
    ausente         NVARCHAR(10),
    alcanzo_vacante NVARCHAR(10)
);
GO

/* 2. Carga de los CSV (cambiar @ruta) */
DECLARE @ruta NVARCHAR(260) = N'C:\Users\USUARIO\Desktop\JOSE\Claudio\AdmisionUNMSM\';
DECLARE @sql  NVARCHAR(MAX);

SET @sql = N'BULK INSERT stg_20262 FROM ''' + @ruta + N'admision_unmsm_20262.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', ROWTERMINATOR=''0x0a'', CODEPAGE=''65001'');';
EXEC sp_executesql @sql;

SET @sql = N'BULK INSERT stg_20271 FROM ''' + @ruta + N'admision_unmsm_20271.csv'' WITH (FORMAT=''CSV'', FIRSTROW=2, FIELDQUOTE=''"'', ROWTERMINATOR=''0x0a'', CODEPAGE=''65001'');';
EXEC sp_executesql @sql;
GO

/* 3. Áreas, facultades y sedes */
DROP TABLE IF EXISTS areas;
CREATE TABLE areas (
    cod_area CHAR(1)     PRIMARY KEY,
    area     VARCHAR(60) NOT NULL
);
INSERT INTO areas (cod_area, area) VALUES
('A', 'Ciencias de la Salud'),
('B', 'Ciencias Básicas'),
('C', 'Ingenierías'),
('D', 'Ciencias Económicas y de la Gestión'),
('E', 'Humanidades y Ciencias Jurídicas y Sociales');
GO

DROP TABLE IF EXISTS facultades;
CREATE TABLE facultades (
    cod_escuela VARCHAR(10)  PRIMARY KEY,
    escuela     VARCHAR(200) NOT NULL,
    facultad    VARCHAR(100) NOT NULL,
    cod_area    CHAR(1)      NOT NULL,
    area        VARCHAR(60)  NOT NULL
);
INSERT INTO facultades (cod_escuela, escuela, facultad, cod_area, area) VALUES
('011','MEDICINA HUMANA','Medicina','A','Ciencias de la Salud'),
('012','OBSTETRICIA','Medicina','A','Ciencias de la Salud'),
('013','ENFERMERÍA','Medicina','A','Ciencias de la Salud'),
('0141','TEC. MED. LAB. CLÍNICO Y ANATOMÍA PATOLÓGICA','Medicina','A','Ciencias de la Salud'),
('0142','TEC. MED. TERAPIA FÍSICA Y REHABILITACIÓN','Medicina','A','Ciencias de la Salud'),
('0143','TEC. MED. RADIOLOGÍA','Medicina','A','Ciencias de la Salud'),
('0144','TEC. MED. TERAPIA OCUPACIONAL','Medicina','A','Ciencias de la Salud'),
('015','NUTRICIÓN','Medicina','A','Ciencias de la Salud'),
('022','DERECHO','Derecho y Ciencia Política','E','Humanidades y Ciencias Jurídicas y Sociales'),
('023','CIENCIA POLÍTICA','Derecho y Ciencia Política','E','Humanidades y Ciencias Jurídicas y Sociales'),
('031','LITERATURA','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('0310','LENGUAS, TRADUCCIÓN E INTERPRETACIÓN','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('033','FILOSOFÍA','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('034','LINGÜÍSTICA','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('035','COMUNICACIÓN SOCIAL','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('036','ARTE','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('037','BIBLIOTECOLOGÍA Y CIENCIAS DE LA INFORMACIÓN','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('038','DANZA','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('039','CONSERVACIÓN Y RESTAURACIÓN','Letras y Ciencias Humanas','E','Humanidades y Ciencias Jurídicas y Sociales'),
('041','FARMACIA Y BIOQUÍMICA','Farmacia y Bioquímica','A','Ciencias de la Salud'),
('042','CIENCIAS DE LOS ALIMENTOS','Farmacia y Bioquímica','A','Ciencias de la Salud'),
('043','TOXICOLOGÍA','Farmacia y Bioquímica','A','Ciencias de la Salud'),
('051','ODONTOLOGÍA','Odontología','A','Ciencias de la Salud'),
('0611','EDUCACIÓN INICIAL','Educación','E','Humanidades y Ciencias Jurídicas y Sociales'),
('0612','EDUCACIÓN PRIMARIA','Educación','E','Humanidades y Ciencias Jurídicas y Sociales'),
('0613','EDUCACIÓN SECUNDARIA','Educación','E','Humanidades y Ciencias Jurídicas y Sociales'),
('062','EDUCACIÓN FÍSICA','Educación','E','Humanidades y Ciencias Jurídicas y Sociales'),
('071','QUÍMICA','Química e Ing. Química','B','Ciencias Básicas'),
('072','INGENIERÍA QUÍMICA','Química e Ing. Química','C','Ingenierías'),
('073','INGENIERÍA AGROINDUSTRIAL','Química e Ing. Química','C','Ingenierías'),
('074','INGENIERÍA DEL AGUA Y TECNOLOGÍAS DE TRATAMIENTO','Química e Ing. Química','C','Ingenierías'),
('081','MEDICINA VETERINARIA','Medicina Veterinaria','A','Ciencias de la Salud'),
('091','ADMINISTRACIÓN','Ciencias Administrativas','D','Ciencias Económicas y de la Gestión'),
('092','ADMINISTRACIÓN DE TURISMO','Ciencias Administrativas','D','Ciencias Económicas y de la Gestión'),
('093','ADMINISTRACIÓN DE NEGOCIOS INTERNACIONALES','Ciencias Administrativas','D','Ciencias Económicas y de la Gestión'),
('094','ADMINISTRACIÓN DE LA GASTRONOMÍA','Ciencias Administrativas','D','Ciencias Económicas y de la Gestión'),
('095','ADMINISTRACIÓN MARÍTIMA Y PORTUARIA','Ciencias Administrativas','D','Ciencias Económicas y de la Gestión'),
('096','MARKETING','Ciencias Administrativas','D','Ciencias Económicas y de la Gestión'),
('101','CIENCIAS BIOLÓGICAS','Ciencias Biológicas','B','Ciencias Básicas'),
('102','GENÉTICA Y BIOTECNOLOGÍA','Ciencias Biológicas','B','Ciencias Básicas'),
('103','MICROBIOLOGÍA Y PARASITOLOGÍA','Ciencias Biológicas','B','Ciencias Básicas'),
('111','CONTABILIDAD','Ciencias Contables','D','Ciencias Económicas y de la Gestión'),
('112','GESTIÓN TRIBUTARIA','Ciencias Contables','D','Ciencias Económicas y de la Gestión'),
('113','AUDITORÍA EMPRESARIAL Y DEL SECTOR PÚBLICO','Ciencias Contables','D','Ciencias Económicas y de la Gestión'),
('114','PRESUPUESTO Y FINANZAS PÚBLICAS','Ciencias Contables','D','Ciencias Económicas y de la Gestión'),
('115','CRIMINALÍSTICA FINANCIERA FORENSE','Ciencias Contables','D','Ciencias Económicas y de la Gestión'),
('121','ECONOMÍA','Ciencias Económicas','D','Ciencias Económicas y de la Gestión'),
('122','ECONOMÍA PÚBLICA','Ciencias Económicas','D','Ciencias Económicas y de la Gestión'),
('123','ECONOMÍA INTERNACIONAL','Ciencias Económicas','D','Ciencias Económicas y de la Gestión'),
('131','FÍSICA','Ciencias Físicas','B','Ciencias Básicas'),
('132','INGENIERÍA MECÁNICA DE FLUIDOS','Ciencias Físicas','C','Ingenierías'),
('133','GEOFÍSICA','Ciencias Físicas','B','Ciencias Básicas'),
('134','CIENCIA DE MATERIALES Y NANOTECNOLOGÍA','Ciencias Físicas','B','Ciencias Básicas'),
('141','MATEMÁTICA','Ciencias Matemáticas','B','Ciencias Básicas'),
('142','ESTADÍSTICA','Ciencias Matemáticas','B','Ciencias Básicas'),
('144','INVESTIGACIÓN OPERATIVA','Ciencias Matemáticas','B','Ciencias Básicas'),
('145','COMPUTACIÓN CIENTÍFICA','Ciencias Matemáticas','B','Ciencias Básicas'),
('151','HISTORIA','Ciencias Sociales','E','Humanidades y Ciencias Jurídicas y Sociales'),
('152','SOCIOLOGÍA','Ciencias Sociales','E','Humanidades y Ciencias Jurídicas y Sociales'),
('153','ANTROPOLOGÍA','Ciencias Sociales','E','Humanidades y Ciencias Jurídicas y Sociales'),
('154','ARQUEOLOGÍA','Ciencias Sociales','E','Humanidades y Ciencias Jurídicas y Sociales'),
('155','TRABAJO SOCIAL','Ciencias Sociales','E','Humanidades y Ciencias Jurídicas y Sociales'),
('157','GEOGRAFÍA','Ciencias Sociales','E','Humanidades y Ciencias Jurídicas y Sociales'),
('162','INGENIERÍA GEOLÓGICA','FIGMMG','C','Ingenierías'),
('163','INGENIERÍA GEOGRÁFICA','FIGMMG','C','Ingenierías'),
('165','INGENIERÍA DE MINAS','FIGMMG','C','Ingenierías'),
('166','INGENIERÍA METALÚRGICA','FIGMMG','C','Ingenierías'),
('167','INGENIERÍA CIVIL','FIGMMG','C','Ingenierías'),
('168','INGENIERÍA AMBIENTAL','FIGMMG','C','Ingenierías'),
('169','ARQUITECTURA Y URBANISMO','FIGMMG','C','Ingenierías'),
('171','INGENIERÍA INDUSTRIAL','Ingeniería Industrial','C','Ingenierías'),
('172','INGENIERÍA TEXTIL Y CONFECCIONES','Ingeniería Industrial','C','Ingenierías'),
('173','INGENIERÍA DE SEGURIDAD Y SALUD EN EL TRABAJO','Ingeniería Industrial','C','Ingenierías'),
('174','INGENIERÍA LOGÍSTICA Y CADENA DE SUMINISTRO DIGITAL','Ingeniería Industrial','C','Ingenierías'),
('175','INGENIERÍA DE TRANSPORTE Y SISTEMAS FERROVIARIOS','Ingeniería Industrial','C','Ingenierías'),
('181','PSICOLOGÍA','Psicología','A','Ciencias de la Salud'),
('182','PSICOLOGÍA ORGANIZACIONAL Y DE LA GESTIÓN HUMANA','Psicología','A','Ciencias de la Salud'),
('191','INGENIERÍA ELECTRÓNICA','Ing. Electrónica y Eléctrica','C','Ingenierías'),
('192','INGENIERÍA ELÉCTRICA','Ing. Electrónica y Eléctrica','C','Ingenierías'),
('193','INGENIERÍA DE TELECOMUNICACIONES','Ing. Electrónica y Eléctrica','C','Ingenierías'),
('194','INGENIERÍA BIOMÉDICA','Ing. Electrónica y Eléctrica','C','Ingenierías'),
('195','INGENIERÍA MECATRÓNICA','Ing. Electrónica y Eléctrica','C','Ingenierías'),
('196','INGENIERÍA NUCLEAR','Ing. Electrónica y Eléctrica','C','Ingenierías'),
('201','INGENIERÍA DE SISTEMAS','Ing. de Sistemas e Informática','C','Ingenierías'),
('202','INGENIERÍA DE SOFTWARE','Ing. de Sistemas e Informática','C','Ingenierías'),
('203','CIENCIAS DE LA COMPUTACIÓN','Ing. de Sistemas e Informática','C','Ingenierías'),
('204','INGENIERÍA DE INTELIGENCIA ARTIFICIAL','Ing. de Sistemas e Informática','C','Ingenierías');
GO

DROP TABLE IF EXISTS sedes;
CREATE TABLE sedes (
    cod_sede   TINYINT     PRIMARY KEY,
    sede       VARCHAR(40) NOT NULL,
    sufijo_oca VARCHAR(20) NOT NULL
);
INSERT INTO sedes (cod_sede, sede, sufijo_oca) VALUES
(1, 'CIUDAD UNIVERSITARIA',   ''),
(2, 'SAN JUAN DE LURIGANCHO', 'S.J.L'),
(3, 'HUARAL',                 'HUARAL'),
(4, 'CHILCA',                 'CHILCA'),
(5, 'VILLA RICA',             'VILLA RICA'),
(6, 'OYÓN',                   'OYÓN'),
(7, 'CHANCAY',                'CHANCAY');
GO

/* 4. Tabla final de postulantes (ambos exámenes) */
DROP TABLE IF EXISTS postulantes;
CREATE TABLE postulantes (
    id               INT IDENTITY(1,1) PRIMARY KEY,
    examen           VARCHAR(10)   NOT NULL,
    codigo           VARCHAR(10)   NOT NULL,
    cod_escuela      VARCHAR(10)   NOT NULL,
    escuela_oca      VARCHAR(200)  NOT NULL,
    cod_escuela_base VARCHAR(10)   NOT NULL,
    cod_sede         TINYINT       NOT NULL,
    puntaje          DECIMAL(10,3) NULL,
    merito           INT           NULL,
    observacion      VARCHAR(200)  NULL,
    ausente          BIT           NOT NULL,
    alcanzo_vacante  BIT           NOT NULL,
    articulo_5       BIT           NOT NULL,
    estado AS (
        CASE
            WHEN ausente = 1         THEN 'Ausente'
            WHEN articulo_5 = 1      THEN 'Impedido (art. 5)'
            WHEN alcanzo_vacante = 1 THEN 'Ingresante'
            ELSE 'No ingresante'
        END
    ) PERSISTED,
    CONSTRAINT uq_examen_codigo UNIQUE (examen, codigo)
);
GO

/* 5. Carga de ambos exámenes */
-- 5.1 2026-II
INSERT INTO postulantes
    (examen, codigo, cod_escuela, escuela_oca, cod_escuela_base, cod_sede,
     puntaje, merito, observacion, ausente, alcanzo_vacante, articulo_5)
SELECT
    '2026-II',
    s.codigo,
    s.cod_escuela,
    s.escuela,
    CASE WHEN s.escuela LIKE '% - %' THEN LEFT(s.cod_escuela, 3) ELSE s.cod_escuela END,
    se.cod_sede,
    TRY_CAST(NULLIF(s.puntaje, '') AS DECIMAL(10,3)),
    TRY_CAST(TRY_CAST(NULLIF(s.merito, '') AS DECIMAL(10,1)) AS INT),
    NULLIF(s.observacion, ''),
    CASE WHEN UPPER(s.ausente)         = 'TRUE' THEN 1 ELSE 0 END,
    CASE WHEN UPPER(s.alcanzo_vacante) = 'TRUE' THEN 1 ELSE 0 END,
    CASE WHEN UPPER(s.articulo_5)      = 'TRUE' THEN 1 ELSE 0 END
FROM stg_20262 s
LEFT JOIN sedes se
       ON se.sufijo_oca = CASE WHEN s.escuela LIKE '% - %'
                               THEN LTRIM(SUBSTRING(s.escuela, CHARINDEX(' - ', s.escuela) + 3, 50))
                               ELSE '' END;

-- 5.2 2027-I
INSERT INTO postulantes
    (examen, codigo, cod_escuela, escuela_oca, cod_escuela_base, cod_sede,
     puntaje, merito, observacion, ausente, alcanzo_vacante, articulo_5)
SELECT
    '2027-I',
    s.codigo,
    s.cod_escuela,
    s.escuela,
    CASE WHEN s.escuela LIKE '% - %' THEN LEFT(s.cod_escuela, 3) ELSE s.cod_escuela END,
    se.cod_sede,
    TRY_CAST(NULLIF(s.puntaje, '') AS DECIMAL(10,3)),
    TRY_CAST(TRY_CAST(NULLIF(s.merito, '') AS DECIMAL(10,1)) AS INT),
    NULLIF(s.observacion, ''),
    CASE WHEN UPPER(s.ausente)         = 'TRUE' THEN 1 ELSE 0 END,
    CASE WHEN UPPER(s.alcanzo_vacante) = 'TRUE' THEN 1 ELSE 0 END,
    0
FROM stg_20271 s
LEFT JOIN sedes se
       ON se.sufijo_oca = CASE WHEN s.escuela LIKE '% - %'
                               THEN LTRIM(SUBSTRING(s.escuela, CHARINDEX(' - ', s.escuela) + 3, 50))
                               ELSE '' END;
GO

/* 6. Vacantes 2027-I (Anexo 1 del reglamento) */
DROP TABLE IF EXISTS vacantes_20271;
CREATE TABLE vacantes_20271 (
    cod_escuela_base VARCHAR(10) NOT NULL,
    cod_sede         TINYINT     NOT NULL,
    vacantes         INT         NOT NULL,
    CONSTRAINT pk_vacantes_20271 PRIMARY KEY (cod_escuela_base, cod_sede)
);
INSERT INTO vacantes_20271 (cod_escuela_base, cod_sede, vacantes) VALUES
('011',1,54),('012',1,36),('013',1,39),('0141',1,14),('0142',1,13),('0143',1,14),('0144',1,13),('015',1,20),
('041',1,27),('042',1,10),('043',1,10),('051',1,24),('081',1,19),('181',1,35),('182',1,16),
('071',1,27),('101',1,17),('102',1,15),('103',1,17),('131',1,18),('133',1,18),('134',1,18),('141',1,28),('142',1,28),('144',1,28),('145',1,28),
('072',1,31),('073',1,28),('074',1,18),('132',1,26),('162',1,21),('163',1,19),('165',1,17),('166',1,17),('167',1,13),('168',1,13),('169',1,10),
('171',1,67),('172',1,24),('173',1,17),('174',1,23),('175',1,15),('191',1,40),('192',1,35),('193',1,30),('194',1,20),('195',1,20),('196',1,20),
('201',1,35),('202',1,35),('203',1,35),('204',1,35),
('091',1,83),('092',1,67),('093',1,47),('094',1,12),('095',1,11),('096',1,12),('111',1,90),('112',1,50),('113',1,50),('114',1,40),('115',1,40),
('121',1,77),('122',1,69),('123',1,72),
('091',2,9),('092',2,14),('093',2,8),('111',2,16),('112',2,16),('113',2,16),('114',2,16),
('111',3,14),
('022',1,90),('023',1,40),('031',1,16),('033',1,14),('034',1,16),('035',1,22),('036',1,14),('037',1,15),('038',1,7),('039',1,14),
('0310',1,15),('0611',1,11),('0612',1,11),('0613',1,40),('062',1,36),('151',1,15),('152',1,18),('153',1,20),('154',1,19),('155',1,35),('157',1,34);
GO

/* 7. Vistas para Power BI */
CREATE OR ALTER VIEW vw_postulantes AS
SELECT
    p.examen, p.codigo, p.cod_escuela_base,
    f.escuela, f.facultad, f.cod_area, f.area,
    se.sede,
    p.puntaje, p.merito, p.observacion,
    p.ausente, p.alcanzo_vacante, p.articulo_5, p.estado
FROM postulantes p
JOIN facultades f  ON f.cod_escuela = p.cod_escuela_base
JOIN sedes      se ON se.cod_sede   = p.cod_sede;
GO

CREATE OR ALTER VIEW vw_vacantes_2027 AS
SELECT
    f.cod_area, f.area, f.facultad,
    f.cod_escuela AS cod_escuela_base,
    f.escuela,
    se.sede,
    v.vacantes,
    COUNT(CASE WHEN p.estado = 'Ingresante' THEN 1 END)              AS ingresantes,
    v.vacantes - COUNT(CASE WHEN p.estado = 'Ingresante' THEN 1 END) AS no_cubiertas
FROM vacantes_20271 v
JOIN facultades f  ON f.cod_escuela = v.cod_escuela_base
JOIN sedes      se ON se.cod_sede   = v.cod_sede
LEFT JOIN postulantes p
       ON p.examen = '2027-I'
      AND p.cod_escuela_base = v.cod_escuela_base
      AND p.cod_sede         = v.cod_sede
GROUP BY f.cod_area, f.area, f.facultad, f.cod_escuela, f.escuela, se.sede, v.vacantes;
GO

CREATE OR ALTER VIEW vw_postulantes_20262 AS
SELECT * FROM vw_postulantes WHERE examen = '2026-II';
GO

CREATE OR ALTER VIEW vw_postulantes_20271 AS
SELECT * FROM vw_postulantes WHERE examen = '2027-I';
GO

/* 8. Validaciones */
-- 8.1 Estados por examen
SELECT examen, estado, COUNT(*) AS n
FROM postulantes
GROUP BY examen, estado
ORDER BY examen, estado;

-- 8.2 Por sede
SELECT examen, sede, COUNT(*) AS postulantes,
       SUM(CASE WHEN estado = 'Ingresante' THEN 1 ELSE 0 END) AS ingresantes
FROM vw_postulantes
GROUP BY examen, sede
ORDER BY examen, sede;

-- 8.3 Vacantes vs ingresantes 2027-I
SELECT SUM(vacantes) AS vacantes, SUM(ingresantes) AS ingresantes, SUM(no_cubiertas) AS diferencia
FROM vw_vacantes_2027;

-- 8.4 Chequeos de consistencia
SELECT
    SUM(CASE WHEN ausente = 1 AND puntaje IS NOT NULL THEN 1 ELSE 0 END) AS ausente_con_puntaje,
    SUM(CASE WHEN ausente = 0 AND puntaje IS NULL     THEN 1 ELSE 0 END) AS presente_sin_puntaje,
    SUM(CASE WHEN escuela IS NULL                     THEN 1 ELSE 0 END) AS sin_facultad
FROM vw_postulantes;
GO
