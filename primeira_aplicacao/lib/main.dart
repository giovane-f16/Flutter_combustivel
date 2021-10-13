//import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

// Criar uma classe que leva o nome da aplicação (nome de execução)
// A flutter utiliza dois tipos de comportamentos para objetos:
// 1. Stateful - responde à alterações e variações
// 2. Stateless - sem comportamento
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// Dentro desta classe ocorrem as operações da aplicação
class _HomeState extends State<Home> {
  // Vamos implementar nossos widgets (componentes)
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();

  // Variável para controlar o formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variável que receberá o resultado do cálculo, em modo texto.
  String _resultado = '';

  // Vamos criar os métodos de: reset e calcular
  void _calcularCombustivel() {
    // Muda o estado das variáveis
    setState(() {
      double va = double.parse(alcoolController.text.replaceAll(',', '.'));
      double vg = double.parse(gasolinaController.text.replaceAll(',', '.'));
      double proporcao = (va / vg);

      _resultado =
          (proporcao < 0.7 ? 'Abasteça com Álcool' : 'Abasteça com Gasolina');
    });
  }

  // Criar como atividade o 'reset'
  // Descobrir qual função usar para limpar todo o programa
  void _resetTela() {
    setState(() {
      alcoolController.text = '';
      gasolinaController.text = '';
      _resultado = '';
    });
  }

  // Método que constrói a interface gráfica da aplicação
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Álcool ou Gasolina',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.red[900],
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _resetTela();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        // Vamos criar o corpo do App
        body: SingleChildScrollView(
          // Exercício: Criar um Edge de cada um
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              // reserva um espaço para armazenar os campos
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Vamos colocar um ícone de bomba de gasolina
                Icon(
                  //Icons.account_circle,
                  Icons.local_gas_station,
                  size: 50.0,
                  color: Colors.red[900],
                ),
                // Construir os campos do formulário
                // Campo álcool
                TextFormField(
                  controller: alcoolController,
                  textAlign: TextAlign.center,
                  // Vamos incrementar o treco com uma animação
                  decoration: InputDecoration(
                      labelText: 'Valor do álcool',
                      border: OutlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Colors.red[900], fontSize: 20.00)),
                ),

                //Comando para dar espaço entre os campos de texto
                SizedBox(height: 15),
                // Campo Gasolina
                TextFormField(
                  controller: gasolinaController,
                  textAlign: TextAlign.center,
                  // para digitar somentes valores numéricos keyboardType: TextInputType.number
                  decoration: InputDecoration(
                      labelText: 'Valor da gasolina',
                      border: OutlineInputBorder(),
                      labelStyle:
                          TextStyle(color: Colors.red[900], fontSize: 20.00)),
                ),

                // Vamos criar o botão para calcular
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 5),
                  child: Container(
                    height: 50,
                    child: RawMaterialButton(
                      // aqui vai calcular os paranauê
                      onPressed: () {
                        _calcularCombustivel();
                      },
                      child: Text(
                        'Verificar',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      fillColor: Colors.red[900],
                    ),
                  ),
                ),

                // Teste para criar botão Reset
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 50),
                  child: Container(
                    height: 50,
                    child: RawMaterialButton(
                      onPressed: () {
                        _resetTela();
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      fillColor: Colors.red[900],
                    ),
                  ),
                ),
                Text(
                  _resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red[900], fontSize: 30),
                ),
              ],
            ),
          ),
        ));
  }
}
