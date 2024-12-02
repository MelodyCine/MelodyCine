import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtendo as dimensões da tela para responsividade
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600; // Verifica se é uma tela pequena

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(63, 94, 150, 1), 
              Color.fromRGBO(20, 30, 48, 1), 
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
                // Espaço para a logo
                Image.network(
                  'https://i.imgur.com/Yy4jB5X.png',
                  height: isSmallScreen ? 100 : 150, // Redimensiona a logo para telas menores
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                Text(
                  "Bem vindo de volta!",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 24, // Fonte adaptável
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto branco
                  ),
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                SizedBox(
                  width: isSmallScreen ? double.infinity : 400,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Seu email",
                      labelStyle: TextStyle(
                        color: Colors.black, // Melhor contraste para texto
                        fontSize: isSmallScreen ? 14 : 16, // Ajuste de fonte
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: isSmallScreen ? double.infinity : 400,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Sua senha",
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
                SizedBox(
                  width: isSmallScreen ? double.infinity : 400,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "ENTRAR",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(62, 94, 150, 1),
                      shadowColor: Colors.black.withOpacity(0.4),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 50 : 100,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 15),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Ainda não tenho uma conta",
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
