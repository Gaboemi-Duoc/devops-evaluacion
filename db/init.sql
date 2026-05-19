CREATE DATABASE IF NOT EXISTS tienda_perritos
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Use the database
USE tienda_perritos;

-- Create the VENTA table
CREATE TABLE IF NOT EXISTS VENTA (
    id_venta BIGINT AUTO_INCREMENT PRIMARY KEY,
    direccion_compra VARCHAR(255) NOT NULL,
    valor_compra INT NOT NULL,
    fecha_compra DATE NOT NULL,
    despacho_generado BOOLEAN DEFAULT FALSE NOT NULL
);

-- Create the DESPACHO table
CREATE TABLE IF NOT EXISTS DESPACHO (
    id_despacho BIGINT AUTO_INCREMENT PRIMARY KEY,
    fecha_despacho DATE,
    patente_camion VARCHAR(255),
    intento INT NOT NULL,
    id_compra BIGINT NOT NULL,
    direccion_compra VARCHAR(255),
    valor_compra BIGINT NOT NULL,
    despachado BOOLEAN DEFAULT FALSE
);

-- Insert sample data into VENTA
INSERT INTO VENTA (direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES ('Calle Principal 123, Santiago', 15000, '2024-01-15', FALSE);

INSERT INTO VENTA (direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES ('Avenida Siempre Viva 742, Springfield', 25000, '2024-01-20', TRUE);

INSERT INTO VENTA (direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES ('Calle Real 45, Ciudad de México', 32500, '2024-02-01', FALSE);

INSERT INTO VENTA (direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES ('Paseo de la Reforma 100, CDMX', 47800, '2024-02-10', TRUE);

INSERT INTO VENTA (direccion_compra, valor_compra, fecha_compra, despacho_generado) 
VALUES ('Calle 26 #12-34, Bogotá', 18990, '2024-02-15', FALSE);

-- Insert sample data into DESPACHO
-- Successful delivery on first attempt
INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES ('2024-01-16', 'AB123CD', 1, 2, 'Avenida Siempre Viva 742, Springfield', 25000, TRUE);

-- Failed first attempt, successful on second attempt
INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES ('2024-02-02', 'EF456GH', 1, 3, 'Calle Real 45, Ciudad de México', 32500, FALSE);

INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES ('2024-02-03', 'EF456GH', 2, 3, 'Calle Real 45, Ciudad de México', 32500, TRUE);

-- Successful delivery with pending despachado status
INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES ('2024-02-11', 'IJ789KL', 1, 4, 'Paseo de la Reforma 100, CDMX', 47800, TRUE);

-- Pending despacho (not yet delivered)
INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES (NULL, 'MN012OP', 1, 1, 'Calle Principal 123, Santiago', 15000, FALSE);

-- Multiple attempts on same delivery
INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES (NULL, 'PQ345RS', 1, 5, 'Calle 26 #12-34, Bogotá', 18990, FALSE);

INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES (NULL, 'PQ345RS', 2, 5, 'Calle 26 #12-34, Bogotá', 18990, FALSE);

-- Additional pending despachos
INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES ('2024-02-20', 'TU678VW', 1, 6, 'Calle Falsa 123, Lima', 42500, TRUE);

INSERT INTO DESPACHO (fecha_despacho, patente_camion, intento, id_compra, direccion_compra, valor_compra, despachado) 
VALUES (NULL, 'WX901YZ', 1, 7, 'Av. Libertador 456, Buenos Aires', 31200, FALSE);

-- Query to verify VENTA data
SELECT * FROM VENTA;

-- Query to verify DESPACHO data
SELECT * FROM DESPACHO;

-- Join query example: Show despachos with their related ventas info
SELECT 
    d.id_despacho,
    d.fecha_despacho,
    d.patente_camion,
    d.intento,
    d.despachado,
    v.fecha_compra,
    v.despacho_generado as venta_despacho_generado
FROM DESPACHO d
LEFT JOIN VENTA v ON d.id_compra = v.id_venta
ORDER BY d.id_despacho;