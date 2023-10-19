import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/pagina2.dart';
import 'package:trilhaapp/pages/list_view_v.dart';
import 'package:trilhaapp/pages/tarefa_page/tarefa_hive_page.dart';

import '../shared/widgets/custom_drawer.dart';
import 'list_view_h.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Home Page'))),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: const [
                CardPage(),
                Pagina2Page(),
                ListViewVPage(),
                ListViewHPage(),
                TarefaHivePage(),
              ],),
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                controller.jumpToPage(value);
              },
              currentIndex: posicaoPagina,
              items: const [
              BottomNavigationBarItem(
                label: 'Pag1',
                icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                label: 'Pag2',
                icon: Icon(Icons.add)),
              BottomNavigationBarItem(
                label: 'Pag3',
                icon: Icon(Icons.person)),
              BottomNavigationBarItem(
                label: 'Pag4',
                icon: Icon(Icons.list)),
              BottomNavigationBarItem(
                label: 'Pag5',
                icon: Icon(Icons.task)),
            ])
          ],
        ),
      ),
    );
  }
}