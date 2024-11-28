import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Fundo de tela mais suave
        backgroundColor: Color(0xFF1A2631), 
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Curtidas",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    buildMusicItem(
                      imageUrl: 'https://path-to-image.jpg', // Exemplo de URL de imagem
                      title: 'Let It Go',
                      year: '2014',
                      duration: '2h 16m',
                    ),
                    buildMusicItem(
                      imageUrl: 'https://path-to-image.jpg', // Exemplo de URL de imagem
                      title: 'Life Is a Highway',
                      year: '2000',
                      duration: '2h 5m',
                    ),
                    buildMusicItem(
                      imageUrl: 'https://path-to-image.jpg', // Exemplo de URL de imagem
                      title: 'Vou Viver...',
                      year: '2020',
                      duration: '1h 50m',
                    ),
                    buildMusicItem(
                      imageUrl: 'https://path-to-image.jpg', // Exemplo de URL de imagem
                      title: 'My Heart Will...',
                      year: '1997',
                      duration: '2h 14m',
                    ),
                    buildMusicItem(
                      imageUrl: 'https://path-to-image.jpg', // Exemplo de URL de imagem
                      title: 'Hymn to the Sea',
                      year: '1997',
                      duration: '3h 16m',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Adicionando o BottomNavigationBar
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF141E30),
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Conta',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMusicItem({
    required String imageUrl,
    required String title,
    required String year,
    required String duration,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Color(0xFF3A3E6A), Color(0xFF1D2D4D)], // Gradiente suave e harmonioso
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 5), // Sombra para destacar o item
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(imageUrl, width: 70, height: 70, fit: BoxFit.cover),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text(
              '$year | $duration',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
