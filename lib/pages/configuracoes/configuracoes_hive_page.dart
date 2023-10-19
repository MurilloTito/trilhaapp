import 'package:flutter/material.dart';
import 'package:trilhaapp/repositories/configuracoes_repository.dart';

import '../../models/configuracoes_model.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(title: const Text('Configurações Hive'),),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Nome usuário'),
            controller: nomeUsuarioController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: alturaController,
          decoration: const InputDecoration(hintText: 'Altura'),),
        ),
        SwitchListTile(
          title: const Text('Receber push notifications'),
          value: configuracoesModel.receberPushNotification, onChanged: (bool value) {
          setState(() {
            configuracoesModel.receberPushNotification = !configuracoesModel.receberPushNotification;
          });
        }),
        SwitchListTile(
          title: const Text('Tema Escuro'),
          value: configuracoesModel.temaEscuro, onChanged: (bool value) {
          setState(() {
            configuracoesModel.temaEscuro = value;
          });
        }),
        TextButton(onPressed: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          configuracoesModel.nomeUsuario = nomeUsuarioController.text;
          try {
            configuracoesModel.altura = double.parse(alturaController.text);
          } catch (e) {
            return showDialog(context: context, builder: (_) {
              return AlertDialog(title: const Text('Meu App'),
              content: const Text('Favor informar uma altura válida'),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text('Ok'))
              ]);
            });
          }
          configuracoesRepository.salvar(configuracoesModel);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }, child: const Text('Salvar'))
      ],),));
  }
}