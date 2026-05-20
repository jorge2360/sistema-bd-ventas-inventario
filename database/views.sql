USE sistema_ventas_inventario;

-- Vista 1: Productos con categoría y proveedor
CREATE VIEW vista_productos_detallados AS
SELECT
    p.id,
    p.nombre AS producto,
    c.nombre AS categoria,
    pr.nombre_empresa AS proveedor,
    p.stock,
    p.precio_compra,
    p.precio_venta,
    (p.precio_venta - p.precio_compra) AS ganancia_unitaria
FROM productos p
INNER JOIN categorias c
    ON p.categoria_id = c.id
INNER JOIN proveedores pr
    ON p.proveedor_id = pr.id;

-- Vista 2: Ventas detalladas
CREATE VIEW vista_ventas_detalladas AS
SELECT
    v.id AS venta_id,
    c.nombre_completo AS cliente,
    u.nombre AS usuario_responsable,
    p.nombre AS producto,
    dv.cantidad,
    dv.precio_unitario,
    dv.subtotal,
    v.fecha_venta
FROM detalle_ventas dv
INNER JOIN ventas v
    ON dv.venta_id = v.id
INNER JOIN clientes c
    ON v.cliente_id = c.id
INNER JOIN usuarios u
    ON v.usuario_id = u.id
INNER JOIN productos p
    ON dv.producto_id = p.id;

-- Vista 3: Resumen de ventas por cliente
CREATE VIEW vista_resumen_ventas_clientes AS
SELECT
    c.id AS cliente_id,
    c.nombre_completo AS cliente,
    COUNT(v.id) AS cantidad_ventas,
    SUM(v.total) AS total_comprado
FROM clientes c
INNER JOIN ventas v
    ON c.id = v.cliente_id
GROUP BY c.id, c.nombre_completo;

-- Vista 4: Inventario valorizado
CREATE VIEW vista_inventario_valorizado AS
SELECT
    p.id AS producto_id,
    p.nombre AS producto,
    p.stock,
    p.precio_compra,
    (p.stock * p.precio_compra) AS valor_inventario
FROM productos p;

-- Vista 5: Productos con stock bajo
CREATE VIEW vista_productos_stock_bajo AS
SELECT
    id,
    nombre AS producto,
    stock
FROM productos
WHERE stock <= 5;