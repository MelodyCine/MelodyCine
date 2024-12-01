import 'package:flutter/material.dart';

void main() {
  runApp(MusicApp());
}

class MusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0D1B2A),
        scaffoldBackgroundColor: Color(0xFF0D1B2A),
      ),
      home: MusicScreen(),
    );
  }
}

class MusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Singers', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Top Image from the internet
          Container(
            height: 300, // Ajuste a altura conforme necessário
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://cdn-images.dzcdn.net/images/artist/5f64636f8d3ed7d1873de582c2363b8b/1900x1900-000000-80-0-0.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Corey Taylor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '2013 - 3 Músicas',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MusicTile(
                  title: 'Sweet Dreams',
                  artist: 'Tyler Bates',
                ),
                MusicTile(
                  title: 'The Beautiful People',
                  artist: 'Tyler Bates',
                ),
                MusicTile( title: 'Tainted Love',
                  artist: 'Tyler Bates',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1B263B),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: '',
          ),
        ],
      ),
    );
  }
}

class MusicTile extends StatelessWidget {
  final String title;
  final String artist;

  MusicTile({required this.title, required this.artist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.music_note, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        artist,
        style: TextStyle(color: Colors.white70),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}