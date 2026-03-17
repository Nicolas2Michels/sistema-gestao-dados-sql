# 🚀 Sistema de Gestão e Análise de Dados Automotivos (Python + SQL)

Este projeto demonstra a integração completa entre uma base de dados relacional (PostgreSQL) e scripts de automação em Python para geração de relatórios de eventos automotivos.

## 🛠️ Tecnologias Utilizadas
* **Python 3**: Lógica de extração e tratamento de dados.
* **PostgreSQL**: Armazenamento e estruturação dos dados (Membros, Veículos, Eventos).
* **Psycopg2**: Biblioteca de conexão entre a aplicação e o banco.
* **Dotenv**: Gestão de variáveis de ambiente e segurança de credenciais.

## 📊 Funcionalidades
* Modelagem de dados com relacionamentos (Foreign Keys).
* Script de extração que realiza `JOIN` complexos para correlacionar participantes e seus veículos.
* Relatório automatizado exibindo informações consolidadas direto do banco de dados.

## 📁 Estrutura do Projeto
* `script_sistema.sql`: Definição das tabelas e população inicial dos dados.
* `analise_dados.py`: Script Python responsável pela conexão e extração do relatório.
