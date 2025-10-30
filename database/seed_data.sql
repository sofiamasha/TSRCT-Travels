USE travels_db;

-- 1. Cria um usuário padrão (o ID dele será 1)
INSERT INTO users (username, email, password_hash) VALUES
('test_user', 'teste@email.com', '$2a$10$aBcDeFgHiJkLmNoPqRsTuVwXyZ0987654321fedcba1234567890'); 

-- 2. Cria a carteira dele, já com os pontos da tela inicial
INSERT INTO wallets (user_id, current_points) VALUES
(1, 124580); 

-- 3. Adiciona um histórico para justificar o saldo
INSERT INTO point_history (user_id, amount, type, description) VALUES
(1, 200000, 'acquisition', 'Pontos de Boas-Vindas e Promoção Inicial.'),
(1, -75420, 'purchase', 'Compra de Pacote Viagem Padrão.');

-- 4. Cria o Roteiro principal (Trip)
INSERT INTO trips (user_id, destination_name, destination_city, start_date, trip_status) VALUES
(1, 'Tour Paris Clássico', 'Paris', '2026-06-01', 'active');

-- 5. Detalha o Roteiro (Os 3 Passos do Figma - Seu roteiro pfto)
-- Como o trip_id(o "RG" de cada roteiro) gerado acima é 1(pq é o primeiro a ser criado no banco vazio), usamos ele aqui.
INSERT INTO trip_items (trip_id, item_sequence, item_title, item_details) VALUES
(1, 1, 'Chegada e Check-in', 'Chegar no aeroporto e ir direto para o hotel.'),
(1, 2, 'Almoço e Louvre', 'Visita guiada ao Museu do Louvre.'),
(1, 3, 'Passeio Noturno', 'Cruzeiro pelo Rio Sena.');

-- 6. Cadastra algumas experiências disponíveis no catálogo
INSERT INTO cultural_experiences (name, description, estimated_cost_points) VALUES
('Aula de Culinária Francesa', 'Aprenda a fazer croissants!', 1500),
('Visita ao Museu d\'Orsay', 'Arte impressionista incrível.', 800);
