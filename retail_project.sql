-- =====================================================
-- 2. CREA TABLAS clientes, productos
-- Después de crear la base de datos,
-- conectarse a retail_project antes de ejecutar
-- las siguientes instrucciones.
-- =====================================================


CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR (100) NOT NULL, 
    email VARCHAR(100) NOT NULL UNIQUE 
);

CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL (10,2) NOT NULL,
    stock INT NOT NULL, 

CONSTRAINT ck_productos_precio
CHECK(precio > 0),

CONSTRAINT ck_productos_stock
CHECK(stock >= 0)
);

-- =====================================================
-- 3. TABLA VENTAS
-- Se crea después de clientes y productos porque
-- contiene claves foráneas hacia esas tablas.
-- =====================================================


CREATE TABLE ventas (
     venta_id SERIAL PRIMARY KEY, 
     cliente_id INT NOT NULL, 
     producto_id INT NOT NULL, 
     cantidad INT NOT NULL,
     fecha_venta DATE NOT NULL DEFAULT CURRENT_DATE,

     CONSTRAINT fk_ventas_clientes 
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id), 

    CONSTRAINT fk_ventas_productos
        FOREIGN KEY (producto_id)
        REFERENCES productos(producto_id),
    
    CONSTRAINT ck_ventas_cantidad
        CHECK (cantidad > 0)
);

-- =====================================================
-- 4. CARGA INICIAL DE DATOS
-- =====================================================

BEGIN;

INSERT INTO clientes(nombre, email)
VALUES
    ('Ana Lopez', 'ana@mail.com'),
    ('Juan Perez', 'juan@mail.com'),
    ('Pedro Martinez', 'pedro@mail.com'),
    ('Armando Ruiz', 'armando@mail.com'),
    ('Carlos Sanchez', 'carlos@mail.com'),
    ('Cliente Prueba', 'prueba@mail.com');

INSERT INTO productos(nombre, categoria, precio, stock)
VALUES
    ('Aceite', 'abarrotes', 35.50, 20),
    ('Jabon', 'limpieza', 18.25, 30),
    ('Cloro', 'limpieza', 22.40, 15),
    ('Detergente', 'limpieza', 45.80, 10),
    ('Papel higienico', 'abarrotes',  60.00, 25);

INSERT INTO ventas(cliente_id, producto_id, cantidad, fecha_venta)
VALUES
    (1, 1, 2, CURRENT_DATE),
    (2, 2, 1, CURRENT_DATE),
    (3, 3, 3, CURRENT_DATE),
    (4, 4, 1, CURRENT_DATE),
    (5, 5, 2, CURRENT_DATE);

COMMIT;


-- =====================================================
-- 5. ACTUALIZACIÓN MASIVA DE PRECIOS
-- Incrementar 10 % a los productos de la categoria Limpieza 
-- =====================================================


UPDATE productos
SET precio = precio * 1.10
WHERE categoria = 'limpieza';


-- =====================================================
-- 6. ELIMINAR REGISTRO DE PRUEBA
-- =====================================================


DELETE FROM ventas 
WHERE venta_id = 5;



