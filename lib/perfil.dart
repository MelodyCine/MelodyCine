import 'package:cinemelody/home_screen.dart';
import 'package:cinemelody/like.dart';
import 'package:cinemelody/search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa o SharedPreferences

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;
  TextEditingController _nameController = TextEditingController();
  bool _isEditing = false; // Verifica se está no modo de edição
  String _userName = 'Marquinhos'; // Nome exibido inicialmente

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Carrega o nome do usuário ao iniciar a tela
  }

  // Função para carregar o nome salvo do SharedPreferences
  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Marquinhos'; // Valor padrão 'Marquinhos' caso não haja nome salvo
    });
  }

  // Função para salvar o nome no SharedPreferences
  Future<void> _saveUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', _userName); // Salva o nome
  }

  // Função para navegar para as telas apropriadas
  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });

    final route = index == 0
        ? HomeScreen()
        : index == 1
            ? SearchMoviesScreen()
            : LikedSongsScreen();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => route),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF141E30),
      appBar: AppBar(
        title: const Text('Perfil', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(63, 94, 150, 1),
                    Color.fromRGBO(20, 30, 48, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: isSmallScreen ? 50 : 80,
                      backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2019/05/08/21/21/cat-4189697_1280.jpg',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isEditing
                            ? SizedBox(
                                width: isSmallScreen ? 150 : 250,
                                child: TextField(
                                  controller: _nameController,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 18 : 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Digite seu nome',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.2),
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      _userName = text;
                                    });
                                  },
                                  autofocus: true, // Garante que o campo receba foco
                                  cursorColor: Colors.white, // Cursor branco
                                ),
                              )
                            : Text(
                                _userName,  // Exibe o nome atualizado
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isSmallScreen ? 18 : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _isEditing = !_isEditing;
                              if (!_isEditing) {
                                // Salva o nome quando terminar a edição
                                print("Nome salvo: ${_nameController.text}");
                                _userName = _nameController.text; // Atualiza o nome exibido
                                _saveUserName(); // Salva o nome no SharedPreferences
                              } else {
                                // Caso entre em modo de edição, coloca o nome no controller
                                _nameController.text = _userName;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatistic('Fixadas', '15'),
                        _buildStatistic('Curtidas', '3'),
                        _buildStatistic('Escutadas', '100'),
                      ],
                    ),
                    const Divider(color: Colors.white54, height: 40),
                    _buildInfoRow('Email:', 'Joãozinho@gmail.com'),
                    _buildInfoRow('Idioma:', 'Português (Brasil)'),
                    _buildInfoRow('Plano:', 'Free'),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'FQA',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Remover conta',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1B263B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        onTap: _navigateTo,
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

  Widget _buildStatistic(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
