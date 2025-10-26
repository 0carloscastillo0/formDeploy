-- =============================
-- INSERTAR DATOS EN TABLAS MAESTRAS
-- =============================

-- Bodegas
INSERT INTO bodega (nombre) VALUES
('Bodega 1'),
('Bodega 2'),
('Bodega 3'),
('Bodega 4'),
('Bodega 5')
ON CONFLICT (nombre) DO NOTHING;

-- Monedas
INSERT INTO moneda (nombre) VALUES
('DOLAR'),
('EURO'),
('PESO'),
('YEN'),
('LIBRA')
ON CONFLICT (nombre) DO NOTHING;

-- Sucursales
INSERT INTO sucursal (nombre, bodega_id) VALUES
('Sucursal 1', 1),
('Sucursal 2', 1),
('Sucursal 3', 1),
('Sucursal 4', 2),
('Sucursal 5', 2),
('Sucursal 6', 3),
('Sucursal 7', 3),
('Sucursal 8', 3),
('Sucursal 9', 4),
('Sucursal 10', 4),
('Sucursal 11', 5),
('Sucursal 12', 5),
('Sucursal 13', 5),
('Sucursal 14', 5),
('Sucursal 15', 5)
ON CONFLICT (nombre, bodega_id) DO NOTHING;

-- Productos
INSERT INTO producto (codigo, nombre, bodega_id, sucursal_id, moneda_id, precio, material, descripcion) VALUES
('PROD01K', 'Set Comedor', 1, 2, 1, 150.00, 'Madera,Vidrio', 'Elegante set de comedor de madera natural, incluye mesa y sillas. Diseño clásico y duradero, ideal para cualquier estilo de decoración. Perfecto para cenas familiares y reuniones sociales.')
ON CONFLICT (codigo) DO NOTHING;
