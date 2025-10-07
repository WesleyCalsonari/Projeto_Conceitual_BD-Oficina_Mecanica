-- Criação do banco de dados para o cenário da Oficina Mecânica

-- Cria o banco de dados
CREATE DATABASE IF NOT EXISTS oficina;

-- Utiliza o banco de dados
USE oficina;

-- Cria tabela pessoa
CREATE TABLE pessoa(
	idPessoa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    dataNasc DATE NOT NULL,
    sexo ENUM('Feminino', 'Masculino') NOT NULL
);

-- Cria tabela endereço
CREATE TABLE endereco(
	idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(45) NOT NULL,
    numero INT NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    CEP char(8) NOT NULL
);

-- Cria tabela clientes
CREATE TABLE clientes(
	idClientes INT AUTO_INCREMENT PRIMARY KEY,
    idCliEndereco INT,
    idCliPessoa INT,
    qtdOS INT DEFAULT 0,
    CONSTRAINT fk_clientes_endereco FOREIGN KEY (idCliEndereco) REFERENCES endereco(idEndereco) ON DELETE SET NULL,
    CONSTRAINT fk_clientes_pessoa FOREIGN KEY (idCliPessoa) REFERENCES pessoa(idPessoa) ON DELETE CASCADE
);

-- Cria tabela veiculo
CREATE TABLE veiculo(
	idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idVEIclientes INT,
    placa CHAR(7) NOT NULL,
    tipo ENUM('Moto', 'Carro', 'Ônibus', 'Caminhão') NOT NULL,
    modelo VARCHAR(15) NOT NULL,
    ano YEAR NOT NULL,
    CONSTRAINT unique_placa UNIQUE(placa),
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (idVEIclientes) REFERENCES clientes(idClientes)
);

-- Cria tabela lider
CREATE TABLE lider(
	idLider INT AUTO_INCREMENT PRIMARY KEY,
    QtdOSatendidas INT DEFAULT 0
);

-- Cria tabela equipe
CREATE TABLE equipe(
	idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    NomeEquipe VARCHAR(15) NOT NULL,
    QtdOSatendidas INT DEFAULT 0
);

-- Cria tabela mecanicos
CREATE TABLE mecanicos(
	idMecanicos INT AUTO_INCREMENT PRIMARY KEY,
    idMECendereco INT,
    idMECpessoa INT,
    idMECequipe INT,
    especialidade VARCHAR(15) NOT NULL,
    lider BOOL DEFAULT FALSE,
    CONSTRAINT fk_mecanicos_endereco FOREIGN KEY (idMECendereco) REFERENCES endereco(idEndereco),
    CONSTRAINT fk_mecanicos_pessoa FOREIGN KEY (idMECpessoa) REFERENCES pessoa(idPessoa),
    CONSTRAINT fk_mecanicos_equipe FOREIGN KEY (idMECequipe) REFERENCES equipe(idEquipe)
);

-- Cria tabela equipe_veiculo
CREATE TABLE equipe_veiculo(
	idEVequipe INT,
    idEVveiculo INT,
    PRIMARY KEY (idEVequipe, idEVveiculo),
    CONSTRAINT fk_equipe_veiculo_equipe FOREIGN KEY (idEVequipe) REFERENCES equipe(idEquipe),
    CONSTRAINT fk_equipe_veiculo_veiculo FOREIGN KEY (idEVveiculo) REFERENCES veiculo(idVeiculo)
);

-- cria tabela mão de obra valores
CREATE TABLE mao_de_obra_valores(
	idMOvalores INT AUTO_INCREMENT PRIMARY KEY,
    servico VARCHAR(20) NOT NULL,
    valor DECIMAL(10,2) DEFAULT 0.00
);

-- cria tabela ordem de serviço
CREATE TABLE OS(
	idOS INT AUTO_INCREMENT PRIMARY KEY,
    idOSmobravalor INT,
    numOS INT NOT NULL,
    dataEmissao DATE NOT NULL,
    statusOS ENUM('Em andamento', 'Finalizada', 'Cancelada') NOT NULL,
    dataConclusao DATE DEFAULT NULL,
    descServico VARCHAR(45),
    CONSTRAINT unique_numOS UNIQUE(numOS),
    CONSTRAINT fk_os_MOvalor FOREIGN KEY (idOSmobravalor) REFERENCES mao_de_obra_valores(idMOvalores)
);

-- cria tabela equipe_OS
CREATE TABLE equipe_OS(
	idEOSequipe INT,
    idEOSordemserv INT,
    OSaprovada BOOL DEFAULT FALSE,
    PRIMARY KEY (idEOSequipe, idEOSordemserv),
    CONSTRAINT fk_equipe_os_equipe FOREIGN KEY (idEOSequipe) REFERENCES equipe(idEquipe),
    CONSTRAINT fk_equipe_os_os FOREIGN KEY (idEOSordemserv) REFERENCES OS(idOS)
);

-- Cria Tabela pecas_valores
CREATE TABLE pecas_valores(
	idPecasValores INT AUTO_INCREMENT PRIMARY KEY,
    peca VARCHAR(15) NOT NULL,
    material VARCHAR(15) NOT NULL,
    PrecoCompra DECIMAL(10,2) NOT NULL,
    CustoCliente DECIMAL(10,2) NOT NULL
);

-- cria tabela mo_pecas
CREATE TABLE mo_pecas(
	idMOPmaoobra INT,
    idMOPpecas INT,
    PRIMARY KEY (idMOPmaoobra, idMOPpecas),
    CONSTRAINT fk_mo_pecas_mo FOREIGN KEY (idMOPmaoobra) REFERENCES mao_de_obra_valores(idMOvalores),
    CONSTRAINT fk_mo_pecas_pecas FOREIGN KEY (idMOPpecas) REFERENCES pecas_valores(idPecasValores)
);

-- Inserção de dados

-- Tabela pessoa
INSERT INTO pessoa (nome, dataNasc, sexo) VALUES
('Carlos Silva', '1985-04-12', 'Masculino'),
('Maria Souza', '1990-08-23', 'Feminino'),
('João Oliveira', '1978-02-15', 'Masculino'),
('Ana Costa', '1995-11-05', 'Feminino'),
('Ricardo Lima', '1983-07-22', 'Masculino'),
('Paula Mendes', '1992-09-10', 'Feminino'),
('Marcos Pereira', '1988-06-18', 'Masculino');

-- Tabela endereço
INSERT INTO endereco (rua, numero, bairro, cidade, CEP) VALUES
('Rua das Flores', 123, 'Centro', 'São Paulo', '01001000'),
('Av. Paulista', 987, 'Bela Vista', 'São Paulo', '01311000'),
('Rua das Acácias', 55, 'Jardins', 'São Paulo', '01415000'),
('Rua do Sol', 321, 'Pinheiros', 'São Paulo', '05422000'),
('Av. Brasil', 654, 'Moema', 'São Paulo', '04530000'),
('Rua XV de Novembro', 12, 'Centro', 'Campinas', '13010000'),
('Rua do Comércio', 101, 'Centro', 'Guarulhos', '07010000');

-- Tabela clientes
INSERT INTO clientes (idCliEndereco, idCliPessoa, qtdOS) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3);

-- Tabela veiculo
INSERT INTO veiculo (idVEIclientes, placa, tipo, modelo, ano) VALUES
(1, 'ABC1234', 'Carro', 'Civic', 2018),
(1, 'XYZ5678', 'Moto', 'CB500', 2021),
(2, 'JKL9101', 'Carro', 'Corolla', 2020),
(3, 'MNO3456', 'Caminhão', 'FH540', 2019);

-- Tabela lider
INSERT INTO lider (QtdOSatendidas) VALUES (5), (2);

-- Tabela equipe
INSERT INTO equipe (NomeEquipe, QtdOSatendidas) VALUES
('Equipe Alfa', 5),
('Equipe Beta', 3);

-- Tabela mecanicos
INSERT INTO mecanicos (idMECendereco, idMECpessoa, idMECequipe, especialidade, lider) VALUES
(4, 4, 1, 'Motor', TRUE),
(5, 5, 1, 'Suspensão', FALSE),
(6, 6, 2, 'Freios', TRUE),
(7, 7, 2, 'Elétrica', FALSE);

-- Tabela equipe_veiculo
INSERT INTO equipe_veiculo (idEVequipe, idEVveiculo) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4);

-- Tabela mao_de_obra_valores
INSERT INTO mao_de_obra_valores (servico, valor) VALUES
('Troca de óleo', 120.00),
('Alinhamento', 150.00),
('Revisão geral', 500.00),
('Troca de embreagem', 800.00);

-- Tabela OS
INSERT INTO OS (idOSmobravalor, numOS, dataEmissao, statusOS, dataConclusao, descServico) VALUES
(1, 1001, '2025-01-10', 'Finalizada', '2025-01-11', 'Troca de óleo realizada'),
(2, 1002, '2025-02-05', 'Finalizada', '2025-02-07', 'Alinhamento completo'),
(3, 1003, '2025-03-12', 'Em andamento', NULL, 'Revisão em execução'),
(4, 1004, '2025-04-01', 'Cancelada', NULL, 'Cliente desistiu do serviço');

-- Tabela equipe_OS
INSERT INTO equipe_OS (idEOSequipe, idEOSordemserv, OSaprovada) VALUES
(1, 1, TRUE),
(1, 2, TRUE),
(2, 3, FALSE),
(2, 4, FALSE);

-- Tabela pecas_valores
INSERT INTO pecas_valores (peca, material, PrecoCompra, CustoCliente) VALUES
('Filtro de óleo', 'Metal', 25.00, 50.00),
('Past. de freio', 'Cerâmica', 100.00, 180.00),
('Correia dentada', 'Borracha', 80.00, 150.00);

-- Tabela mo_pecas
INSERT INTO mo_pecas (idMOPmaoobra, idMOPpecas) VALUES
(1, 4),
(2, 5),
(3, 6);

-- Consultas SQL

-- Recuperações simples com SELECT
SELECT nome, sexo, dataNasc FROM pessoa;

-- Filtros com WHERE
SELECT nome, dataNasc as data_de_nascimento
FROM pessoa
WHERE sexo = 'Masculino' AND dataNasc < '1990-01-01';

-- Expressões derivadas
SELECT 
    nome,
    YEAR(CURDATE()) - YEAR(dataNasc) AS idade
FROM pessoa;

-- Ordenação com ORDER BY
SELECT modelo, tipo, ano
FROM veiculo
ORDER BY ano DESC;

-- Filtros em grupos com HAVING
SELECT idVEIclientes, COUNT(*) AS qtd_veiculos
FROM veiculo
GROUP BY idVEIclientes
HAVING COUNT(*) > 1;

-- Junções entre tabelas (JOINs)
SELECT 
    c.idClientes,
    p.nome AS cliente,
    v.modelo,
    v.placa,
    o.numOS,
    o.statusOS,
    m.servico,
    m.valor
FROM clientes c
JOIN pessoa p ON c.idCliPessoa = p.idPessoa
JOIN veiculo v ON v.idVEIclientes = c.idClientes
JOIN equipe_veiculo ev ON ev.idEVveiculo = v.idVeiculo
JOIN equipe_OS eos ON eos.idEOSequipe = ev.idEVequipe
JOIN OS o ON o.idOS = eos.idEOSordemserv
JOIN mao_de_obra_valores m ON m.idMOvalores = o.idOSmobravalor
ORDER BY p.nome;