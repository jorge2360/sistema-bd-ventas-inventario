# Documentación técnica de base de datos

## Nombre de la base de datos

`sistema_ventas_inventario`

---

## Descripción general

La base de datos fue diseñada para gestionar un sistema básico de ventas e inventario. Permite registrar usuarios, clientes, proveedores, categorías, productos, compras, ventas y sus respectivos detalles.

El modelo implementa relaciones entre entidades principales, control de inventario, reportes mediante vistas SQL, consultas analíticas, procedimientos almacenados y triggers demostrativos.

---

## Entidades principales

### usuarios

Almacena los usuarios responsables de registrar compras y ventas dentro del sistema.

Campos principales:

- `id`
- `nombre`
- `correo`
- `contrasena`
- `fecha_creacion`

### clientes

Almacena la información de clientes a quienes se realizan ventas.

Campos principales:

- `id`
- `nombre_completo`
- `correo`
- `telefono`
- `direccion`

### proveedores

Registra los proveedores de productos.

Campos principales:

- `id`
- `nombre_empresa`
- `nombre_contacto`
- `telefono`
- `correo`
- `direccion`

### categorias

Clasifica los productos dentro del inventario.

Campos principales:

- `id`
- `nombre`
- `descripcion`

### productos

Almacena los productos disponibles, sus precios, stock, categoría y proveedor.

Campos principales:

- `id`
- `categoria_id`
- `proveedor_id`
- `nombre`
- `stock`
- `precio_compra`
- `precio_venta`

### compras

Registra las compras realizadas a proveedores.

Campos principales:

- `id`
- `proveedor_id`
- `usuario_id`
- `fecha_compra`
- `total`

### detalle_compras

Registra los productos incluidos en cada compra.

Campos principales:

- `id`
- `compra_id`
- `producto_id`
- `cantidad`
- `precio_unitario`
- `subtotal`

### ventas

Registra las ventas realizadas a clientes.

Campos principales:

- `id`
- `cliente_id`
- `usuario_id`
- `fecha_venta`
- `total`

### detalle_ventas

Registra los productos incluidos en cada venta.

Campos principales:

- `id`
- `venta_id`
- `producto_id`
- `cantidad`
- `precio_unitario`
- `subtotal`

---

## Relaciones principales

- Un producto pertenece a una categoría.
- Un producto pertenece a un proveedor.
- Una compra pertenece a un proveedor.
- Una compra es registrada por un usuario.
- Una compra puede tener varios detalles de compra.
- Una venta pertenece a un cliente.
- Una venta es registrada por un usuario.
- Una venta puede tener varios detalles de venta.
- Cada detalle de compra o venta pertenece a un producto.

---

## Vistas SQL

El proyecto incluye vistas para facilitar reportes frecuentes:

- `vista_productos_detallados`
- `vista_ventas_detalladas`
- `vista_resumen_ventas_clientes`
- `vista_inventario_valorizado`
- `vista_productos_stock_bajo`

---

## Procedimientos almacenados

Se incluyen procedimientos demostrativos para:

- Registrar ventas.
- Registrar compras.
- Validar stock antes de realizar una venta.
- Actualizar inventario después de compras o ventas.

Procedimientos:

- `registrar_venta`
- `registrar_compra`

---

## Triggers

El proyecto incluye triggers demostrativos para automatizar movimientos de inventario:

- `trg_descontar_stock_venta`
- `trg_aumentar_stock_compra`

Nota: los procedimientos almacenados y los triggers representan dos enfoques alternativos para actualizar inventario. En un sistema real se recomienda elegir uno de los dos enfoques para evitar duplicidad en los movimientos de stock.

---

## Buenas prácticas aplicadas

- Uso de claves primarias.
- Uso de claves foráneas.
- Separación entre encabezado y detalle de compras/ventas.
- Normalización básica.
- Consultas con `JOIN`.
- Vistas para reportes reutilizables.
- Procedimientos almacenados para lógica de negocio.
- Triggers para automatización de inventario.