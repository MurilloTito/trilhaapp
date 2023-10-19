import 'package:flutter/material.dart';

class ListViewVPage extends StatefulWidget {
  const ListViewVPage({super.key});

  @override
  State<ListViewVPage> createState() => _ListViewVPageState();
}

class _ListViewVPageState extends State<ListViewVPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person_2),
          title: const Text('Usuário 2'),
          subtitle: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Olá, tudo bem?'),
              Text('08:59')
            ],
          ),
          trailing: PopupMenuButton<String>(onSelected: (menu) {},
          itemBuilder: (BuildContext bc) {
            return <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'opcao1',
                child: Text('Opção 1')),
              const PopupMenuItem<String>(
              value: 'opcao2',
              child: Text('Opção 2')),
              const PopupMenuItem<String>(
              value: 'opcao3',
              child: Text('Opção 3'))
            ];
          },),
          isThreeLine: true,
        ),
        const Icon(Icons.person, size: 200),
        const Icon(Icons.person_2, size: 200),
        const Icon(Icons.person_3, size: 200),
      ],
    );
  }
}