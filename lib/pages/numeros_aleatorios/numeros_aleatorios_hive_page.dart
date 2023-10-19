import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() {
    return NumerosAleatoriosPageState();
  }
}

class NumerosAleatoriosPageState extends State<NumerosAleatoriosHivePage> {

  int? quantidadeCliques = 0;
  int? numeroGerado;
  late Box boxNumerosAleatorios;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
       boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
    quantidadeCliques = boxNumerosAleatorios.get('quantidadeCliques') ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Hive'))),
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
          var random = Random();
          setState(() {
            numeroGerado = random.nextInt(1000);
            quantidadeCliques  = quantidadeCliques! + 1;
          });
          boxNumerosAleatorios.put('numeroGerado', numeroGerado);
          boxNumerosAleatorios.put('quantidadeCliques', quantidadeCliques);
        }),);
  }
}