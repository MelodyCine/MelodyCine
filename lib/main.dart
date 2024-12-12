import 'package:cinemelody/app.dart';
import 'package:cinemelody/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const apiKey = Constants.apiChat;

void main() {
  Gemini.init(apiKey: apiKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MelodyCine',
      home: Scaffold(
        body: const App(),
      ),
    );
  }
}
