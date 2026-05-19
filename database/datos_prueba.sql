USE sistema_ventas_inventario;

INSERT INTO usuarios (
    nombre,
    correo,
    contrasena
)
VALUES
(
    'Administrador General',
    'admin@sistema.com',
    'admin123'
),
(
    'Jorge Garcia',
    'jorge@sistema.com',
    'jorge123'
);

INSERT INTO clientes (
    nombre_completo,
    correo,
    telefono,
    direccion
)
VALUES
(
    'Carlos Hernandez',
    'carlos@gmail.com',
    '5555-1111',
    'Antigua Guatemala'
),
(
    'Maria Lopez',
    'maria@gmail.com',
    '5555-2222',
    'Ciudad Vieja'
),
(
    'Luis Ramirez',
    'luis@gmail.com',
    '5555-3333',
    'Mixco'
);

INSERT INTO proveedores (
    nombre_empresa,
    nombre_contacto,
    telefono,
    correo,
    direccion
)
VALUES
(
    'Tecnologia GT',
    'Juan Perez',
    '4444-1111',
    'ventas@tecnologia.com',
    'Guatemala'
),
(
    'Distribuidora Electronica',
    'Ana Morales',
    '4444-2222',
    'info@electronica.com',
    'Villa Nueva'
);

INSERT INTO categorias (
    nombre,
    descripcion
)
VALUES
(
    'Laptops',
    'Computadoras portatiles'
),
(
    'Monitores',
    'Pantallas y monitores'
),
(
    'Accesorios',
    'Accesorios tecnologicos'
);

INSERT INTO productos (
    categoria_id,
    proveedor_id,
    nombre,
    descripcion,
    stock,
    precio_compra,
    precio_venta
)
VALUES
(
    1,
    1,
    'Laptop Lenovo IdeaPad',
    'Laptop Ryzen 5 16GB RAM',
    10,
    4500.00,
    5200.00
),
(
    1,
    1,
    'Laptop HP Victus',
    'Laptop Gamer RTX 4050',
    5,
    7200.00,
    8500.00
),
(
    2,
    2,
    'Monitor Samsung 24',
    'Monitor Full HD 75Hz',
    12,
    950.00,
    1250.00
),
(
    3,
    2,
    'Mouse Logitech',
    'Mouse inalambrico',
    30,
    80.00,
    150.00
);

INSERT INTO compras (
    proveedor_id,
    usuario_id,
    total
)
VALUES
(
    1,
    1,
    15000.00
),
(
    2,
    2,
    5000.00
);

INSERT INTO detalle_compras (
    compra_id,
    producto_id,
    cantidad,
    precio_unitario,
    subtotal
)
VALUES
(
    1,
    1,
    2,
    4500.00,
    9000.00
),
(
    1,
    2,
    1,
    6000.00,
    6000.00
),
(
    2,
    3,
    2,
    1000.00,
    2000.00
),
(
    2,
    4,
    20,
    150.00,
    3000.00
);

INSERT INTO ventas (
    cliente_id,
    usuario_id,
    total
)
VALUES
(
    1,
    1,
    5350.00
),
(
    2,
    2,
    1400.00
);

INSERT INTO detalle_ventas (
    venta_id,
    producto_id,
    cantidad,
    precio_unitario,
    subtotal
)
VALUES
(
    1,
    1,
    1,
    5200.00,
    5200.00
),
(
    1,
    4,
    1,
    150.00,
    150.00
),
(
    2,
    3,
    1,
    1250.00,
    1250.00
),
(
    2,
    4,
    1,
    150.00,
    150.00
);