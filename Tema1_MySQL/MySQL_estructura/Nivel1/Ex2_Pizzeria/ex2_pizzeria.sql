INSERT INTO categorias_pizzas (categoria_pizza_id, nombre)
VALUES (1, 'standar'),
		(2, 'extra'),
        (3, 'premium');
        
INSERT INTO tipos_productos (nombre, categoria_pizza_id)
VALUES ('bebida', null),
		('hamburguesa', null),
        ('pizza', 1),
        ('pizza', 2),
        ('pizza', 3);
        
INSERT INTO productos (nombre, precio, descripcion, tipo_producto_id)
VALUES ('coca-cola', 1.2, null, 1),
		('cafe', 1.0, null, 1),
        ('limonada', 1.0, null, 1),
        ('burger', 2.5, null, 2),
        ('burger-royal', 3.5, 'hamburguesa con huevo', 2),
        ('pizza-standard', 3.5, 'pizza simple', 3), 
        ('pizza-extra', 4.5, 'pizza con ingredientes extra', 4),
        ('pizza-premium', 5.5, 'pizza con ingredientes extra y borde relleno con queso', 5),
        ('pizza-standard-fam', 6.5, 'pizza familiar simple', 3), 
        ('pizza-extra-fam', 7.5, 'pizza familiar con ingredientes extra', 4),
        ('pizza-premium-fam', 8.5, 'pizza familiar con ingredientes extra y borde relleno con queso', 5);
        
INSERT INTO clientes (nombre, apellidos, direccion, codigo_postal, localidad, provincia, telefono)
VALUES ('jorge', 'ram', 'calle ensenada 45', 08019, 'bcn', 'bcn', '123456789'),
		('carlos', 'ram', 'calle ensenada 80', 08019, 'bcn', 'bcn', '123456788'),
        ('juan', 'sal', 'calle ancha 45', 08020, 'bcn', 'bcn', '123556789'),
        ('rosa', 'cal', 'calle alta 845', 08029, 'bcn', 'bcn', '128856789');
        
INSERT INTO tiendas (direccion, codigo_postal, localidad, provincia)
VALUES ('calle baja 145', 08020, 'bcn', 'bcn'),
		('calle ancha 181', 08021, 'bcn', 'bcn'),
        ('calle principal 15', 08010, 'bcn', 'bcn');
        
INSERT INTO empleados (nombre, apellidos, NIF, telefono, cargo, tienda_id)
VALUES ('axel', 'rose', '80654307T', '123456789', 'cocinero', 1),
		('marco', 'dase', '35654307T', '573456789', 'repartidor', 1),
        ('luis', 'grise', '59654307T', '223456789', 'cocinero', 2),
		('betty', 'jase', '35655577T', '577776789', 'repartidor', 2),
        ('sandra', 'ate', '44454307T', '883456789', 'cocinero', 3),
		('joaquin', 'rasa', '15654307T', '363456789', 'repartidor', 3);
        
INSERT INTO pedidos (cliente_id, id_tienda, tipo_de_entrega, precio_total, repartidor_id, fecha_hora_entrega)
VALUES (4, 3, 'tienda', null, null, null),
		(3, 3, 'domicilio', null, 6, null),
        (2, 2, 'tienda', null, null, null),
		(1, 2, 'domicilio', null, 4, null),
        (3, 1, 'tienda', null, null, null),
		(2, 1, 'domicilio', null, 2, null),
        (4, 3, 'domicilio', null, 6, null),
        (2, 2, 'domicilio', null, 4, null),
        (3, 1, 'domicilio', null, 2, null);
        
INSERT INTO detalle_pedidos(pedido_id, producto_id, cantidad)
VALUES (1, 1, 1),
		(1, 4, 1),
        (2, 1, 2),
        (2, 6, 2),
        (3, 2, 2),
        (4, 3, 4),
        (4, 11, 1),
        (5, 5, 1),
        (6, 10, 2),
        (7, 9, 2),
        (8, 3, 8),
        (8, 9, 2),
        (9, 11, 2),
        (9, 1, 8);
    
-- Lista de todas las 'bebidas' vendidas en todas las sedes 
SELECT *
FROM detalle_pedidos dp
JOIN pedidos pe
ON dp.pedido_id = pe.pedido_id
JOIN tiendas t
ON pe.id_tienda = t.tienda_id
JOIN productos pr
ON dp.producto_id = pr.producto_id
JOIN tipos_productos tp
ON pr.tipo_producto_id = tp.tipo_producto_id
WHERE tp.nombre = 'bebida';

-- Suma de todas las 'bebidas' vendidas en 'bcn'
SELECT SUM(dp.cantidad)
FROM detalle_pedidos dp
JOIN pedidos pe
ON dp.pedido_id = pe.pedido_id
JOIN tiendas t
ON pe.id_tienda = t.tienda_id
JOIN productos pr
ON dp.producto_id = pr.producto_id
JOIN tipos_productos tp
ON pr.tipo_producto_id = tp.tipo_producto_id
WHERE tp.nombre = 'bebida'
AND t.localidad = 'bcn';

-- Suma de todas las 'bebidas' vendidas en la tienda 3 
SELECT SUM(dp.cantidad)
FROM detalle_pedidos dp
JOIN pedidos pe
ON dp.pedido_id = pe.pedido_id
JOIN tiendas t
ON pe.id_tienda = t.tienda_id
JOIN productos pr
ON dp.producto_id = pr.producto_id
JOIN tipos_productos tp
ON pr.tipo_producto_id = tp.tipo_producto_id
WHERE tp.nombre = 'bebida'
AND t.tienda_id = 3;

-- Lista de nombres de los repartidores y sus respectivos pedidos
SELECT e.nombre, pe.pedido_id 
FROM pedidos pe
JOIN empleados e
ON pe.repartidor_id = e.empleado_id
WHERE repartidor_id IS NOT NULL;

   -- Cantidad de pedidos realizados por 'joaquin'
SELECT COUNT(pe.pedido_id)
FROM pedidos pe
JOIN empleados e
ON pe.repartidor_id = e.empleado_id
WHERE e.nombre = 'joaquin';     