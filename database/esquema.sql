CREATE DATABASE sistema_ventas_inventario;

USE sistema_ventas_inventario;

CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(150),
    telefono VARCHAR(30),
    direccion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE proveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_empresa VARCHAR(150) NOT NULL,
    nombre_contacto VARCHAR(150),
    telefono VARCHAR(30),
    correo VARCHAR(150),
    direccion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    categoria_id INT NOT NULL,
    proveedor_id INT NOT NULL,

    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,

    stock INT DEFAULT 0,

    precio_compra DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,

    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categorias(id),

    CONSTRAINT fk_producto_proveedor
        FOREIGN KEY (proveedor_id)
        REFERENCES proveedores(id)
);

CREATE TABLE compras (
    id INT PRIMARY KEY AUTO_INCREMENT,

    proveedor_id INT NOT NULL,
    usuario_id INT NOT NULL,

    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    total DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_compra_proveedor
        FOREIGN KEY (proveedor_id)
        REFERENCES proveedores(id),

    CONSTRAINT fk_compra_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
);

CREATE TABLE detalle_compras (
    id INT PRIMARY KEY AUTO_INCREMENT,

    compra_id INT NOT NULL,
    producto_id INT NOT NULL,

    cantidad INT NOT NULL,

    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_detalle_compra
        FOREIGN KEY (compra_id)
        REFERENCES compras(id),

    CONSTRAINT fk_detalle_compra_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
);

CREATE TABLE ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,

    cliente_id INT NOT NULL,
    usuario_id INT NOT NULL,

    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    total DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(id),

    CONSTRAINT fk_venta_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
);

CREATE TABLE detalle_ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,

    venta_id INT NOT NULL,
    producto_id INT NOT NULL,

    cantidad INT NOT NULL,

    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (venta_id)
        REFERENCES ventas(id),

    CONSTRAINT fk_detalle_venta_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
);