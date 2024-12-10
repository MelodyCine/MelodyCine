import 'package:cinemelody/constants.dart';
import 'package:cinemelody/details.dart';
import 'package:cinemelody/home_screen.dart';
import 'package:cinemelody/like.dart';
import 'package:cinemelody/results.dart';
import 'package:flutter/material.dart';
import 'api/api.dart'; 
import 'models/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> searchedMovies;
  TextEditingController _controller = TextEditingController(); 
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies(); 
  }

  void _searchMovie() {
    String query = _controller.text;  
    print("Texto digitado: $query");  
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true;
      });
      // Navega para a ResultsScreen e passa o texto da pesquisa como parâmetro
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(query: query),
        ),
      );
    } else {
      setState(() {
        isSearching = false; 
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
         backgroundColor: const Color(0xFF1B263B),
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        isSearching = false;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Pesquise seu filme",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _searchMovie, 
              ),
            ],
          ),
          
        ),
        
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF141E30),
              Color(0xFF3F5E96),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<Movie>>(
            future: isSearching ? searchedMovies : trendingMovies, 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Erro: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Nenhum filme encontrado."));
              } else {
                final movies = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, 
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(movie: movies[index]),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          Constants.imagePath + movie.posterPath, 
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1B263B),
        currentIndex: 1,
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
