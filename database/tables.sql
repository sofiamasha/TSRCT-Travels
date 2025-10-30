USE travels_db;

-- Tabela 1: Usuários (A galera que vai usar o app)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash CHAR(60) NOT NULL, -- Guarda a senha, BEM criptografada.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela 2: Carteiras (Onde o saldo e os pontos ficam guardados)
CREATE TABLE wallets (
    wallet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE, -- Um usuário tem SOMENTE uma carteira.
    current_points INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Tabela 3: Histórico de Pontos (mostar que o saldo mudou)
CREATE TABLE point_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    amount INT NOT NULL, -- Positivo pra ganhar, negativo pra gastar, deu pra entender? se nao tiver saldo nao gasta
    type VARCHAR(50) NOT NULL, -- Ex: 'bonus'
    description TEXT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Tabela 4: Roteiros Principais (As viagens criadas, como eu fiz nessa tela do figma: 'Meu Dashboard de Viagens')
CREATE TABLE trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    destination_name VARCHAR(150) NOT NULL, -- EX: "Férias na Itália 2026"
    destination_city VARCHAR(100),
    start_date DATE,
    end_date DATE,
    trip_status ENUM('planning', 'active', 'completed') DEFAULT 'planning',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Tabela 5: Itens do Roteiro (Seu Roteiro Perfeito em 3 Passos')
CREATE TABLE trip_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    item_sequence INT NOT NULL, -- Garante a ordem
    item_title VARCHAR(150) NOT NULL,
    item_details TEXT,
    item_date DATETIME,
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE CASCADE
);

-- Tabela 6: Catálogo de Experiências (serve p guardar as opções que o usuário pode escolher ou reservar)
CREATE TABLE cultural_experiences (
    experience_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    estimated_cost_points INT DEFAULT 0 -- Quanto custa em pontos, se for o caso
);

-- Tabela 7: Histórico de Uso de Experiências (Quem usou oq)
CREATE TABLE experience_usage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    experience_id INT NOT NULL,
    trip_id INT, -- OPCIONAL: pode estar ligado a um roteiro específico
    usage_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (experience_id) REFERENCES cultural_experiences(experience_id) ON DELETE RESTRICT
);