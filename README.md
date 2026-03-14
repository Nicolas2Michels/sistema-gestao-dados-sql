# 🚀 Sistema de Gestão de Dados Automotivos - SQL Case Study

### 📋 Visão Geral
Este repositório documenta o desenvolvimento de um ecossistema de dados completo, criado para gerenciar a operação, o controle de frota e a arrecadação financeira de um clube de entusiastas automotivos. 

O projeto foi desenvolvido do zero como parte da minha jornada de transição de carreira para a área de Tecnologia da Informação, aplicando conceitos práticos de **Engenharia de Dados** e **Administração de Bancos de Dados**.

---

### 🛠️ Arquitetura do Ambiente de Desenvolvimento
Diferente de simulações básicas, este projeto foi executado em um ambiente configurado para produtividade técnica:
* **Sistema Operacional:** Kali Linux (Configurado em **Dual Boot**).
* **Banco de Dados:** PostgreSQL 14+.
* **Ferramenta de Gestão (IDE):** DBeaver Community.

---

### 🧠 Desafios Técnicos e Soluções Implementadas

#### 1. Modelagem Relacional e Integridade
Estruturação de um esquema de banco de dados normalizado para evitar redundância. Implementação de relacionamentos **1:N** (Membros -> Veículos) e **N:N** (Membros -> Eventos), garantindo que o histórico de participações e pagamentos seja preservado de forma escalável.

#### 2. Data Cleaning e Tratamento (DML)
Desenvolvimento de scripts para identificação e remoção de registros duplicados e inconsistentes, assegurando que cada piloto esteja corretamente vinculado à sua respectiva máquina.

#### 3. Automação de Regras de Negócio
Utilização de lógica condicional (`CASE WHEN`) dentro do SQL para automatizar a precificação das inscrições. O sistema diferencia automaticamente valores de categorias (Individual vs Casal), reduzindo o erro humano no fechamento financeiro do evento.

#### 4. Extração de Insights e Relatórios
Criação de queries complexas com múltiplos **JOINS** para gerar listas de presença dinâmicas, permitindo o acompanhamento em tempo real da arrecadação e da logística de veículos por cidade de origem.

---

### 📊 Exemplo de Consulta Gerencial (Extração de Dados)

```sql
SELECT 
    m.nome AS "Participante",
    v.modelo AS "Carro",
    p.valor_pago AS "Arrecadação",
    p.status_pagamento AS "Situação"
FROM presenca_encontro p
JOIN membros m ON p.membro_id = m.id
JOIN veiculos v ON m.id = v.membro_id
ORDER BY p.valor_pago DESC;
