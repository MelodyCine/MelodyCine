import 'package:cinemelody/models/movie.dart';
import 'package:flutter/material.dart';

import 'api/api.dart';
import 'package:cinemelody/widgets/movies_slider.dart';
import 'package:cinemelody/widgets/trending_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('MELODYCINE'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF141E30), // Cor superior
              Color(0xFF3F5E96), // Cor inferior
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
                      return TrendingSlider(
                        snapshot: snapshot,
                      );
                    },
                  ),
                ),

                // Primeira sessão
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
                      return MovieSlider(
                        snapshot: snapshot,
                      );
                    },
                  ),
                ),

                // Segunda sessão
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
                      return MovieSlider(
                        snapshot: snapshot,
                      );
                    },
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
