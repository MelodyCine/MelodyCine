import 'package:cinemelody/home_screen.dart';
import 'package:cinemelody/like.dart';
import 'package:cinemelody/search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isEditing = false;
  String _userName = 'MelodyCine';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'MelodyCine';
    });
  }

  Future<void> _saveUserName() async {
    if (_userName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O nome não pode estar vazio!')),
      );
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nome salvo com sucesso!')),
    );
  }

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });

    final route = index == 0
        ? HomeScreen()
        : index == 1
            ? SearchScreen()
            : LikedSongsScreen();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => route),
    );
  }

  void _showFeatureUnavailableAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Funcionalidade Indisponível',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        content: const Text(
          'Essa funcionalidade estará disponível na próxima versão do aplicativo. Fique atento às atualizações para aproveitar novos recursos.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "OK",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF141E30),
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
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
                child: Center(
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
                                    autofocus: true,
                                    cursorColor: Colors.white,
                                  ),
                                )
                              : Text(
                                  _userName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 18 : 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: Icon(
                              _isEditing ? Icons.save : Icons.edit,
                              color: Colors.white,
                            ),
                            tooltip: _isEditing ? 'Salvar nome' : 'Editar nome',
                            onPressed: () {
                              setState(() {
                                if (_isEditing) {
                                  _saveUserName();
                                } else {
                                  _nameController.text = _userName;
                                }
                                _isEditing = !_isEditing;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatistic('Fixadas', '999'),
                          _buildStatistic('Curtidas', '999'),
                          _buildStatistic('Escutadas', '999'),
                        ],
                      ),
                      const Divider(color: Colors.white54, height: 40),
                      _buildInfoRow('Email:', 'melodycine39@gmail.com'),
                      _buildInfoRow('Idioma:', 'Português (Brasil)'),
                      _buildInfoRow('Plano:', 'Free'),

                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Aviso',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              content: const Text(
                                'É necessário fazer login para remover uma conta!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                              actions: [
                                Center(
                                  child: TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _showFeatureUnavailableAlert,
                            child: Text(
                              'Cadastro',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          TextButton(
                            onPressed: _showFeatureUnavailableAlert,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
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
