import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/models/dados_cadastrais_model.dart';
import 'package:trilhaapp/repositories/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({super.key});

  @override
  State<DadosCadastraisHivePage> createState() => _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();

  var nomeController = TextEditingController(text: '');
  var dataNascimentoController = TextEditingController(text: '');
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.carregar();
    dadosCadastraisRepository.obterDados();
    nomeController.text = dadosCadastraisModel.nome ?? '';
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null ? '' : dadosCadastraisModel.dataNascimento.toString();
    setState(() {});
  }

  Text returnText(String text) {
    return Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700));
  }

  List<DropdownMenuItem<int>> returnItems(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(DropdownMenuItem(value: i, child: Text(i.toString())));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dados Cadastrais')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando? const Center(child: CircularProgressIndicator()) : ListView(
          children: [
          returnText('Nome'),
          TextField(
            controller: nomeController,
          ),
          const SizedBox(height: 10,),
          returnText('Data de Nascimento'),
          TextField(
            readOnly: true,
            controller: dataNascimentoController,
            onTap: () async {
              var data = await showDatePicker(
                context: context,
                initialDate: DateTime(2000, 1, 1),
                firstDate: DateTime(1900, 1, 1),
                lastDate: DateTime(2023, 10, 23),
              );
              if (data != null) {
                dataNascimentoController.text = data.toString();
                dadosCadastraisModel.dataNascimento = data;
              }
            },
          ),
          const SizedBox(height: 10),
          returnText('Nivel de Experiência'),
          Column(
            children:
              niveis.map((nivel) => RadioListTile(
              title: Text(nivel),
              dense: true,
              selected: dadosCadastraisModel.nivelExperiencia == nivel,
              value: nivel, groupValue: dadosCadastraisModel.nivelExperiencia, 
              onChanged: (value) {
                print(value);
                setState(() {
                  dadosCadastraisModel.nivelExperiencia = value;
                });
              })
            ).toList()
          ),
          returnText('Linguagens preferidas'),
          Column(children:
            linguagens.map((e) => CheckboxListTile(
              dense: true,
              title: Text(e), 
              value: dadosCadastraisModel.linguagens.contains(e), 
              onChanged: (bool? value) {
                if (value!) {
                  setState(() {
                     dadosCadastraisModel.linguagens.add(e);
                  });
                } else {
                  setState(() {
                    dadosCadastraisModel.linguagens.remove(e);
                  });
                }
              })
            ,
          ).toList()),
          returnText('Tempo de experiência'),
          DropdownButton(
            value: dadosCadastraisModel.tempoExperiencia,
            isExpanded: true,
            items: returnItems(50),
            onChanged: (value) {
            setState(() {
              dadosCadastraisModel.tempoExperiencia = int.parse(value.toString());
            });
          }),
          returnText('Pretensão Salarial. R\$ ${dadosCadastraisModel.salario?.round().toString()}'),
          Slider(min: 0, max: 10000, value: dadosCadastraisModel.salario ?? 0, onChanged: (double value) {
            setState(() {
              dadosCadastraisModel.salario = value; 
            });
          }),
          TextButton(onPressed: () async {
            setState(() {
              salvando = false;
            });
            if (nomeController.text.trim().length < 3) {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('O nome deve ser preenchido'))
                );
                return;
            }
            if (dadosCadastraisModel.dataNascimento == null) {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data de nascimento inválida'))
                );
                return;
            }
            if (dadosCadastraisModel.nivelExperiencia == null || dadosCadastraisModel.nivelExperiencia!.trim() == '') {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('O nível deve ser selecionado'))
                );
                return;
            }
            if (dadosCadastraisModel.linguagens.isEmpty) {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deve ser selecionado ao menos uma linguagem'))
                );
                return;
            }
            if (dadosCadastraisModel.tempoExperiencia == null || dadosCadastraisModel.tempoExperiencia == 0) {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deve ter ao menos um ano de experiência em uma das linguagens'))
                );
                return;
            }
            if (dadosCadastraisModel.salario == null || dadosCadastraisModel.salario == 0) {
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('A pretensão salarial deve ser maior que 0'))
                );
                return;
            }
            dadosCadastraisModel.nome = nomeController.text;
            dadosCadastraisRepository.salvar(dadosCadastraisModel);
            setState(() {
              salvando = true;
            });
            Future.delayed(const Duration(seconds: 2), () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dados salvos com sucesso'))
              );
              setState(() {
                salvando = false;
              });
              Navigator.pop(context);
            });
          }, child: const Text('Salvar')),
        ]),
      )
    );
  }
}