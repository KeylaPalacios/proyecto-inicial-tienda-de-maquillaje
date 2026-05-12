-- ============================================================
--  TIENDA DE MAQUILLAJE — Schema SQL
--  Motor: MySQL 8+ / MariaDB 10.6+
-- ============================================================

-- ------------------------------------------------------------
-- CATÁLOGO
-- ------------------------------------------------------------

CREATE TABLE marca (
    id_marca       INT            NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(100)   NOT NULL,
    pais_origen    VARCHAR(80),
    descripcion    TEXT,
    activo         TINYINT(1)     NOT NULL DEFAULT 1,
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_marca)
);

CREATE TABLE categoria (
    id_categoria   INT            NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(100)   NOT NULL,
    descripcion    TEXT,
    id_padre       INT,
    PRIMARY KEY (id_categoria),
    FOREIGN KEY (id_padre) REFERENCES categoria(id_categoria)
);

CREATE TABLE producto (
    id_producto    INT            NOT NULL AUTO_INCREMENT,
    id_marca       INT            NOT NULL,
    id_categoria   INT            NOT NULL,
    nombre         VARCHAR(150)   NOT NULL,
    descripcion    TEXT,
    precio_base    DECIMAL(10,2)  NOT NULL,
    activo         TINYINT(1)     NOT NULL DEFAULT 1,
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_marca)     REFERENCES marca(id_marca),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE variante (
    id_variante    INT            NOT NULL AUTO_INCREMENT,
    id_producto    INT            NOT NULL,
    tono           VARCHAR(80),
    codigo_hex     CHAR(7),
    sku            VARCHAR(50)    NOT NULL UNIQUE,
    stock          INT            NOT NULL DEFAULT 0,
    stock_minimo   INT            NOT NULL DEFAULT 5,
    precio_extra   DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_variante),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE imagen_producto (
    id_imagen      INT            NOT NULL AUTO_INCREMENT,
    id_producto    INT            NOT NULL,
    url            VARCHAR(500)   NOT NULL,
    es_principal   TINYINT(1)     NOT NULL DEFAULT 0,
    orden          TINYINT        NOT NULL DEFAULT 0,
    PRIMARY KEY (id_imagen),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- ------------------------------------------------------------
-- CLIENTES Y USUARIOS
-- ------------------------------------------------------------

CREATE TABLE rol (
    id_rol         INT            NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(50)    NOT NULL UNIQUE,
    descripcion    VARCHAR(200),
    PRIMARY KEY (id_rol)
);

CREATE TABLE usuario (
    id_usuario     INT            NOT NULL AUTO_INCREMENT,
    id_rol         INT            NOT NULL,
    email          VARCHAR(150)   NOT NULL UNIQUE,
    password_hash  VARCHAR(255)   NOT NULL,
    activo         TINYINT(1)     NOT NULL DEFAULT 1,
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

CREATE TABLE cliente (
    id_cliente     INT            NOT NULL AUTO_INCREMENT,
    id_usuario     INT,
    nombre         VARCHAR(100)   NOT NULL,
    apellido       VARCHAR(100),
    email          VARCHAR(150)   NOT NULL UNIQUE,
    telefono       VARCHAR(20),
    fecha_nac      DATE,
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE direccion (
    id_direccion   INT            NOT NULL AUTO_INCREMENT,
    id_cliente     INT            NOT NULL,
    alias          VARCHAR(50),
    calle          VARCHAR(200)   NOT NULL,
    colonia        VARCHAR(100),
    ciudad         VARCHAR(100)   NOT NULL,
    estado         VARCHAR(100),
    codigo_postal  VARCHAR(10)    NOT NULL,
    pais           VARCHAR(80)    NOT NULL DEFAULT 'México',
    referencias    TEXT,
    es_default     TINYINT(1)     NOT NULL DEFAULT 0,
    PRIMARY KEY (id_direccion),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- ------------------------------------------------------------
-- VENTAS Y PEDIDOS
-- ------------------------------------------------------------

CREATE TABLE metodo_pago (
    id_metodo      INT            NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(80)    NOT NULL,
    activo         TINYINT(1)     NOT NULL DEFAULT 1,
    PRIMARY KEY (id_metodo)
);

CREATE TABLE cupon (
    id_cupon       INT            NOT NULL AUTO_INCREMENT,
    codigo         VARCHAR(30)    NOT NULL UNIQUE,
    tipo_descuento ENUM('porcentaje','fijo') NOT NULL,
    descuento      DECIMAL(10,2)  NOT NULL,
    uso_maximo     INT,
    usos_actuales  INT            NOT NULL DEFAULT 0,
    vigencia_desde DATE,
    vigencia_hasta DATE,
    activo         TINYINT(1)     NOT NULL DEFAULT 1,
    PRIMARY KEY (id_cupon)
);

CREATE TABLE pedido (
    id_pedido      INT            NOT NULL AUTO_INCREMENT,
    id_cliente     INT            NOT NULL,
    id_direccion   INT            NOT NULL,
    id_cupon       INT,
    estatus        ENUM('pendiente','confirmado','en_preparacion',
                        'enviado','entregado','cancelado','devuelto')
                   NOT NULL DEFAULT 'pendiente',
    subtotal       DECIMAL(10,2)  NOT NULL,
    descuento      DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    impuestos      DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    total          DECIMAL(10,2)  NOT NULL,
    notas          TEXT,
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP
                                  ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente)   REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (id_cupon)     REFERENCES cupon(id_cupon)
);

CREATE TABLE detalle_pedido (
    id_detalle     INT            NOT NULL AUTO_INCREMENT,
    id_pedido      INT            NOT NULL,
    id_variante    INT            NOT NULL,
    cantidad       INT            NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal       DECIMAL(10,2)  NOT NULL,
    PRIMARY KEY (id_detalle),
    FOREIGN KEY (id_pedido)   REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_variante) REFERENCES variante(id_variante)
);

CREATE TABLE carrito (
    id_carrito     INT            NOT NULL AUTO_INCREMENT,
    id_cliente     INT,
    sesion_id      VARCHAR(100),
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_carrito),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE detalle_carrito (
    id_detalle_carr INT           NOT NULL AUTO_INCREMENT,
    id_carrito      INT           NOT NULL,
    id_variante     INT           NOT NULL,
    cantidad        INT           NOT NULL DEFAULT 1,
    PRIMARY KEY (id_detalle_carr),
    FOREIGN KEY (id_carrito)  REFERENCES carrito(id_carrito),
    FOREIGN KEY (id_variante) REFERENCES variante(id_variante)
);

-- ------------------------------------------------------------
-- PAGOS Y FACTURACIÓN
-- ------------------------------------------------------------

CREATE TABLE pago (
    id_pago        INT            NOT NULL AUTO_INCREMENT,
    id_pedido      INT            NOT NULL,
    id_metodo      INT            NOT NULL,
    monto          DECIMAL(10,2)  NOT NULL,
    referencia     VARCHAR(200),
    estatus        ENUM('pendiente','aprobado','rechazado','reembolsado')
                   NOT NULL DEFAULT 'pendiente',
    fecha_pago     DATETIME,
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_metodo) REFERENCES metodo_pago(id_metodo)
);

CREATE TABLE factura (
    id_factura     INT            NOT NULL AUTO_INCREMENT,
    id_pedido      INT            NOT NULL UNIQUE,
    rfc            VARCHAR(13)    NOT NULL,
    razon_social   VARCHAR(200)   NOT NULL,
    uso_cfdi       VARCHAR(10),
    timbre_fiscal  TEXT,
    fecha_emision  DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- ------------------------------------------------------------
-- ENVÍOS Y LOGÍSTICA
-- ------------------------------------------------------------

CREATE TABLE paqueteria (
    id_paqueteria  INT            NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(100)   NOT NULL,
    activo         TINYINT(1)     NOT NULL DEFAULT 1,
    PRIMARY KEY (id_paqueteria)
);

CREATE TABLE envio (
    id_envio       INT            NOT NULL AUTO_INCREMENT,
    id_pedido      INT            NOT NULL UNIQUE,
    id_paqueteria  INT            NOT NULL,
    num_guia       VARCHAR(100),
    fecha_estimada DATE,
    fecha_entrega  DATE,
    estatus        ENUM('pendiente','recolectado','en_transito',
                        'en_reparto','entregado','devuelto')
                   NOT NULL DEFAULT 'pendiente',
    costo_envio    DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_envio),
    FOREIGN KEY (id_pedido)     REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_paqueteria) REFERENCES paqueteria(id_paqueteria)
);

-- ------------------------------------------------------------
-- PROVEEDORES E INVENTARIO
-- ------------------------------------------------------------

CREATE TABLE proveedor (
    id_proveedor   INT            NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(150)   NOT NULL,
    contacto       VARCHAR(150),
    email          VARCHAR(150),
    telefono       VARCHAR(20),
    pais           VARCHAR(80),
    activo         TINYINT(1)     NOT NULL DEFAULT 1,
    PRIMARY KEY (id_proveedor)
);

CREATE TABLE orden_compra (
    id_orden       INT            NOT NULL AUTO_INCREMENT,
    id_proveedor   INT            NOT NULL,
    fecha          DATE           NOT NULL,
    estatus        ENUM('borrador','enviada','parcial','completada','cancelada')
                   NOT NULL DEFAULT 'borrador',
    total          DECIMAL(10,2),
    notas          TEXT,
    PRIMARY KEY (id_orden),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

CREATE TABLE detalle_orden_compra (
    id_detalle_oc  INT            NOT NULL AUTO_INCREMENT,
    id_orden       INT            NOT NULL,
    id_variante    INT            NOT NULL,
    cantidad       INT            NOT NULL,
    precio_costo   DECIMAL(10,2)  NOT NULL,
    subtotal       DECIMAL(10,2)  NOT NULL,
    PRIMARY KEY (id_detalle_oc),
    FOREIGN KEY (id_orden)    REFERENCES orden_compra(id_orden),
    FOREIGN KEY (id_variante) REFERENCES variante(id_variante)
);

-- ------------------------------------------------------------
-- MARKETING Y FIDELIZACIÓN
-- ------------------------------------------------------------

CREATE TABLE resena (
    id_resena      INT            NOT NULL AUTO_INCREMENT,
    id_cliente     INT            NOT NULL,
    id_producto    INT            NOT NULL,
    calificacion   TINYINT        NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    comentario     TEXT,
    aprobada       TINYINT(1)     NOT NULL DEFAULT 0,
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_resena),
    FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE lista_deseos (
    id_lista       INT            NOT NULL AUTO_INCREMENT,
    id_cliente     INT            NOT NULL,
    id_variante    INT            NOT NULL,
    agregado_en    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_lista),
    UNIQUE KEY uq_cliente_variante (id_cliente, id_variante),
    FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_variante) REFERENCES variante(id_variante)
);

CREATE TABLE programa_puntos (
    id_puntos      INT            NOT NULL AUTO_INCREMENT,
    id_cliente     INT            NOT NULL UNIQUE,
    puntos_total   INT            NOT NULL DEFAULT 0,
    puntos_canjeados INT          NOT NULL DEFAULT 0,
    PRIMARY KEY (id_puntos),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE historial_puntos (
    id_historial   INT            NOT NULL AUTO_INCREMENT,
    id_cliente     INT            NOT NULL,
    id_pedido      INT,
    tipo           ENUM('acumulacion','canje','vencimiento','ajuste')
                   NOT NULL,
    puntos         INT            NOT NULL,
    descripcion    VARCHAR(200),
    creado_en      DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_historial),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pedido)  REFERENCES pedido(id_pedido)
);

-- ------------------------------------------------------------
-- DATOS INICIALES
-- ------------------------------------------------------------

INSERT INTO rol (nombre, descripcion) VALUES
  ('admin',    'Acceso total al sistema'),
  ('vendedor', 'Gestión de ventas e inventario'),
  ('cliente',  'Compras en la tienda');

INSERT INTO metodo_pago (nombre) VALUES
  ('Efectivo'), ('Tarjeta crédito'), ('Tarjeta débito'),
  ('Transferencia'), ('OXXO Pay'), ('PayPal');

INSERT INTO paqueteria (nombre) VALUES
  ('DHL'), ('FedEx'), ('Estafeta'), ('J&T Express'), ('99minutos');

INSERT INTO categoria (nombre, descripcion) VALUES
  ('Labiales',      'Labiales, lip gloss y lip liner'),
  ('Bases',         'Bases, BB cream y correctores'),
  ('Sombras',       'Paletas y sombras de ojos'),
  ('Delineadores',  'Delineadores y máscaras'),
  ('Rubores',       'Rubores, iluminadores y contour'),
  ('Skincare',      'Cuidado de la piel'),
  ('Fijadores',     'Primers, setting spray y polvo');
