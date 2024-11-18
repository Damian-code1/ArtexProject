CREATE DATABASE metrus;
USE metrus;

CREATE TABLE Personas (
    ci VARCHAR(20) PRIMARY KEY NOT NULL,
    estado BOOLEAN,
    mail VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Tel_Personas (
    ci_P VARCHAR(20) PRIMARY KEY NOT NULL,
    numero_telefonico VARCHAR(30),
    FOREIGN KEY (ci_P) REFERENCES Personas(ci)
);

CREATE TABLE Admins (
    ci_P VARCHAR(20),
    cod_admin varchar(4),
    FOREIGN KEY (ci_P) REFERENCES Personas(ci)
);

CREATE TABLE Docentes (
    ci_P VARCHAR(20),
    cod_docente VARCHAR(4),
    FOREIGN KEY (ci_P) REFERENCES Personas(ci)
);

CREATE TABLE Asignaturas (
    nombre VARCHAR(50) PRIMARY KEY NOT NULL,
    descripcion VARCHAR(100),
    orientacion VARCHAR(50),
    version INT DEFAULT 1,
    color varchar(10)
);

CREATE TABLE Dicta (
    año DATE,
    ci_D VARCHAR(20),
    nombre_A VARCHAR(50),
    PRIMARY KEY (año, ci_D, nombre_A),
    FOREIGN KEY (ci_D) REFERENCES Docentes(ci_P),
    FOREIGN KEY (nombre_A) REFERENCES Asignaturas(nombre)
);

CREATE TABLE Entiende (
    ci_P VARCHAR(20),
    comentario VARCHAR(100),
    ci_D VARCHAR(20),
    FOREIGN KEY (ci_D) REFERENCES Docentes(ci_P),
    FOREIGN KEY (ci_P) REFERENCES Personas(ci)
);

CREATE TABLE Horarios (
    dia CHAR(1) NOT NULL CHECK(dia IN('L', 'M', 'X', 'J', 'V')),
    hora INT NOT NULL,
    curso VARCHAR(50) NOT NULL,
    color VARCHAR(10),
    PRIMARY KEY(dia, hora)
);

CREATE TABLE Grupo (
    id INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    grado VARCHAR(50) NOT NULL,
    dia_H CHAR(1) NOT NULL,
    hora_H INT NOT NULL,
    PRIMARY KEY (id, nombre, dia_H, hora_H),
    FOREIGN KEY (dia_H, hora_H) REFERENCES Horarios(dia, hora)
);

CREATE TABLE Pertenece (
    ci_D VARCHAR(20),
    año_D DATE,
    nombre_A VARCHAR(50),
    nombre_G VARCHAR(50),
    dia_H CHAR(1),
    hora_H INT,
    id_G INT,
    PRIMARY KEY (dia_H, hora_H, año_D, ci_D, nombre_A, nombre_G, id_G),
    FOREIGN KEY (año_D, ci_D, nombre_A) REFERENCES Dicta(año, ci_D, nombre_A),
    FOREIGN KEY (id_G, nombre_G, dia_H, hora_H) REFERENCES Grupo(id, nombre, dia_H, hora_H)
);

CREATE TABLE Recursos (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    numero VARCHAR(20) NOT NULL,
    cantidad INT NOT NULL
);

CREATE TABLE Salones (
    id_R INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    FOREIGN KEY (id_R) REFERENCES Recursos(id)
);

CREATE TABLE Computadoras (
    id_R INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    FOREIGN KEY (id_R) REFERENCES Recursos(id)
);

CREATE TABLE Equipamiento (
    id_R INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    FOREIGN KEY (id_R) REFERENCES Recursos(id)
);

CREATE TABLE Talleres (
    id_R INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    FOREIGN KEY (id_R) REFERENCES Recursos(id)
);

CREATE TABLE Tienen (
    dia_H CHAR(1),
    hora_H INT,
    año_D DATE,
    ci_D VARCHAR(20),
    nombre_A VARCHAR(50),
    nombre_G VARCHAR(50),
    id_G INT,
    id_R INT,
    PRIMARY KEY (dia_H, hora_H, año_D, ci_D, nombre_A, nombre_G, id_G, id_R),
    FOREIGN KEY (dia_H, hora_H, año_D, ci_D, nombre_A, nombre_G, id_G) REFERENCES Pertenece(dia_H, hora_H, año_D, ci_D, nombre_A, nombre_G, id_G),
    FOREIGN KEY (id_R) REFERENCES Recursos(id)
);

-- INSERTS
-- Insert en Personas
INSERT INTO Personas (ci, estado, mail, contraseña, nombre) VALUES
('12345678', false, 'persona1@gmail.com', 'contraseña1', 'Juan Pérez'),
('23456789', false, 'persona2@gmail.com', 'contraseña2', 'Ana Gómez'),
('34567890', false, 'persona3@gmail.com', 'contraseña3', 'Luis Fernández'),
('45678901', false, 'persona4@gmail.com', 'contraseña4', 'Carlos Ramírez'),
('56789012', false, 'persona5@gmail.com', 'contraseña5', 'Marta Sánchez'),
('67890123', false, 'persona6@gmail.com', 'contraseña6', 'José Rodríguez'),
('78901234', false, 'persona7@gmail.com', 'contraseña7', 'Pedro López'),
('89012345', false, 'persona8@gmail.com', 'contraseña8', 'Lucía Martínez'),
('90123456', false, 'persona9@gmail.com', 'contraseña9', 'Javier García'),
('11223344', false, 'persona10@gmail.com', 'contraseña10', 'Isabel Torres');

-- Insert en Tel_Personas
INSERT INTO Tel_Personas (ci_P, numero_telefonico) VALUES
('12345678', '091489860'),
('23456789', '091489861'),
('34567890', '091489862'),
('45678901', '091489863'),
('56789012', '091489864'),
('67890123', '091489865'),
('78901234', '091489866'),
('89012345', '091489867'),
('90123456', '091489868'),
('11223344', '091489869');

-- Insert en Admins
INSERT INTO Admins (ci_P, cod_admin) VALUES
('12345678', 'A001'),
('23456789', 'A002'),
('34567890', 'A003'),
('45678901', 'A004'),
('56789012', 'A005'),
('67890123', 'A006'),
('78901234', 'A007'),
('89012345', 'A008'),
('90123456', 'A009'),
('11223344', 'A010');

-- Insert en Docentes
INSERT INTO Docentes (ci_P, cod_docente) VALUES
('12345678', 'D001'),
('23456789', 'D002'),
('34567890', 'D003'),
('45678901', 'D004'),
('56789012', 'D005'),
('67890123', 'D006'),
('78901234', 'D007'),
('89012345', 'D008'),
('90123456', 'D009'),
('11223344', 'D010');

-- Insert en Asignaturas
INSERT INTO Asignaturas (nombre, descripcion, orientacion, version, color) VALUES
('Matemáticas', 'Asignatura de álgebra y cálculo', 'Ciencias', 1, '#FF0000'),
('Historia', 'Estudio de eventos históricos', 'Humanidades', 1, '#0000FF'),
('Biología', 'Estudio de organismos vivos', 'Ciencias', 1, '#008000'),
('Física', 'Estudio de la materia y energía', 'Ciencias', 1, '#FFFF00'),
('Literatura', 'Estudio de obras literarias', 'Humanidades', 1, '#800080'),
('Química', 'Estudio de la composición y propiedades de la materia', 'Ciencias', 1, '#FFA500'),
('Geografía', 'Estudio de la Tierra y sus características', 'Humanidades', 1, '#FFC0CB'),
('Arte', 'Estudio de las artes visuales', 'Humanidades', 1, '#87CEEB'),
('Informática', 'Estudio de computadoras y programación', 'Ciencias', 1, '#808080'),
('Educación Física', 'Actividad física y salud', 'Ciencias', 1, '#98FB98');

-- Insert en Dicta
INSERT INTO Dicta (año, ci_D, nombre_A) VALUES
('2024-01-01', '12345678', 'Matemáticas'),
('2024-01-01', '23456789', 'Historia'),
('2024-01-01', '34567890', 'Biología'),
('2024-01-01', '45678901', 'Física'),
('2024-01-01', '56789012', 'Literatura'),
('2024-01-01', '67890123', 'Química'),
('2024-01-01', '78901234', 'Geografía'),
('2024-01-01', '89012345', 'Arte'),
('2024-01-01', '90123456', 'Informática'),
('2024-01-01', '11223344', 'Educación Física');

-- Insert en Entiende
INSERT INTO Entiende (ci_P, comentario, ci_D) VALUES
('12345678', 'Muy buen docente', '12345678'),
('23456789', 'Explica bien la historia', '23456789'),
('34567890', 'Explicaciones claras sobre biología', '34567890'),
('45678901', 'Buen profesor de física', '45678901'),
('56789012', 'Muy buena literatura', '56789012'),
('67890123', 'Clara explicación de química', '67890123'),
('78901234', 'Entiende muy bien geografía', '78901234'),
('89012345', 'Excelente clase de arte', '89012345'),
('90123456', 'Buen enfoque en informática', '90123456'),
('11223344', 'Excelente en educación física', '11223344');

-- Insert en Horarios
INSERT INTO Horarios (dia, hora, curso, color) VALUES
('L', 9, 'Matemáticas', '#FF0000'),
('M', 10, 'Historia', '#0000FF'),
('X', 11, 'Biología', '#008000'),
('J', 12, 'Física', '#FFFF00'),
('V', 13, 'Literatura', '#800080'),
('L', 14, 'Química', '#FFA500'),
('M', 15, 'Geografía', '#FFC0CB'),
('X', 16, 'Arte', '#87CEEB'),
('J', 17, 'Informática', '#808080'),
('V', 18, 'Educación Física', '#98FB98');

-- Insert en Grupo
INSERT INTO Grupo (nombre, grado, dia_H, hora_H) VALUES
('Grupo A', '1°', 'L', 9),
('Grupo B', '2°', 'M', 10),
('Grupo C', '3°', 'X', 11),
('Grupo D', '4°', 'J', 12),
('Grupo E', '5°', 'V', 13),
('Grupo F', '6°', 'L', 14),
('Grupo G', '7°', 'M', 15),
('Grupo H', '8°', 'X', 16),
('Grupo I', '9°', 'J', 17),
('Grupo J', '10°', 'V', 18);

-- Insert en Pertenece
INSERT INTO Pertenece (ci_D, año_D, nombre_A, nombre_G, dia_H, hora_H, id_G) VALUES
('12345678', '2024-01-01', 'Matemáticas', 'Grupo A', 'L', 9, 1),
('23456789', '2024-01-01', 'Historia', 'Grupo B', 'M', 10, 2),
('34567890', '2024-01-01', 'Biología', 'Grupo C', 'X', 11, 3),
('45678901', '2024-01-01', 'Física', 'Grupo D', 'J', 12, 4),
('56789012', '2024-01-01', 'Literatura', 'Grupo E', 'V', 13, 5),
('67890123', '2024-01-01', 'Química', 'Grupo F', 'L', 14, 6),
('78901234', '2024-01-01', 'Geografía', 'Grupo G', 'M', 15, 7),
('89012345', '2024-01-01', 'Arte', 'Grupo H', 'X', 16, 8),
('90123456', '2024-01-01', 'Informática', 'Grupo I', 'J', 17, 9),
('11223344', '2024-01-01', 'Educación Física', 'Grupo J', 'V', 18, 10);

-- Insert en Recursos
INSERT INTO Recursos (numero, cantidad) VALUES
('R001', 30),
('R002', 20),
('R003', 15),
('R004', 25),
('R005', 10),
('R006', 18),
('R007', 22),
('R008', 28),
('R009', 35),
('R010', 40);

-- Insert en Salones
INSERT INTO Salones (id_R) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert en Computadoras
INSERT INTO Computadoras (id_R) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert en Equipamiento
INSERT INTO Equipamiento (id_R) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert en Talleres
INSERT INTO Talleres (id_R) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert en Tienen
INSERT INTO Tienen (dia_H, hora_H, año_D, ci_D, nombre_A, nombre_G, id_G, id_R) VALUES
('L', 9, '2024-01-01', '12345678', 'Matemáticas', 'Grupo A', 1, 1),
('M', 10, '2024-01-01', '23456789', 'Historia', 'Grupo B', 2, 2),
('X', 11, '2024-01-01', '34567890', 'Biología', 'Grupo C', 3, 3),
('J', 12, '2024-01-01', '45678901', 'Física', 'Grupo D', 4, 4),
('V', 13, '2024-01-01', '56789012', 'Literatura', 'Grupo E', 5, 5),
('L', 14, '2024-01-01', '67890123', 'Química', 'Grupo F', 6, 6),
('M', 15, '2024-01-01', '78901234', 'Geografía', 'Grupo G', 7, 7),
('X', 16, '2024-01-01', '89012345', 'Arte', 'Grupo H', 8, 8),
('J', 17, '2024-01-01', '90123456', 'Informática', 'Grupo I', 9, 9),
('V', 18, '2024-01-01', '11223344', 'Educación Física', 'Grupo J', 10, 10);




-- Consultas MySQL
-- 1. Obtener todos los horarios de un docente determinado indicando el nombre, grupos y recurso a utilizar en el centro educativo.
SELECT D.ci_D, P.mail, G.nombre AS grupo, H.dia, H.hora, R.numero AS recurso
FROM Dicta D
JOIN Personas P ON D.ci_D = P.ci
JOIN Pertenece Pe ON D.ci_D = Pe.ci_D AND D.nombre_A = Pe.nombre_A
JOIN Grupo G ON Pe.id_G = G.id
JOIN Horarios H ON G.dia_H = H.dia AND G.hora_H = H.hora
JOIN Tienen T ON Pe.ci_D = T.ci_D AND Pe.nombre_A = T.nombre_A AND Pe.id_G = T.id_G
JOIN Recursos R ON T.id_R = R.id
WHERE D.ci_D = '12345678';

-- 2. Obtener la cantidad de docentes que dictan cada asignatura.
SELECT nombre_A, COUNT(ci_D) AS cantidad_docentes
FROM Dicta
GROUP BY nombre_A;

-- 3. Cantidad de docentes disponibles en cada franja horaria.
SELECT H.dia, H.hora, COUNT(DISTINCT P.ci_D) AS cantidad_docentes
FROM Horarios H
LEFT JOIN Pertenece P ON H.dia = P.dia_H AND H.hora = P.hora_H
GROUP BY H.dia, H.hora;

-- 4. Crear una vista que obtenga los horarios de cada docente indicando la asignatura a dictar en el mismo y el salón a utilizar.
CREATE VIEW VistaHorariosDocentes AS
SELECT D.ci_D, D.nombre_A, H.dia, H.hora, R.numero AS recurso
FROM Dicta D
JOIN Pertenece P ON D.ci_D = P.ci_D AND D.nombre_A = P.nombre_A
JOIN Horarios H ON P.dia_H = H.dia AND P.hora_H = H.hora
JOIN Tienen T ON P.ci_D = T.ci_D AND P.nombre_A = T.nombre_A AND P.id_G = T.id_G
JOIN Recursos R ON T.id_R = R.id;

SELECT * from VistaHorariosDocentes;

-- 5. Historial de horas asignadas a cada docente en el transcurso de los años.
SELECT ci_D, YEAR(año_D) AS año, COUNT(*) AS horas_asignadas
FROM Pertenece
GROUP BY ci_D, YEAR(año_D);

-- 6. Listado de docentes que no les han asignado ningún horario en el año actual.
SELECT D.ci_P
FROM Docentes D
LEFT JOIN Pertenece P ON D.ci_P = P.ci_D AND YEAR(P.año_D) = YEAR(CURDATE())
WHERE P.ci_D IS NULL;

-- 7. Horarios más utilizados para dictar asignaturas.
SELECT H.dia, H.hora, COUNT(*) AS cantidad_asignaturas
FROM Horarios H
JOIN Pertenece P ON H.dia = P.dia_H AND H.hora = P.hora_H
GROUP BY H.dia, H.hora
ORDER BY cantidad_asignaturas DESC;

-- 8. Indicar por docente la cantidad de horas que dispone en el centro educativo en el año actual.
SELECT ci_D, COUNT(*) AS horas_disponibles
FROM Pertenece
WHERE YEAR(año_D) = YEAR(CURDATE())
GROUP BY ci_D;

-- 9. Total de recursos materiales y humanos por orientación.
SELECT A.orientacion, COUNT(DISTINCT D.ci_D) AS total_docentes, COUNT(DISTINCT R.id) AS total_recursos
FROM Asignaturas A
LEFT JOIN Dicta D ON A.nombre = D.nombre_A
LEFT JOIN Tienen T ON D.ci_D = T.ci_D AND D.nombre_A = T.nombre_A
LEFT JOIN Recursos R ON T.id_R = R.id
GROUP BY A.orientacion;

-- 10. Horarios sin asignar de cada grupo.
SELECT G.nombre AS grupo, H.dia, H.hora
FROM Grupo G
LEFT JOIN Horarios H ON G.dia_H = H.dia AND G.hora_H = H.hora
LEFT JOIN Pertenece P ON G.id = P.id_G AND H.dia = P.dia_H AND H.hora = P.hora_H
WHERE P.ci_D IS NULL;