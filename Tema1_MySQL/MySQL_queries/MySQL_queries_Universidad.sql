SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento LIKE '1999%';
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento FROM profesor pr JOIN persona p ON pr.id_profesor = p.id JOIN departamento d ON pr.id_departamento = d.id ORDER BY p.apellido1, p.apellido2, p.nombre;
SELECT a.nombre, c.anyo_inicio, c.anyo_fin FROM alumno_se_matricula_asignatura aa JOIN curso_escolar c ON aa.id_curso_escolar = c.id JOIN persona p ON aa.id_alumno = p.id JOIN asignatura a ON aa.id_asignatura = a.id WHERE p.nif = '26902806M';
SELECT DISTINCT d.nombre AS nombre_departamento FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON a.id_profesor = p.id_profesor JOIN grado g ON g.id = a.id_grado WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
SELECT DISTINCT aa.id_alumno, p.apellido1, p.nombre, c.anyo_inicio, c.anyo_fin FROM alumno_se_matricula_asignatura aa JOIN curso_escolar c ON aa.id_curso_escolar = c.id JOIN persona p ON p.id = aa.id_alumno WHERE c.anyo_inicio = 2018 AND c.anyo_fin = 2019;
     -- -- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN -- --
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pr ON pr.id_profesor = p.id LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE p.tipo = 'profesor' ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;
SELECT p.apellido1, p.apellido2, p.nombre, p.tipo, pr.id_departamento FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor WHERE p.tipo = 'profesor' AND pr.id_profesor IS NULL;
SELECT d.nombre AS departamento, p.id_profesor FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento WHERE p.id_profesor IS NULL;
SELECT pr.id_profesor, p.apellido1, p.apellido2, p.nombre, a.id AS id_asignatura FROM profesor pr LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor LEFT JOIN persona p ON pr.id_profesor = p.id WHERE a.id IS NULL ORDER BY pr.id_profesor;
SELECT DISTINCT a.nombre AS departamento, pr.id_profesor FROM asignatura a LEFT JOIN profesor pr ON a.id_profesor = pr.id_profesor WHERE pr.id_profesor IS NULL;
SELECT d.nombre AS departamento FROM departamento d WHERE d.nombre != (SELECT DISTINCT d.nombre FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor LEFT JOIN alumno_se_matricula_asignatura aa ON a.id = aa.id_asignatura LEFT JOIN curso_escolar c ON aa.id_curso_escolar = c.id WHERE c.id IS NOT NULL);



	 -- -- Consultes resum: -- --
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento LIKE '1999%';
SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS num_profesores FROM departamento d JOIN profesor p ON d.id = p.id_departamento GROUP BY d.nombre ORDER BY COUNT(p.id_profesor) DESC;
SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS num_profesores FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento GROUP BY d.nombre ORDER BY COUNT(p.id_profesor) DESC;
SELECT g.nombre AS grado, COUNT(a.nombre) AS num_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY COUNT(a.nombre) DESC;
SELECT g.nombre AS grado, COUNT(a.nombre) AS num_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING COUNT(a.nombre) > 40 ORDER BY COUNT(a.nombre) DESC;
SELECT g.nombre AS grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS Suma_creditos FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo;
SELECT c.anyo_inicio AS curso_inicio, COUNT(DISTINCT aa.id_alumno) AS num_alumnos FROM curso_escolar c LEFT JOIN alumno_se_matricula_asignatura aa ON c.id = aa.id_curso_escolar GROUP BY c.anyo_inicio;
SELECT pe.id AS id_profesor, pe.nombre, pe.apellido1, pe.apellido2, COUNT(a.id) AS num_asignaturas FROM persona pe LEFT JOIN profesor pr ON pe.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE pe.tipo = 'profesor' GROUP BY pe.id ORDER BY COUNT(a.id) DESC;
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento LIKE (SELECT MAX(fecha_nacimiento) FROM persona);
SELECT pe.id AS id_profesor, pe.nombre, pe.apellido1, pe.apellido2, pr.id_departamento AS id_departamento, a.id AS id_asignatura FROM profesor pr LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor LEFT JOIN persona pe ON pr.id_profesor = pe.id WHERE a.id IS NULL;