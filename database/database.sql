-- Arquivo: database_setup/01_create_database.sql

-- Comando para criar nosso banco de dados principal
CREATE DATABASE IF NOT EXISTS travels_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Informa ao sistema que queremos usar este banco de dados agora
USE travels_db;

-- Comentário: Eu quis usar IF NOT EXISTS para não dar erro se eu rodar esse script de novo sem querer.