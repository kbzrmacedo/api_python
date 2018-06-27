import pyodbc
import json
from flask import Flask, jsonify

#Conexao com BD 
def connection():
    cnxn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                        "Server=DESKTOP-OUD2BTO;"
                        "Database=master;"
                        "Trusted_Connection=yes;")
    return cnxn
cursor = connection().cursor()
app = Flask(__name__)

#FUNCTION SELECT 
def Select(id_get):  
    if (id_get == None):
        query = "SELECT * FROM incidente"
        result = cursor.execute(query)
    else:
        query = "SELECT * FROM incidente WHERE id like ?"
        result = cursor.execute(query, id_get)
    items = []
    for row in result:
        items.append({
            'id': row[0], 
            'atendente': row[1],
            'cliente': row[2],
            'descricao': row[3],
            'status': row[4],
            'creation_time': str(row[5])
        })
    return items
#FUNCTION INSERT
def INSERT(atendente,cliente,descricao,status,creation_time):  
    query = "INSERT INTO incidente(atendente,cliente,descricao,status,creation_time) VALUES (?,?,?,?,?)"
    cursor.execute(query,atendente,cliente,descricao,status,creation_time)
    cursor.commit()
#FUNCTION DELETE
def DELETE(id_incidente):
    query = "DELETE FROM incidente WHERE id like ?"
    cursor.execute(query,id_incidente)
    cursor.commit()

# GET /incidente
@app.route('/incidente', methods=['GET'])
def incidente():
    try:
        id_get = None
        connection()
        get_incidente = json.dumps({'incidentes': Select(id_get) })
        return get_incidente
    except:
        return jsonify({'status': 404, 'mensagem': 'Chamado não encontrado!'})
    finally:
        connection().close()

# GET /incidente/1
@app.route('/incidente/<int:id_get>', methods=['GET'])
def incidentes(id_get):
    try:
        connection()
        get_incidente = json.dumps({'incidentes': Select(id_get) })
        return get_incidente
    except:
        return jsonify({'status': 404, 'mensagem': 'Chamado não encontrado!'})
    finally:
        connection().close()

# POST /incidente
@app.route('/incidente/<int:atendente>/<int:cliente>/<descricao>/<status>/<creation_time>', methods=['POST', 'GET'])
def novo_incidente(atendente,cliente,descricao,status,creation_time):
    try:
        connection()
        INSERT(atendente,cliente,descricao,status,creation_time)   
        return jsonify({'status': 200, 'mensagem': 'Chamado criado com sucesso!'})
    except:
        return jsonify({'status': 400, 'mensagem': 'Erro ao criar chamado!'})
    finally:
        connection().close()

# DELETE /incidente/
@app.route('/incidente/delete/<int:id_incidente>', methods=['DELETE','GET'])
def apagar_incidente(id_incidente):
    try:
        connection()
        DELETE(id_incidente)  
        return jsonify({'status': 200, 'mensagem': 'Chamado fechado com sucesso!'})
    except:
        return jsonify({'status': 404, 'mensagem': 'Erro ao deletar chamado, id não existe!'})
    finally:
        connection().close()

if __name__ == '__main__':
    app.run(debug=True)

