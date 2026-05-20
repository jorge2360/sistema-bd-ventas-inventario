USE sistema_ventas_inventario;

-- 1. Listado general de productos con categoría y proveedor
SELECT
    p.id,
    p.nombre AS producto,
    c.nombre AS categoria,
    pr.nombre_empresa AS proveedor,
    p.stock,
    p.precio_compra,
    p.precio_venta
FROM productos p
INNER JOIN categorias c
    ON p.categoria_id = c.id
INNER JOIN proveedores pr
    ON p.proveedor_id = pr.id;

-- 2. Productos con stock bajo
SELECT
    id,
    nombre,
    stock
FROM productos
WHERE stock <= 5;

-- 3. Ventas con cliente y usuario responsable
SELECT
    v.id AS venta_id,
    c.nombre_completo AS cliente,
    u.nombre AS usuario,
    v.fecha_venta,
    v.total
FROM ventas v
INNER JOIN clientes c
    ON v.cliente_id = c.id
INNER JOIN usuarios u
    ON v.usuario_id = u.id;

-- 4. Detalle de ventas con productos
SELECT
    v.id AS venta_id,
    c.nombre_completo AS cliente,
    p.nombre AS producto,
    dv.cantidad,
    dv.precio_unitario,
    dv.subtotal
FROM detalle_ventas dv
INNER JOIN ventas v
    ON dv.venta_id = v.id
INNER JOIN clientes c
    ON v.cliente_id = c.id
INNER JOIN productos p
    ON dv.producto_id = p.id;

-- 5. Total vendido por cliente
SELECT
    c.nombre_completo AS cliente,
    SUM(v.total) AS total_comprado
FROM ventas v
INNER JOIN clientes c
    ON v.cliente_id = c.id
GROUP BY c.nombre_completo
ORDER BY total_comprado DESC;

-- 6. Total vendido por producto
SELECT
    p.nombre AS producto,
    SUM(dv.cantidad) AS unidades_vendidas,
    SUM(dv.subtotal) AS total_vendido
FROM detalle_ventas dv
INNER JOIN productos p
    ON dv.producto_id = p.id
GROUP BY p.nombre
ORDER BY total_vendido DESC;

-- 7. Compras realizadas por proveedor
SELECT
    pr.nombre_empresa AS proveedor,
    COUNT(c.id) AS total_compras,
    SUM(c.total) AS monto_total_compras
FROM compras c
INNER JOIN proveedores pr
    ON c.proveedor_id = pr.id
GROUP BY pr.nombre_empresa
ORDER BY monto_total_compras DESC;

-- 8. Margen de ganancia por producto
SELECT
    nombre AS producto,
    precio_compra,
    precio_venta,
    (precio_venta - precio_compra) AS ganancia_unitaria
FROM productos
ORDER BY ganancia_unitaria DESC;

-- 9. Ventas por usuario
SELECT
    u.nombre AS usuario,
    COUNT(v.id) AS cantidad_ventas,
    SUM(v.total) AS total_vendido
FROM ventas v
INNER JOIN usuarios u
    ON v.usuario_id = u.id
GROUP BY u.nombre
ORDER BY total_vendido DESC;

-- 10. Inventario valorizado
SELECT
    nombre AS producto,
    stock,
    precio_compra,
    (stock * precio_compra) AS valor_inventario
FROM productos
ORDER BY valor_inventario DESC;