import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({super.key});

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() => _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState extends State<ConfiguracoesSharedPreferencesPage> {
  String? nomeUsuario;
  double? altura;
  bool receberPushNotification = false;
  bool temaEscuro = false;
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  late SharedPreferences storage;

  final CHAVE_NOME_USUARIO = 'CHAVE_NOME_USUARIO';
  final CHAVE_ALTURA = 'CHAVE_ALTURA';
  final CHAVE_RECEBER_NOTIFICACOES = 'CHAVE_RECEBER_NOTIFICACOES';
  final CHAVE_TEMA_ESCURO = 'CHAVE_TEMA_ESCURO';

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuarioController.text = storage.getString(CHAVE_NOME_USUARIO) ?? '';
      alturaController.text = (storage.getDouble(CHAVE_ALTURA) ?? 0).toString();
      receberPushNotification = storage.getBool(CHAVE_RECEBER_NOTIFICACOES) ??  false;
      temaEscuro = storage.getBool(CHAVE_TEMA_ESCURO) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(title: const Text('Configurações'),),
      body: Container(child: ListView(children: [
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
          value: receberPushNotification, onChanged: (bool value) {
          setState(() {
            receberPushNotification = !receberPushNotification;
          });
        }),
        SwitchListTile(
          title: const Text('Tema Escuro'),
          value: temaEscuro, onChanged: (bool value) {
          setState(() {
            temaEscuro = value;
          });
        }),
        TextButton(onPressed: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          await storage.setString(CHAVE_NOME_USUARIO, nomeUsuarioController.text);
          try {
            await storage.setDouble(CHAVE_ALTURA, double.parse(alturaController.text));
          } catch (e) {
            // ignore: use_build_context_synchronously
            showDialog(context: context, builder: (BuildContext bc) {
              return AlertDialog(title: const Text('Meu App'),
              content: const Text('Favor informar uma altura válida'),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text('Ok'))
              ]);
            });
          }
          await storage.setBool(CHAVE_RECEBER_NOTIFICACOES, receberPushNotification);
          await storage.setBool(CHAVE_TEMA_ESCURO, temaEscuro);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }, child: const Text('Salvar'))
      ],)),));
  }
}