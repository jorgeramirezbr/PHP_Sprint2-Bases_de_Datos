INSERT INTO empleados (nombre)
VALUES ('empleado1'),
		('empleado2'),
        ('empleado3');
        
INSERT INTO clientes (nombre, telefono, correo_electronico, codigo_postal)
    VALUES ('Juan', 987654321, 'juan@mysql.com', 08019),
			('Pedro', 987654123, 'pedro@mysql.com', 08019),
            ('Juana', 967854321, 'juana@mysql.com', 08029),
            ('Robert', 988854321, 'robert@mysql.com', 08018),
            ('Raul', 977754321, 'raul@mysql.com', 08018),
            ('Carlos', 955654321, 'carlosn@mysql.com', 08010),
            ('Luis', 987655551, 'luis@mysql.com', 08010);
            
UPDATE clientes
SET cliente_recomendador_id= 1
WHERE cliente_id in (4, 7);
    
UPDATE clientes
SET cliente_recomendador_id= 3
WHERE cliente_id in (5,6);

INSERT INTO proveedores (nombre, NIF, telefono, fax)
VALUES ('maslentes', '80654307T', 123456789, 123456789),
		('masmas', '59862848N', 123456987, 123456987),
        ('misgafas', '56754307T', 177776789, null),
        ('veoproducts', '57765437T', 128527419, null),
        ('lentess', '80555307M', 123456666, 123456666);
        
INSERT INTO direcciones (proveedor_id, calle, numero, piso, puerta, ciudad, codigo_postal, pais)
VALUES (4, 'calle grande', 548, 5, 2, 'Bcn', '08018', 'España'),
		(1, 'calle chica', 338, null, null, 'Bcn', '08014', 'España'),
		(3, 'rio grande', 148, 5, null, 'Madrid', '07018', 'España'),
        (5, 'calle principal', 748, 5, 5, 'Valencia', '08098', 'España'),
        (2, 'costanera', 123, 5, null, 'Madrid', '08118', 'España'),
        (1, 'ufff', 38, 2, null, 'Terrasa', '08034', 'España');
        
INSERT INTO gafas (marca, graduacion_izq, graduacion_der, tipo_montura, color_montura, color_vidrio, precio, id_proveedor)
VALUES ('G&L', -1.25, -1.00, 'pasta', 'verde', 'transparente', 100, 5),
		('Glass', null, null, 'flotante', 'azul', 'celeste', 120, 3),
        ('Look', +3.25, +3.5, 'metalica', 'plata', 'transparente', 105, 1),
        ('Looper', +4.25, +3.25, 'metalica', 'blanca', 'transparente', 105, 5),
        ('Up', null, null, 'pasta', 'roja', 'rosa', 100, 2),
		('Full', null, null, 'metalica', 'negra', 'gris', 130, 4);
        
INSERT INTO ventas (cliente_id, empleado_id, gafa_id)
VALUES (7, 3, 6),
		(5, 1, 6),
        (4, 3, 5),
        (1, 3, 4),
        (1, 1, 4),
        (3, 2, 3),
        (2, 1, 2),
        (6, 1, 1),
        (4, 3, 1),
        (7, 2, 2);
        
-- Llista el total de compres d’un client/a.
SELECT * FROM ventas
WHERE cliente_id = 7;

-- Llista les diferents ulleres que ha venut un empleat durant un any.
SELECT E.nombre, G.marca, G.precio, V.venta_id, V.fecha_venta
FROM Gafas G
JOIN Ventas V ON V.gafa_id = G.gafa_id
JOIN Empleados E ON V.empleado_id = E.empleado_id
WHERE E.nombre = 'empleado3'
  AND YEAR(V.fecha_venta) = 2023;
  
-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
SELECT DISTINCT nombre
FROM Proveedores P
JOIN Gafas G ON P.proveedor_id = G.id_proveedor
JOIN Ventas V ON G.gafa_id = V.gafa_id;
