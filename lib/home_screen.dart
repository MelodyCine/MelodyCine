import 'package:cinemelody/like.dart';
import 'package:cinemelody/search.dart';
import 'package:flutter/material.dart';
import 'package:cinemelody/models/movie.dart';
import 'package:cinemelody/widgets/movies_slider.dart';
import 'package:cinemelody/widgets/trending_slider.dart';
import 'api/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MelodyCine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Índice selecionado
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRateMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  // Função para navegação e alterar o índice
  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index; // Atualiza o índice selecionado
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchMoviesScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LikedSongsScreen()),
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
        title: const Text(
          'MELODYCINE',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF141E30),
              const Color(0xFF3F5E96),
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                const Text(
                  'Em alta',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: FutureBuilder(
                    future: trendingMovies,
                    builder: (context, snapshot) {
                      return TrendingSlider(snapshot: snapshot);
                    },
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Bem avaliados',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context, snapshot) {
                      return MovieSlider(snapshot: snapshot);
                    },
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Recentes',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: FutureBuilder(
                    future: upcomingMovies,
                    builder: (context, snapshot) {
                      return MovieSlider(snapshot: snapshot);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1B263B),
        currentIndex: _selectedIndex,  // Definindo o índice atual
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white54,
        onTap: _navigateTo, // Ação de navegação
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
