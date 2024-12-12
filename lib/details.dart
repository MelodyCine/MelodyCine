import 'package:flutter/material.dart';
import 'package:cinemelody/models/movie.dart';
import 'package:cinemelody/constants.dart';
import 'package:cinemelody/widgets/movies_slider.dart';
import 'package:cinemelody/api/api.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? geminiResult;

  @override
  void initState() {
    super.initState();
    _fetchGeminiResult();
  }

  // Função para abrir URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  // Função para formatar a data no formato pt-BR
  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  // Função para buscar o resultado do Gemini
  Future<void> _fetchGeminiResult() async {
    try {
      final result = await Gemini.instance.prompt(parts: [
        Part.text(
            'Você é um especialista em trilhas sonoras de filmes, com vasto conhecimento sobre músicas de filmes. Seu objetivo é fornecer uma lista detalhada e precisa das músicas presentes no filme: ${widget.movie.title}. Siga estas diretrizes para garantir respostas de alta qualidade: 1. Nunca afirme que não conhece a trilha sonora, que ela não existe ou que o filme não existe. Caso haja algum problema em encontrar informações, forneça uma resposta educada e construtiva. 2. Sempre forneça a resposta no formato de uma lista clara e bem organizada, destacando as músicas presentes no filme. Organize as músicas por ordem de aparecimento, se possível, ou agrupe-as por temas importantes do filme. 3. Inclua, sempre que possível, o nome dos autores ou artistas das músicas. Se as músicas forem originais, mencione o compositor da trilha sonora. Caso a música seja de um artista ou banda, forneça o nome completo e o título da canção. 4. Se houver músicas instrumentais ou partes de trilhas sonoras que se destacam, indique também. Comente brevemente sobre o contexto ou a cena em que a música aparece, caso isso seja relevante para o entendimento do usuário. 5. Apresente a resposta de forma clara, envolvente e educativa, oferecendo um valor real para o usuário. Além de listar as músicas, procure dar informações adicionais interessantes sobre a trilha sonora, como a escolha de estilo musical, influências ou curiosidades. Por exemplo: Música 1: "Tema de Aventura" – Composta por John Williams, tocada durante a cena de abertura quando o herói começa sua jornada. Música 2: "Love Theme" – Canção original de Enya, tocada na cena romântica no final do filme. Nunca redirecione o usuario para outros lugares. Nunca diga que o filme ainda não foi lançado/anunciado ')
      ]);
      setState(() {
        // Remove os asteriscos e substitui por texto limpo
        geminiResult = result?.output?.replaceAll('**', '');
        geminiResult = result?.output?.replaceAll('*', '');
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        geminiResult = 'Erro ao buscar resposta';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<Movie>> recommendedMovies = Api().getTopRateMovies();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1B263B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF141E30),
              Color(0xFF3F5E96),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      Constants.imagePath + widget.movie.backdropPath,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    widget.movie.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.movie.overview,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ano de lançamento: ${formatDate(widget.movie.releaseDate)}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Votos: ${widget.movie.voteAverage}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Trilha sonora',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      '(busca feita por IA)',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: geminiResult == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          geminiResult ?? 'Erro ao carregar resultado.',
                          textAlign: TextAlign.justify, // Justifica o texto
                          style: const TextStyle(
                            fontFamily: 'Poppins', // Fonte Poppins
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Ouvir trilha sonora',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            _launchURL(
                                "https://open.spotify.com/search/trilha%20sonora%20filme:${widget.movie.title}");
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.spotify,
                            color: Colors.green,
                          ),
                        ),
                        const Text(
                          'Spotify',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            _launchURL(
                                "https://music.youtube.com/search?q=trilha%20sonora%20filme:${widget.movie.title}");
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.youtube,
                            color: Colors.red,
                          ),
                        ),
                        const Text(
                          'YouTube',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            _launchURL(
                                "https://music.apple.com/br/search?term=trilha%20sonora%20filme:${widget.movie.title}");
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.apple,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Apple Music',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Recomendações',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: FutureBuilder(
                    future: recommendedMovies,
                    builder: (context, snapshot) {
                      return MovieSlider(snapshot: snapshot);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
