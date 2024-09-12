import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BatmanScreen(),
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
              'assets/batman.png', // Caminho para a imagem local
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Conteúdo principal (botões e texto)
        Positioned(
          bottom: 20, // Ajuste a posição dos botões
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
                child: const Text('Entrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Cor do botão "Entrar"
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Botão "Sair"
              TextButton(
                onPressed: () {
                  // Ação do botão Sair
                },
                child: const Text('Sair', style: TextStyle(color: Colors.black)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Bordas arredondadas
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
