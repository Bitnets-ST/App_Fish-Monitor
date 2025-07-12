-- Crear las tablas necesarias para el sistema de monitoreo de peces

-- Tabla de Centrales
CREATE TABLE centrales (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    color VARCHAR(7) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Salas
CREATE TABLE salas (
    id SERIAL PRIMARY KEY,
    central_id INTEGER REFERENCES centrales(id) ON DELETE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Estanques
CREATE TABLE estanques (
    id SERIAL PRIMARY KEY,
    sala_id INTEGER REFERENCES salas(id) ON DELETE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    temperatura DECIMAL(4,2),
    oxigeno DECIMAL(4,2),
    ph DECIMAL(4,2),
    estado VARCHAR(20) NOT NULL DEFAULT 'good',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL DEFAULT 'user',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Registros de Monitoreo
CREATE TABLE registros_monitoreo (
    id SERIAL PRIMARY KEY,
    estanque_id INTEGER REFERENCES estanques(id) ON DELETE CASCADE,
    temperatura DECIMAL(4,2),
    oxigeno DECIMAL(4,2),
    ph DECIMAL(4,2),
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insertar datos de ejemplo para Centrales
INSERT INTO centrales (nombre, color) VALUES
    ('Copihue', '#00B4D8'),
    ('Calabozo', '#0077B6'),
    ('Trainel', '#0096C7');

-- Insertar datos de ejemplo para Salas
INSERT INTO salas (central_id, nombre, estado) VALUES
    (1, 'Sala 1', 'active'),
    (1, 'Sala 2', 'active'),
    (2, 'Sala A', 'active'),
    (2, 'Sala B', 'active'),
    (3, 'Sala Norte', 'active'),
    (3, 'Sala Sur', 'active');

-- Insertar datos de ejemplo para Estanques
INSERT INTO estanques (sala_id, nombre, temperatura, oxigeno, ph, estado) VALUES
    (1, 'Estanque 1', 22.5, 7.2, 6.8, 'good'),
    (1, 'Estanque 2', 23.1, 6.8, 7.1, 'warning'),
    (1, 'Estanque 3', 22.8, 7.5, 7.0, 'good'); 