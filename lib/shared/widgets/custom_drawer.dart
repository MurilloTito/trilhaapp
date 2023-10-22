import 'package:flutter/material.dart';

import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/posts_page.dart';

import '../../pages/configuracoes/configuracoes_hive_page.dart';
import '../../pages/dados_cadastrais/dados_cadastrais_hive.dart';
import '../../pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: 
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  context: context, builder: (BuildContext bc) {
                  return Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text('Camera'),
                        leading: const Icon(Icons.camera),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text('Camera'),
                        leading: const Icon(Icons.album),
                      )
                    ]);
                });
              },
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(width: 45,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfYBInJyGYkGdrcryoHDPAzkJt6QMcGJImhXzvhSQe&s')),
                accountName: const Text('Murillo'), 
                accountEmail: const Text("email@email.com")),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DadosCadastraisHivePage()));
              }, 
              child: const SizedBox(width: double.infinity, child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5),
                  Text('Dados cadastrais'),
                ],
              ))),
            const Divider(),
            const SizedBox(height: 10),
              InkWell(
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  context: context, builder: (BuildContext bc) {
                  return const Text('Gostaria de enfatizar que a revolução dos costumes auxilia a preparação e a composição das diretrizes de desenvolvimento para o futuro.');
                });
              }, 
              child: const SizedBox(width: double.infinity, child: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 5),
                  Text('Termos de uso e privacidade'),
                ],
              ))),
            const Divider(),
            const SizedBox(height: 10),
            InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => const ConfiguracoesHivePage()));
            }, 
            child: const SizedBox(width: double.infinity, child: Row(
              children: [
                Icon(Icons.album),
                SizedBox(width: 5),
                Text('Configurações'),
              ],
            ))),
            const Divider(),
            const SizedBox(height: 10),
            InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => const NumerosAleatoriosHivePage()));
            }, 
            child: const SizedBox(width: double.infinity, child: Row(
              children: [
                Icon(Icons.numbers),
                SizedBox(width: 5),
                Text('Gerador de números'),
              ],
            ))),
            const Divider(),
            const SizedBox(height: 10),
            InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => const PostsPage()));
            }, 
            child: const SizedBox(width: double.infinity, child: Row(
              children: [
                Icon(Icons.post_add),
                SizedBox(width: 5),
                Text('Posts'),
              ],
            ))),
            const Divider(),
            const SizedBox(height: 10),
            InkWell(
            onTap: () {
              showDialog(context: context, builder: (BuildContext bc) {
                return AlertDialog(
                  alignment: Alignment.center,
                  title: const Text('Meu App'),
                  content: const Wrap(
                    children: [
                      Text('Deseja realmente sair do App?'),
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()
                      ));
                    }, child: const Text('Sim')),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text('Não'))
                  ],
                );
              });
            }, 
            child: const SizedBox(width: double.infinity, child: Row(
              children: [
                Icon(Icons.exit_to_app),
                SizedBox(width: 5),
                Text('Sair'),
              ],
            ))),
        ],),
      )
    );
  }
}