CREATE DATABASE IF NOT EXISTS tienda_perritos
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE tienda_perritos;

-- Create the VENTA table
CREATE TABLE VENTA (
    id_venta BIGINT PRIMARY KEY,
    direccion_compra VARCHAR(255) NOT NULL,
    valor_compra INT NOT NULL,
    fecha_compra DATE NOT NULL,
    despacho_generado BOOLEAN DEFAULT FALSE NOT NULL
);

-- Create a sequence for auto-generated IDs (for GenerationType.AUTO)
CREATE SEQUENCE venta_seq START WITH 1 INCREMENT BY 1;

-- Example insertions
INSERT INTO VENTA (id_venta, direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES (nextval('venta_seq'), 'Calle Principal 123, Santiago', 15000, '2024-01-15', FALSE);

INSERT INTO VENTA (id_venta, direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES (nextval('venta_seq'), 'Avenida Siempre Viva 742, Springfield', 25000, '2024-01-20', TRUE);

INSERT INTO VENTA (id_venta, direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES (nextval('venta_seq'), 'Calle Real 45, Ciudad de México', 32500, '2024-02-01', FALSE);

INSERT INTO VENTA (id_venta, direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES (nextval('venta_seq'), 'Paseo de la Reforma 100, CDMX', 47800, '2024-02-10', TRUE);

INSERT INTO VENTA (id_venta, direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES (nextval('venta_seq'), 'Calle 26 #12-34, Bogotá', 18990, '2024-02-15', FALSE);

-- Query to verify the data
SELECT * FROM VENTA;