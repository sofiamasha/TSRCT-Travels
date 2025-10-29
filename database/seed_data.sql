-- Arquivo: database_setup/03_seed_data.sql

USE travels_db;

-- Inserindo um usuário de teste (IMPORTANTE: A senha "123456" DEVE ser trocada por um HASH na aplicação real!)
INSERT INTO users (username, email, password_hash) VALUES
('dev_tester', 'teste@tsrct.com', '$2a$10$aBcDeFgHiJkLmNoPqRsTuVwXyZ1234567890abcdefghijklmnoPqRsTuVwXyZ12'); -- Placeholder de hash

-- Assumindo que o user_id do 'dev_tester' gerado seja 1
SET @test_user_id = LAST_INSERT_ID(); -- Captura o ID gerado (pode não funcionar em todos os SQL clients, mas é um bom intento)

-- Criando a Carteira para o usuário de teste (usando 1 como ID fixo para simplificar o seed)
INSERT INTO wallets (user_id, current_points) VALUES
(1, 124580); -- Usando o valor da sua tela Figma como exemplo inicial

-- Criando um Histórico Simples
INSERT INTO point_history (user_id, amount, type, description) VALUES
(1, 100000, 'bonus', 'Bônus de boas-vindas.'),
(1, -50, 'purchase', 'Tentativa de resgate de cupom.');

-- Criando uma Viagem de Exemplo
INSERT INTO trips (user_id, destination_country, destination_city, start_date, status) VALUES
(1, 'França', 'Paris', '2026-05-10', 'planning');

-- Comentário: Usei 'LAST_INSERT_ID()' e o ID fixo '1' como um jeito simples de ligar os dados. Em um projeto real, você faria isso via código da aplicação (backend).