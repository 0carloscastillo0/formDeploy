--- Crear la base de datos
CREATE DATABASE productos_db;
\c productos_db;

-- =============================
-- TABLAS MAESTRAS
-- =============================
-- Tabla: bodega
CREATE TABLE bodega (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla: Sucursal
CREATE TABLE sucursal (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    bodega_id INT NOT NULL REFERENCES bodega(id) ON DELETE CASCADE
);

--- Tabla: Moneda
CREATE TABLE moneda (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

--- Tabla principal: producto
CREATE TABLE producto (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    bodega_id INT NOT NULL REFERENCES bodega(id) ON DELETE RESTRICT,
    sucursal_id INT NOT NULL REFERENCES sucursal(id) ON DELETE RESTRICT,
    moneda_id INT NOT NULL REFERENCES moneda(id) ON DELETE RESTRICT,
    precio DECIMAL(10,2) NOT NULL,
    material VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);