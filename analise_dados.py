print(">>> Iniciando extração de dados do Projeto Automotivo...")

import psycopg2

print(">>> Iniciando extração de dados do Projeto Automotivo...")

# Configurações
dados_banco = {
    "host": "localhost",
    "database": "postgres",
    "user": "postgres",
    "password": "Manu5689"
}

try:
    conexao = psycopg2.connect(**dados_banco)
    cursor = conexao.cursor()

    # Buscando os dados
    cursor.execute("""
                   SELECT m.nome, c.modelo
                   FROM membros m
                   JOIN carros c ON m.id = c.membro_id
                   """)
    linhas = cursor.fetchall()

    print("-" * 40)
    for l in linhas:
        print(f"Participante: {l[0]} | Veiculo: {l[1]}")
    print("-" * 40)
    print(f"Total: {len(linhas)} registros encontrados.")

    cursor.close()
    conexao.close()

except Exception as erro:
    print(f"Erro ao conectar: {erro}")