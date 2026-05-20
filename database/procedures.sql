USE sistema_ventas_inventario;

DELIMITER $$

-- Procedimiento 1: registrar una venta
CREATE PROCEDURE registrar_venta (
    IN p_cliente_id INT,
    IN p_usuario_id INT,
    IN p_producto_id INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_precio_venta DECIMAL(10,2);
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_stock_actual INT;
    DECLARE v_venta_id INT;

    SELECT stock, precio_venta
    INTO v_stock_actual, v_precio_venta
    FROM productos
    WHERE id = p_producto_id;

    IF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la venta';
    ELSE
        SET v_subtotal = v_precio_venta * p_cantidad;

        INSERT INTO ventas (cliente_id, usuario_id, total)
        VALUES (p_cliente_id, p_usuario_id, v_subtotal);

        SET v_venta_id = LAST_INSERT_ID();

        INSERT INTO detalle_ventas (
            venta_id,
            producto_id,
            cantidad,
            precio_unitario,
            subtotal
        )
        VALUES (
            v_venta_id,
            p_producto_id,
            p_cantidad,
            v_precio_venta,
            v_subtotal
        );

        UPDATE productos
        SET stock = stock - p_cantidad
        WHERE id = p_producto_id;
    END IF;
END $$

-- Procedimiento 2: registrar una compra
CREATE PROCEDURE registrar_compra (
    IN p_proveedor_id INT,
    IN p_usuario_id INT,
    IN p_producto_id INT,
    IN p_cantidad INT,
    IN p_precio_unitario DECIMAL(10,2)
)
BEGIN
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_compra_id INT;

    SET v_subtotal = p_cantidad * p_precio_unitario;

    INSERT INTO compras (proveedor_id, usuario_id, total)
    VALUES (p_proveedor_id, p_usuario_id, v_subtotal);

    SET v_compra_id = LAST_INSERT_ID();

    INSERT INTO detalle_compras (
        compra_id,
        producto_id,
        cantidad,
        precio_unitario,
        subtotal
    )
    VALUES (
        v_compra_id,
        p_producto_id,
        p_cantidad,
        p_precio_unitario,
        v_subtotal
    );

    UPDATE productos
    SET stock = stock + p_cantidad
    WHERE id = p_producto_id;
END $$

DELIMITER ;