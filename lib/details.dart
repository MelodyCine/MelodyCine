import 'package:cinemelody/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:cinemelody/constants.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Center(
                child: Image.network(
                  Constants.imagePath + movie.backdropPath, 
                  height: 200,      
                  fit: BoxFit.cover, 
                ),
              ),
              SizedBox(height: 20),
              
              Text(
                movie.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              
              Text(
                movie.overview,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              
              Text(
                'Ano de lançamento: ${movie.releaseDate}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              
              Text(
                'votos: ${movie.voteAverage}',
                style: TextStyle(fontSize: 16),
              ),

              Text(
                'Trilha sonora:',
                style: TextStyle(fontSize: 16),
              ),

            ],
          ),
        ),
      ),
    );
  }
}