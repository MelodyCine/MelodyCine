import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melody Cine',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSearching = false; // Estado para controlar a barra de busca
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              )
            : Text('Melody Cine', style: TextStyle(color: const Color.fromARGB(255, 250, 5, 5))),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.clear : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear(); // Limpa o campo de busca
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Ação de perfil
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF141E30), // Cor #141E30
              Color(0xFF3F5E96), // Cor #3F5E96
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            // Banner principal
            Stack(
              children: [
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://image.tmdb.org/t/p/original/6AGMPQ1iqTIhu51iBFpPd3G04L.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF141E30),
                        Color(0xFF3F5E96),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),


            // Lista horizontal (Carrossel de filmes) com legendas para "Lançamentos"
            buildMovieSection('Lançamentos', [
              {
                'image': 'https://image.tmdb.org/t/p/w500/nz36FLIt9ZYoj7gBfGkMaCiytHl.jpg',
                'title': 'Filme 1'
              },
              {
                'image': 'https://image.tmdb.org/t/p/w500/6agKYU5IQFpuDyUYPu39w7UCRrJ.jpg',
                'title': 'Filme 2'
              },
              {
                'image': 'https://image.tmdb.org/t/p/w500/qRyy2UmjC5ur9bDi3kpNNRCc5nc.jpg',
                'title': 'Filme 3'
              },
              {
                'image': 'https://image.tmdb.org/t/p/w500/zqkmTXzjkAgXmEWLRsY4UpTWCeo.jpg',
                'title': 'Filme 4'
              },
            ], showTitles: false),

            // Outra lista horizontal (Carrossel de séries) sem legendas
            buildMovieSection('cantores', [
              {
                'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpUwv6NTk2GK0kdFe4u343cJOK33PiXaYPpg&s',
                'title': 'tyler bates'
              },
              {
                'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTda1wakX_w0s0AcdNEAtmMGb1GdX-p6jRskw&s',
                'title': 'Joel j'
              },
              {
                'image': 'https://upload.wikimedia.org/wikipedia/commons/2/29/Marilyn_Manson_-_2018153011914_2018-06-01_Rock_am_Ring_-_1D_X_MK_II_-_1212_-_B70I1283_%28cropped%29.jpg',
                'title': 'marilyn manson'
              },
              {
                'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQyuEo_T-2hWz5gTMAFnxBUcBn0VxZXD_alA&s '
                ,'title':'rascal flatts'
              },
              
            ], showTitles: true),
            buildMovieSection('favoritos', [
              {
                'image': 'https://image.tmdb.org/t/p/w500/7GmQKKM9Q0FnDI9ZAdl3sZnSr8y.jpg',
                'title': 'Série 1'
              },
              {
                'image': 'https://image.tmdb.org/t/p/w500/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg',
                'title': 'Série 2'
              },
              {
                'image': 'https://image.tmdb.org/t/p/w500/gJ8VX6JSu3ciXHuC2dDGAo2lvwM.jpg',
                'title': 'Série 3'
              },
              {
                'image': 'https://image.tmdb.org/t/p/w500/vlTYk85LynKfRhOqEjS0bBCHszI.jpg',
                'title': 'Série 4'
              },
            ], showTitles: false),

          ],
        ),
      ),
    );
  }

  // Função para construir uma seção de filmes/séries com opção de mostrar legendas
  Widget buildMovieSection(String title, List<Map<String, String>> movies, {bool showTitles = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: showTitles ? 240 : 200, // Altura ajustada conforme há legendas ou não
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0), // Bordas arredondadas
                        child: Container(
                          width: 120, // Largura do retângulo
                          height: 160, // Altura do retângulo (imagem)
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(movies[index]['image']!),
                              fit: BoxFit.cover, // Faz a imagem preencher o retângulo
                            ),
                          ),
                        ),
                      ),
                      
                      if (showTitles) // Se a variável 'showTitles' for verdadeira, exibe o título
                        SizedBox(height: 8), // Espaço entre a imagem e o texto
                      if (showTitles) // Condição para exibir o título
                        Text(
                          movies[index]['title']!, // Nome do filme/série
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis, // Se o texto for longo, mostra "..."
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

