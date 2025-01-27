import 'package:flutter/material.dart';

void main() => runApp(MyGame());

class MyGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JogoDaVelha(),
    );
  }
}

class JogoDaVelha extends StatefulWidget {
  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<List<String>> _grade = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  String _jogadorAtual = 'X';
  String _textoInformativo = 'X, pode começar.';

  void _zerarJogo() {
    setState(() {
      _grade = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ];
      _jogadorAtual = 'X';
      _textoInformativo = 'X, pode começar.';
    });
  }

  void _jogar({required int linha, required int coluna}) {
    if (_grade[linha][coluna] == '') {
      setState(() {
        _grade[linha][coluna] = _jogadorAtual;
        if (_verificarVencedor(_jogadorAtual)) {
          _textoInformativo = '$_jogadorAtual, parabéns você venceu!';
        } else if (_verificarEmpate()) {
          _textoInformativo = 'Nossa! Parece que empatou.';
        } else {
          _jogadorAtual = _jogadorAtual == 'X' ? 'O' : 'X';
          _textoInformativo = '$_jogadorAtual, é sua vez!';
        }
      });
    }
  }

  bool _verificarVencedor(String jogador) {
    for (int i = 0; i < 3; i++) {
      if (_grade[i][0] == jogador && _grade[i][1] == jogador && _grade[i][2] == jogador) return true;
      if (_grade[0][i] == jogador && _grade[1][i] == jogador && _grade[2][i] == jogador) return true;
    }
    if (_grade[0][0] == jogador && _grade[1][1] == jogador && _grade[2][2] == jogador) return true;
    if (_grade[0][2] == jogador && _grade[1][1] == jogador && _grade[2][0] == jogador) return true;
    return false;
  }

  bool _verificarEmpate() {
    for (var linha in _grade) {
      for (var celula in linha) {
        if (celula == '') return false;
      }
    }
    return true;
  }

  Widget _criarBotao({required int linha, required int coluna}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(100, 100)
          ),
          onPressed: () => _jogar(linha: linha, coluna: coluna),
          child: Text(
            _grade[linha][coluna],
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jogo da Velha')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _textoInformativo,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(padding: const EdgeInsets.all(40.0)),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _criarBotao(linha: 0, coluna: 0),
                  _criarBotao(linha: 0, coluna: 1),
                  _criarBotao(linha: 0, coluna: 2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _criarBotao(linha: 1, coluna: 0),
                  _criarBotao(linha: 1, coluna: 1),
                  _criarBotao(linha: 1, coluna: 2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _criarBotao(linha: 2, coluna: 0),
                  _criarBotao(linha: 2, coluna: 1),
                  _criarBotao(linha: 2, coluna: 2),
                ],
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.all(10.0)),
          ElevatedButton(
            onPressed: _zerarJogo,
            child: Text('Reiniciar', style: TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );
  }
}
