import 'package:cinemelody/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:cinemelody/constants.dart';
import 'dart:convert';

class Api {
  static const trendingUrl =
      "https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apiKey}&language=pt-BR";

  static const topRatedUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}&language=pt-BR";

  static const upcomingUrl =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}&language=pt-BR";

  static const searchUrl = 'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}&language=pt-BR&query=';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;

      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('erro');
    }
  }

  Future<List<Movie>> getTopRateMovies() async {
    final response = await http.get(Uri.parse(topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;

      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('erro');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(upcomingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;

      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('erro');
    }
  }

  Future<List<Movie>> getSearchMovies(String name) async {
    final response = await http.get(Uri.parse('$searchUrl$name'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Erro ao buscar filmes');
    }
  }



}