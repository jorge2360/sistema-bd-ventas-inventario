USE sistema_ventas_inventario;

DELIMITER $$

-- Trigger 1: descontar stock automáticamente al registrar detalle de venta
CREATE TRIGGER trg_descontar_stock_venta
AFTER INSERT ON detalle_ventas
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.producto_id;
END $$

-- Trigger 2: aumentar stock automáticamente al registrar detalle de compra
CREATE TRIGGER trg_aumentar_stock_compra
AFTER INSERT ON detalle_compras
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock = stock + NEW.cantidad
    WHERE id = NEW.producto_id;
END $$

DELIMITER ;