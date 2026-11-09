from flask import Flask

def create_app():
    # Inicializa a aplicação Flask
    app = Flask(__name__)

    # Importa e registra o Blueprint das rotas principais
    from app.main.routes import main_bp
    app.register_blueprint(main_bp)

    return app