import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmailConfirmationScreen(email: 'usuario@email.com'), // Exemplo de email, substitua com o valor correto
    );
  }
}

class EmailConfirmationScreen extends StatelessWidget {
  final String email;

  EmailConfirmationScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2D3E50), // Cor azul escuro
              Color(0xFF546E7A), // Cor azul mais claro
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Espaço para a imagem de confirmação
                Image.network(
                  'https://i.imgur.com/oC53opI.png', // Substituir pela sua imagem local
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  "É necessário confirmar seu e-mail para ingressar na nossa comunidade",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto branco
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "O código foi enviado para o e-mail: $email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70, // Texto branco com opacidade
                  ),
                ),
                SizedBox(height: 20),
                // Campo para inserir o código de verificação
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Insira o código de verificação",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Botão de confirmar
                ElevatedButton(
                  onPressed: () {
                    // Ação para confirmar o código
                  },
                  child: Text(
                    "CONFIRMAR",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Texto branco
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1D83D4), // Cor de destaque (azul vibrante)
                    shadowColor: Colors.black.withOpacity(0.4), // Sombra leve
                    elevation: 8, // Destaque com sombra
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Borda arredondada
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Ação para reenviar o código
                  },
                  child: Text(
                    "Reenviar código",
                    style: TextStyle(color: Colors.white), // Texto branco
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
