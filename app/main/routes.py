from flask import Blueprint, jsonify, request

main_bp = Blueprint('main', __name__)

oportunidades = [
    {
        "id": 1,
        "titulo": "Oficina Gratuita de Python",
        "categoria": "Educação",
        "bairro": "Centro",
        "gratuito": True
    },
    {
        "id": 2,
        "titulo": "Feira de Artesanato Local",
        "categoria": "Cultura",
        "bairro": "Aparecida",
        "gratuito": True
    }
]

# 1. READ (Listar todas as oportunidades) - Entrega B e C
@main_bp.route('/oportunidades', methods=['GET'])
def listar_oportunidades():
    return jsonify(oportunidades), 200

# 2. READ (Buscar por ID) - Entrega B e C
@main_bp.route('/oportunidades/<int:id>', methods=['GET'])
def buscar_oportunidade(id):
    oportunidade = next((op for op in oportunidades if op["id"] == id), None)
    if not oportunidade:
        return jsonify({"erro": "Oportunidade não encontrada"}), 404
    return jsonify(oportunidade), 200

# 3. CREATE (Criar uma nova oportunidade) - Entrega A, B e C
@main_bp.route('/oportunidades', methods=['POST'])
def criar_oportunidade():
    dados = request.get_json()
    
    nova_oportunidade = {
        "id": len(oportunidades) + 1,
        "titulo": dados.get("titulo"),
        "categoria": dados.get("categoria"),
        "bairro": dados.get("bairro"),
        "gratuito": dados.get("gratuito", True)
    }
    
    oportunidades.append(nova_oportunidade)
    return jsonify({
        "mensagem": "Oportunidade cadastrada com sucesso!",
        "oportunidade": nova_oportunidade
    }), 201

# 4. UPDATE (Atualizar uma oportunidade existente) - Entrega B e C
@main_bp.route('/oportunidades/<int:id>', methods=['PUT'])
def atualizar_oportunidade(id):
    oportunidade = next((op for op in oportunidades if op["id"] == id), None)
    if not oportunidade:
        return jsonify({"erro": "Oportunidade não encontrada"}), 404
        
    dados = request.get_json()
    oportunidade["titulo"] = dados.get("titulo", oportunidade["titulo"])
    oportunidade["categoria"] = dados.get("categoria", oportunidade["categoria"])
    oportunidade["bairro"] = dados.get("bairro", oportunidade["bairro"])
    oportunidade["gratuito"] = dados.get("gratuito", oportunidade["gratuito"])
    
    return jsonify({
        "mensagem": "Oportunidade atualizada com sucesso!",
        "oportunidade": oportunidade
    }), 200

# 5. DELETE (Remover uma oportunidade) - Entrega B e C
@main_bp.route('/oportunidades/<int:id>', methods=['DELETE'])
def deletar_oportunidade(id):
    global oportunidades
    oportunidade = next((op for op in oportunidades if op["id"] == id), None)
    if not oportunidade:
        return jsonify({"erro": "Oportunidade não encontrada"}), 404
        
    oportunidades = [op for op in oportunidades if op["id"] != id]
    return jsonify({"mensagem": "Oportunidade removida com sucesso!"}), 200