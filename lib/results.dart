import 'package:cinemelody/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:cinemelody/constants.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Resultado da busca: ${query}'),
      ),
    );
  }
}