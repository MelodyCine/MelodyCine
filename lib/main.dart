import 'package:flutter/material.dart';
import 'package:cinemelody/appBatman.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batman App',
      home: Scaffold(
        body: const BatmanScreen(),
      ),
    );
  }
}