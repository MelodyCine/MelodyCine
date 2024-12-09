import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Detalhes do Filme',
      debugShowCheckedModeBanner: false,
      home: MovieDetailScreen(),
    );
  }
}

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int? _currentPlayingIndex;

  final List<Map<String, String>> _musics = [
    {
      'title': 'Música 1',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'
    },
    {
      'title': 'Música 2',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'
    },
    {
      'title': 'Música 3',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3'
    },
  ];

  final List<Map<String, String>> _recommendations = [
    {
      'title': 'Filme Recomendado 1',
      'image':
          'https://m.media-amazon.com/images/S/pv-target-images/aa61ae8fb015160d802c4d5cb4fe6858058ea76485c3498ed9ff431eee4fc83f.jpg',
    },
    {
      'title': 'Filme Recomendado 2',
      'image':
          'https://upload.wikimedia.org/wikipedia/pt/7/7e/Carros_2_P%C3%B4ster.jpg',
    },
  ];

  final List<Map<String, String>> _artists = [
    {
      'name': 'Cantor 1',
      'image': 'https://example.com/artist1.jpg',
    },
    {
      'name': 'Cantor 2',
      'image': 'https://example.com/artist2.jpg',
    },
  ];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playMusic(int index) async {
    if (_isPlaying && _currentPlayingIndex == index) {
      await _audioPlayer.pause();
      setState(() => _isPlaying = false);
    } else {
      await _audioPlayer.play(UrlSource(_musics[index]['url']!));
      setState(() {
        _isPlaying = true;
        _currentPlayingIndex = index;
      });
    }
  }

  void _showMusicModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8, // 80% da tela
          decoration: const BoxDecoration(
            color: Color(0xFF0D1B2A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Todas músicas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _musics.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      title: Text(
                        _musics[index]['title']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          _isPlaying && _currentPlayingIndex == index
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () => _playMusic(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes do Filme',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B263B),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(63, 94, 150, 1),
              Color.fromRGBO(20, 30, 48, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy1Uk0KXU_qXelYN4LaieK4pdURaYO438mwQ&s',
                        width: 200,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Vida de Inseto',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Lançado em: 1998 | 20 músicas',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Principais',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _musics.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        _musics[index]['title']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          _isPlaying && _currentPlayingIndex == index
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () => _playMusic(index),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _showMusicModal(context),
                    child: const Text(
                      'Ver todas',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Cantores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _artists.map((artist) {
                    return Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(artist['image']!),
                          radius: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          artist['name']!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Recomendações',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _recommendations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.network(
                        _recommendations[index]['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        _recommendations[index]['title']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}