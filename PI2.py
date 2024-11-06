#pip install flask 
#pip install mysql-connector-python

from flask import Flask, request, render_template, redirect, jsonify, session
import mysql.connector
import psycopg2

# A chave secreta é usada para assinar os cookies de sessão, garantindo que não possam ser falsificados ou manipulados por terceiros
PI2 = Flask(__name__)

#
PI2.secret_key = 'teste'

# Conexão com o banco de dados MySQL
conn = mysql.connector.connect(
	host="localhost",
    port=3306,
    user="root",
    password="admin",
    database="adestra"
)
cursor = conn.cursor()

# Rota para a página de inical
@PI2.route('/')
def pagina_inicial():
    return render_template('index.html')

# Rota para a página de Login
@PI2.route('/login')
def pagina_login():
    return render_template('login.html')

# Rota para a página de Cadastro
@PI2.route('/cadastro')
def pagina_cadastro():
    return render_template('cadastro.html')

# Rota para a página de Agenda
@PI2.route('/agenda')
def pagina_agenda():
    return render_template('agenda.html')

# Rota para a página de Adestramento
@PI2.route('/adestramento')
def pagina_adestramento():
    return render_template('adestramento.html')

# Rota para a página de Quem
@PI2.route('/quem')
def pagina_quem():
    return render_template('quem.html')



@PI2.route('/salvar-dados', methods=['POST'])
def salvar_dados():
    data = request.json
    Nome = data.get('Nome')
    Email = data.get('Email')
    Senha = data.get('Senha')
    Endereco = data.get('Endereco')
    Telefone = data.get('Telefone')
    Autoriza_imagem = data.get('Autoriza_imagem')

    dados = (Nome, Email, Senha, Endereco, Telefone, Autoriza_imagem)
    print(dados)
        
    cursor.execute("INSERT INTO Tutor (Nome, Email, Senha, Endereco, Telefone, Autoriza_imagem) VALUES (%s, %s, %s, %s, %s, %s)", 
        (Nome, Email, Senha, Endereco, Telefone, Autoriza_imagem))

    conn.commit()

# Obtém o último ID inserido (id do Tutor) e armazena na sessão
    tutor_id = cursor.lastrowid
    session['tutor_id'] = tutor_id
    print("ID do tutor na sessão:", session.get('tutor_id'))

    return render_template('cadastro.html')

@PI2.route('/salvar-animal', methods=['POST'])
def salvar_animal():
    print("Requisição para salvar animal recebida")  # Verifique se esta linha aparece
    data = request.json
    
    Nome = data.get('Nome')
    Raca = data.get('Raca')
    idade = data.get('idade')
    Sexo = data.get('Sexo')
    Castrado = data.get('Castrado')
    id_resp = session.get('tutor_id')
    print("ID do tutor:", id_resp)  # Debugging
   

    dados1 = (Nome, Raca, idade, Sexo, Castrado)
    print(dados1)

    # Obtém o último ID inserido (id do Tutor) e armazena na sessão
    print("ID do tutor na sessão:", session.get('tutor_id'))

    if id_resp:
        cursor.execute("INSERT INTO animal (Nome, Raca, idade, Sexo, Castrado, id_resp_animal) VALUES (%s, %s, %s, %s, %s, %s)", 
                        (Nome, Raca, idade, Sexo, Castrado, id_resp))
    
        conn.commit()    


        return jsonify({'mensagem': 'Animal cadastrado com sucesso!'}), 200

    else:
        return jsonify({'mensagem': 'Erro: Tutor não identificado'}), 400



# Rota para verificar as credenciais de login e redirecionar para home de acesso
@PI2.route('/verificar-login', methods=['POST'])
def verificar_login():
    data = request.json
    Email = data['Email']
    Senha = data['Senha']
    

    # Consulta SQL para verificar o login no banco de dados
    cursor.execute("SELECT * FROM Tutor WHERE Email = %s AND Senha = %s", (Email, Senha))
    responsavel = cursor.fetchone()
    print(responsavel)
    
    if responsavel:
        return jsonify({'redirect_url': '/cadastro'}), 200 
    else:
        return jsonify({'mensagem': 'Login inválido'}), 401
    


if __name__ == '__main__':
    PI2.run(debug=True)  