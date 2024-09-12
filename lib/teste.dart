import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca CEP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cepController = TextEditingController();
  String _logradouro = '';
  String _bairro = '';
  String _cidade = '';
  String _estado = '';
  String _erro = '';

  Future<void> buscarCep(String cep) async {
    final String url = 'https://viacep.com.br/ws/$cep/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> dados = json.decode(response.body);

        if (dados.containsKey('erro') && dados['erro'] == true) {
          setState(() {
            _erro = 'CEP não encontrado';
            _logradouro = '';
            _bairro = '';
            _cidade = '';
            _estado = '';
          });
        } else {
          setState(() {
            _erro = '';
            _logradouro = dados['logradouro'] ?? 'Não disponível';
            _bairro = dados['bairro'] ?? 'Não disponível';
            _cidade = dados['localidade'] ?? 'Não disponível';
            _estado = dados['uf'] ?? 'Não disponível';
          });
        }
      } else {
        setState(() {
          _erro = 'Erro ao buscar o CEP';
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro de conexão';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta de CEP'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://imgur.com/XKcr5vA.png'),
            fit: BoxFit.cover, // Ajusta a imagem para cobrir toda a tela
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _cepController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // Fundo branco semi-transparente
                    border: OutlineInputBorder(),
                    labelText: 'Digite o CEP',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    buscarCep(_cepController.text);
                  },
                  child: Text('Buscar'),
                ),
                SizedBox(height: 24),
                if (_erro.isNotEmpty)
                  Text(
                    _erro,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                if (_logradouro.isNotEmpty && _erro.isEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Logradouro: $_logradouro', style: TextStyle(fontSize: 16)),
                      Text('Bairro: $_bairro', style: TextStyle(fontSize: 16)),
                      Text('Cidade: $_cidade', style: TextStyle(fontSize: 16)),
                      Text('Estado: $_estado', style: TextStyle(fontSize: 16)),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
