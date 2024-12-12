import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmailConfirmationScreen(email: 'usuario@email.com'),
    );
  }
}

class EmailConfirmationScreen extends StatelessWidget {
  final String email;

  EmailConfirmationScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

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
                // Espaço para a imagem de confirmação
                Image.network(
                  'https://i.imgur.com/oC53opI.png',
                  height: isSmallScreen ? 100 : 150,
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                Text(
                  "É necessário confirmar seu e-mail para ingressar na nossa comunidade",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                Text(
                  "O código foi enviado para o e-mail: $email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),

                SizedBox(
                  width: isSmallScreen ? double.infinity : 400,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Insira o código de verificação",
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
                      "CONFIRMAR",
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
                    "Reenviar código",
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
