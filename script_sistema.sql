/*******************************************************************************
  PROJETO: Sistema de Gestão de Eventos Automotivos
  AUTOR: Nicolas
  OBJETIVO: Demonstração de competências em SQL, Modelagem Relacional e 
            Lógica de Negócio aplicada.
  AMBIENTE: PostgreSQL no Kali Linux via DBeaver.
*******************************************************************************/

-- 1. DEFINIÇÃO DA ESTRUTURA (DDL)
-- Criamos tabelas normalizadas para evitar redundância de dados.

-- Tabela de membros: Armazena dados básicos dos participantes.
CREATE TABLE membros (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50) NOT NULL
);

-- Tabela de veículos: Relacionamento 1:N (Um membro pode ter um ou mais carros).
CREATE TABLE veiculos (
    id SERIAL PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    cor VARCHAR(30) NOT NULL,
    membro_id INTEGER REFERENCES membros(id) ON DELETE CASCADE
);

-- Tabela associativa de presença: Relacionamento N:N entre Membros e Eventos.
-- Aqui aplicamos a lógica financeira do projeto.
CREATE TABLE presenca_encontro (
    membro_id INTEGER REFERENCES membros(id),
    encontro_id INTEGER DEFAULT 1,
    tipo_ingresso VARCHAR(20), -- 'Individual' ou 'Casal'
    valor_pago DECIMAL(10,2),
    status_pagamento VARCHAR(20) DEFAULT 'Pendente',
    PRIMARY KEY (membro_id, encontro_id)
);

-- 2. POPULAÇÃO DE DADOS (DML) E REGRAS DE NEGÓCIO
-- Simulamos dados reais para validar o comportamento do sistema.

INSERT INTO membros (nome, cidade) VALUES 
('Gustavo "Guga" Rocha', 'Blumenau'),
('Rafael "Alemão" Schmidt', 'Indaial'),
('Dra. Camila Bittencourt', 'Gaspar'),
('Sgt. Douglas Meira', 'Pomerode'),
('Eng. Ricardo Oliveira', 'Timbó');

INSERT INTO veiculos (modelo, cor, membro_id) VALUES 
('Jetta GLI', 'Cinza Nardo', 1),
('Jetta TSI', 'Branco Candy', 2),
('Jetta Variant', 'Prata Reflex', 3),
('Jetta GLI', 'Preto Ninja', 4),
('Jetta TSI', 'Azul Silk', 5);

-- Automação Financeira:
-- Inserimos as presenças aplicando a regra: IDs Pares = Casal, IDs Ímpares = Individual.
-- Isso demonstra o uso de lógica condicional (CASE WHEN) dentro do banco de dados.
INSERT INTO presenca_encontro (membro_id, encontro_id, tipo_ingresso, valor_pago, status_pagamento)
SELECT 
    id, 
    1, 
    CASE WHEN id % 2 = 0 THEN 'Casal' ELSE 'Individual' END,
    CASE WHEN id % 2 = 0 THEN 45.00 ELSE 30.00 END,
    'Confirmado'
FROM membros;

-- 3. EXTRAÇÃO DE RESULTADOS (DQL)
-- Relatório consolidado usando JOINS múltiplos. 
-- Essencial para a gestão física no dia do evento e conferência de caixa.

SELECT 
    m.nome AS "Participante",
    m.cidade AS "Origem",
    v.modelo AS "Carro",
    v.cor AS "Pintura",
    p.tipo_ingresso AS "Ingresso",
    p.valor_pago AS "Arrecadação",
    p.status_pagamento AS "Situação"
FROM presenca_encontro p
JOIN membros m ON p.membro_id = m.id
JOIN veiculos v ON m.id = v.membro_id
ORDER BY p.valor_pago DESC, m.nome ASC;
