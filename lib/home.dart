import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melody Cine',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false, // Remover o banner de debug
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _allMovies = [
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy1Uk0KXU_qXelYN4LaieK4pdURaYO438mwQ&s',
      'title': 'Filme 1',
      'category': 'Vida de inseto'
    },
    {
      'image':
          'https://m.media-amazon.com/images/S/pv-target-images/aa61ae8fb015160d802c4d5cb4fe6858058ea76485c3498ed9ff431eee4fc83f.jpg',
      'title': 'Filme 2',
      'category': 'Lançamentos'
    },
    {
      'image':
          'https://upload.wikimedia.org/wikipedia/pt/7/7e/Carros_2_P%C3%B4ster.jpg',
      'title': 'Filme 3',
      'category': 'Lançamentos'
    },
    {
      'image':
          'https://image.tmdb.org/t/p/w500/zqkmTXzjkAgXmEWLRsY4UpTWCeo.jpg',
      'title': 'Filme 4',
      'category': 'Lançamentos'
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpUwv6NTk2GK0kdFe4u343cJOK33PiXaYPpg&s',
      'title': 'Tyler Bates',
      'category': 'Cantores'
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTda1wakX_w0s0AcdNEAtmMGb1GdX-p6jRskw&s',
      'title': 'Joel J',
      'category': 'Cantores'
    },
    {
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/2/29/Marilyn_Manson_-_2018153011914_2018-06-01_Rock_am_Ring_-_1D_X_MK_II_-_1212_-_B70I1283_%28cropped%29.jpg',
      'title': 'Marilyn Manson',
      'category': 'Cantores'
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQyuEo_T-2hWz5gTMAFnxBUcBn0VxZXD_alA&s',
      'title': 'Rascal Flatts',
      'category': 'Cantores'
    },
    {
      'image':
          'https://www.flipar.com.br/wp-content/uploads/2024/09/Screenshot_20240905_132108_Google.jpg',
      'title': 'Série 1',
      'category': 'Favoritos'
    },
    {
      'image':
          'https://www.sonypictures.com.br/sites/brazil/files/2021-11/KEY%20ART.JPG',
      'title': 'Série 2',
      'category': 'Favoritos'
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEAzvrs99EC5_MSCgjfYJzGAVMdW7k8SikcQ&s',
      'title': 'Série 3',
      'category': 'Favoritos'
    },
    {
      'image':
          'https://image.tmdb.org/t/p/w500/vlTYk85LynKfRhOqEjS0bBCHszI.jpg',
      'title': 'Série 4',
      'category': 'Favoritos'
    },
  ];

  List<Map<String, String>> _filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _filteredMovies = _allMovies;
    _searchController.addListener(_filterMovies);
  }

  void _filterMovies() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredMovies = _allMovies;
      } else {
        _filteredMovies = _allMovies
            .where((movie) => movie['title']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final lancamentos = _filteredMovies
        .where((movie) => movie['category'] == 'Lançamentos')
        .toList();
    final cantores = _filteredMovies
        .where((movie) => movie['category'] == 'Cantores')
        .toList();
    final favoritos = _filteredMovies
        .where((movie) => movie['category'] == 'Favoritos')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              )
            : const Text('Melody Cine', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF141E30), // Cor do fundo
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.clear : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF141E30),
              Color(0xFF3F5E96),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            if (lancamentos.isNotEmpty)
              buildMovieSection('Lançamentos', lancamentos, showTitles: true),
            if (cantores.isNotEmpty)
              buildMovieSection('Cantores', cantores, showTitles: true),
            if (favoritos.isNotEmpty)
              buildMovieSection('Favoritos', favoritos, showTitles: true),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF141E30),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Conta',
          ),
        ],
      ),
    );
  }

  Widget buildMovieSection(String title, List<Map<String, String>> movies,
      {bool showTitles = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: showTitles ? 240 : 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              movies[index]['image']!,
                              width: 120,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      if (showTitles)
                        const SizedBox(height: 8),
                      if (showTitles)
                        Text(
                          movies[index]['title']!,
                          style: const TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
