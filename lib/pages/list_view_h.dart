import 'package:flutter/material.dart';

class ListViewHPage extends StatefulWidget {
  const ListViewHPage({super.key});

  @override
  State<ListViewHPage> createState() => _ListViewHPageState();
}

class _ListViewHPageState extends State<ListViewHPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
        Icon(Icons.gamepad, size: 200,),
        Icon(Icons.access_alarm, size: 200,),
        Icon(Icons.gas_meter, size: 200,)
      ],)),
    );
  }
}