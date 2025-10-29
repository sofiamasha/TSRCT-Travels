-- Arquivo: database_setup/02_create_tables.sql

USE travels_db;

-- Tabela 1: Usuários (Para Login)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash CHAR(60) NOT NULL, -- Para guardar o hash da senha
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela 2: Carteira/Pontos (Baseado na tela "Minha Travel Wallet")
CREATE TABLE wallets (
    wallet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    current_points INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Tabela 3: Viagens (Para guardar os roteiros criados)
CREATE TABLE trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    destination_city VARCHAR(100) NOT NULL,
    destination_country VARCHAR(100),
    start_date DATE,
    end_date DATE,
    status ENUM('planning', 'active', 'completed') DEFAULT 'planning',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Tabela 4: Histórico de Pontos (Para rastrear as transações financeiras/pontos)
CREATE TABLE point_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    amount INT NOT NULL, -- Valor positivo para ganho, negativo para gasto
    type VARCHAR(50) NOT NULL, -- Ex: 'purchase', 'bonus', 'redeem'
    description TEXT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Comentário: A chave estrangeira (FOREIGN KEY) garante que, se um usuário for deletado, as coisas ligadas a ele (carteira, viagens) sejam removidas junto (ON DELETE CASCADE), o que é importante para manter a integridade.