import 'package:cinemelody/home_screen.dart';
import 'package:flutter/material.dart';
import 'like.dart';
import 'home.dart';

defaultImageUrl() {
  return 'https://upload.wikimedia.org/wikipedia/pt/6/62/How_to_Train_Your_Dragon_%28filme%29_Poster.jpg';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SearchMoviesScreen(),
    );
  }
}

class SearchMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Verifica o tamanho da tela para a responsividade
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 4; // 2 colunas em telas pequenas, 4 em telas grandes

    // Função de navegação
    void _navigateTo(int index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()), // Navega para a HomeScreen
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LikedSongsScreen()), // Navega para a tela de favoritos
          );
          break;
        default:
          break;
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(63, 94, 150, 1), 
              Color.fromRGBO(20, 30, 48, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF1B263B),
                  hintText: 'Pesquise seu filme',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: GestureDetector(
                      onTap: () {
                        // Ação ao tocar na imagem
                        print('Imagem $index clicada');
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.network(
                          defaultImageUrl(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: Icon(
                                Icons.error,
                                color: Colors.white,
                                size: 50,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1B263B),
        currentIndex: 1, // A aba de "Buscar" será selecionada
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white54,
        onTap: _navigateTo,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
