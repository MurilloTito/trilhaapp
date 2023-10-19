import 'package:flutter/material.dart';
import 'package:trilhaapp/models/tarefa_hive_model.dart';
import 'package:trilhaapp/repositories/tarefa_hive_repository.dart';

class TarefaHivePage extends StatefulWidget {
  const TarefaHivePage({super.key});

  @override
  State<TarefaHivePage> createState() => _TarefaHivePageState();
}

class _TarefaHivePageState extends State<TarefaHivePage> {
  late TarefaHiveRepository tarefaRepository;
  var _tarefas = const <TarefaHiveModel>[];
  TextEditingController descricaoController = TextEditingController(text: '');
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    tarefaRepository = await TarefaHiveRepository.carregar();
    _tarefas = tarefaRepository.obterDados(apenasNaoConcluidos);
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        descricaoController.text = '';
        showDialog(context: context, builder: (BuildContext bc) {
          return AlertDialog(title: const Text('Adicionar tarefa'), 
          content: TextField(
            controller: descricaoController,
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text('Cancelar')),
            TextButton(onPressed: () async {
              await tarefaRepository.salvar(TarefaHiveModel.criar(descricaoController.text, false));
              Navigator.pop(context);
              obterTarefas();
              setState(() {});
            },child: const Text('Salvar'))
          ],);
        });
      },
      child: const Icon(Icons.add),),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text('Apenas não concluídos'),
              Switch(value: apenasNaoConcluidos, onChanged: (bool value) {
                apenasNaoConcluidos = value;
                obterTarefas();
              })
            ]),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      tarefaRepository.excluir(tarefa);
                      obterTarefas();
                    },
                    key: Key(tarefa.key.toString()),
                    child: ListTile(title: Text(tarefa.descricao),
                    trailing: Switch(onChanged: (bool value) async {
                      tarefa.concluido = value;
                      tarefaRepository.alterar(tarefa);
                      obterTarefas();
                    }, value: tarefa.concluido),),
                  );
              }),
            ),
          ],
        ),
      ),
    );
  }
}