import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batman App',
      home: Scaffold(
        body: const BatmanScreen(),
      ),
    );
  }
}

class BatmanScreen extends StatelessWidget {
  const BatmanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagem de fundo com gradiente
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: Image.asset(
              'assets/batman.png', // Verifique se a imagem está na pasta correta
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Conteúdo principal (botões e texto)
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Botão "Entrar"
              ElevatedButton(
                onPressed: () {
                  // Ação do botão Entrar
                },
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Aumentando o peso da fonte
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Cor do botão "Entrar"
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Botão "Sair"
              ElevatedButton(
                onPressed: () {
                  // Ação do botão Sair (fechar o aplicativo)
                  Navigator.of(context).pop(); // Volta à tela anterior
                },
                child: const Text(
                  'Sair',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Aumentando o peso da fonte
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor do botão "Sair"
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Texto abaixo dos botões
              const Text(
                'Pesquise por filmes, séries ou assista trailers',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
