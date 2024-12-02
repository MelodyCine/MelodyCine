import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LikedSongsScreen(),
    );
  }
}

class LikedSongsScreen extends StatelessWidget {
  final List<Map<String, String>> songs = [
    {
      'title': 'Shallow',
      'year': '2018',
      'duration': '3:36',
      'imageUrl': 'https://p2.trrsf.com/image/fget/cf/940/0/images.terra.com/2016/03/04/6foto-1filmes-de-musicas.jpg',
    },
    {
      'title': 'Let It Go',
      'year': '2013',
      'duration': '3:44',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8K6Mh0CcP4F_sD4RFNDRbpiA3DMIavUjAvA&s',
    },
    {
      'title': 'A Whole New World',
      'year': '1992',
      'duration': '2:38',
      'imageUrl': 'https://p2.trrsf.com/image/fget/cf/940/0/images.terra.com/2016/03/04/6foto-1filmes-de-musicas.jpg',
    },
    {
      'title': 'Circle of Life',
      'year': '1994',
      'duration': '4:00',
      'imageUrl': 'https://p2.trrsf.com/image/fget/cf/940/0/images.terra.com/2016/03/04/6foto-1filmes-de-musicas.jpg',
    },
    {
      'title': 'Everything Is Awesome',
      'year': '2014',
      'duration': '2:32',
      'imageUrl': 'https://p2.trrsf.com/image/fget/cf/940/0/images.terra.com/2016/03/04/6foto-1filmes-de-musicas.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(63, 94, 150, 1),
              Color.fromRGBO(20, 30, 48, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Curtidas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF2B3A52),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              song['imageUrl']!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey,
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song['title']!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${song['year']} - ${song['duration']}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox (height: 4),
                                Text(
                                  '12 músicas',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              SizedBox(height: 16),
                              Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
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
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white54,
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