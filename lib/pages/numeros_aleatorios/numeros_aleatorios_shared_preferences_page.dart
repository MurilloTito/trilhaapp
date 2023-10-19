import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencesPage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencesPage> createState() {
    return NumerosAleatoriosPageState();
  }
}

class NumerosAleatoriosPageState extends State<NumerosAleatoriosSharedPreferencesPage> {

  int? quantidadeCliques = 0;
  int? numeroGerado;
  final CHAVE_NUMERO_ALEATORIO = 'numero_aleatorio';
  final CHAVE_QUANTIDADE_CLIQUES = 'quantidade_cliques';
  late SharedPreferences storage;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO);
      quantidadeCliques = storage.getInt(CHAVE_QUANTIDADE_CLIQUES);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerador de números aleatórios')),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(numeroGerado == null ? '' : '$numeroGerado'),
          Text(quantidadeCliques == null ? '' : '$quantidadeCliques')
      ])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // final storage = await SharedPreferences.getInstance();
          // await storage.remove(CHAVE_NUMERO_ALEATORIO);
          SharedPreferences.setMockInitialValues({});
          var random = Random();
          setState(() {
            numeroGerado = random.nextInt(1000);
            quantidadeCliques  = quantidadeCliques! + 1;
          });
          storage.setInt(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
          storage.setInt(CHAVE_QUANTIDADE_CLIQUES, quantidadeCliques!);
        }),);
  }
}