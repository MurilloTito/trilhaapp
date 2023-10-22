import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/models/viacep_model.dart';
import 'package:trilhaapp/repositories/via_cep_repository.dart';

class ConsultaCEPPage extends StatefulWidget {
  const ConsultaCEPPage({super.key});

  @override
  State<ConsultaCEPPage> createState() => ConsultaCEPPageState();
}

class ConsultaCEPPageState extends State<ConsultaCEPPage> {
  var cepController = TextEditingController(text: '');
  bool loading = false;
  ViaCEPModel viaCEPModel = ViaCEPModel();
  var viaCEPRepository = ViaCepRepository();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          const Center(child: Text('Consulta de CEP', style: TextStyle(fontSize: 22),)),
          TextField(controller: cepController,
          keyboardType: TextInputType.number,
          maxLength: 8,
          onChanged: (String value) async {
            // var cep = value.trim().replaceAll('-', '');
            var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
            print(cep);
            if (cep.length == 8) {
              setState(() {
                loading = true;
              });
              viaCEPModel = await viaCEPRepository.consultaCep(cep);
            }
            setState(() {
              loading = false;
            });
          },),
          const SizedBox(height: 50),
          Center(child: Text(viaCEPModel.logradouro ?? '', style: const TextStyle(fontSize: 22),)),
          Center(child: Text('${viaCEPModel.localidade ?? ''}-${viaCEPModel.uf ?? ''}', style: const TextStyle(fontSize: 22),)),
          if (loading) CircularProgressIndicator(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
        }),));
  }
}