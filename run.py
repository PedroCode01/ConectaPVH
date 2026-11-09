from app import create_app

# Cria a instância da aplicação usando a fábrica (factory)
app = create_app()

if __name__ == '__main__':
    # Roda o servidor em modo de desenvolvimento na porta 5000
    app.run(debug=True, port=5000)