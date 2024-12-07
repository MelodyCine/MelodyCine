import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPasswordScreen(), // Tela de Esqueci a Senha
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600; // Detecta tela pequena

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(63, 94, 150, 1), // Cor azul escuro
              Color.fromRGBO(20, 30, 48, 1), // Cor azul mais claro
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Espaço para a imagem de recuperação de senha
                Image.network(
                  'https://i.imgur.com/pZ5d6j0.png', // Substitua pela sua imagem de esqueci a senha
                  height: isSmallScreen ? 100 : 150, // Redimensiona para telas menores
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                Text(
                  "Esqueci minha senha",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto branco
                  ),
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                Text(
                  "Digite seu e-mail para recuperar sua senha.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.white70, // Texto branco com opacidade
                  ),
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                // Campo de E-mail
                SizedBox(
                  width: isSmallScreen ? double.infinity : 400,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Seu e-mail",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                // Botão de Enviar
                SizedBox(
                  width: isSmallScreen ? double.infinity : 400, // Responsivo
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação para enviar o e-mail de recuperação
                    },
                    child: Text(
                      "ENVIAR E-MAIL DE RECUPERAÇÃO",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(62, 94, 150, 1),
                      shadowColor: Colors.black.withOpacity(0.4), // Sombra leve
                      elevation: 8, // Destaque com sombra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Borda arredondada
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 50 : 100, // Ajusta o padding horizontal
                        vertical: 15, // Padding vertical para mais altura
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 15),
                // Texto adicional (opcional)
                TextButton(
                  onPressed: () {
                    // Ação para voltar à tela de login
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Voltar para o login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
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
