import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_detail_page.dart';
import 'package:trilhaapp/repositories/card_detail_repository.dart';

import '../models/card_detail.dart';


class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetail? cardDetail;
  var cardDetailRepository = CardDetailRepository();

  @override
  void initState() { // nunca pode usar async no initState()
    super.initState();
    loadData();
  }

  void loadData() async {
    cardDetail = await cardDetailRepository.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity, child: InkWell(
            onTap: () {

            },
            child: cardDetail == null ? const LinearProgressIndicator() : InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (
                  (context) => CardDetailPage(cardDetail: cardDetail!,))));
              },
              child: Hero(
                tag: cardDetail!.id,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(children: [
                        Image.network(cardDetail!.url,
                        height: 20,),
                        Text(cardDetail!.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
                      ],),
                      const SizedBox(height: 10),
                      Text(cardDetail!.text,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal), textAlign: TextAlign.justify),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: () {
                      
                        }, child: const Text('Ler mais...', style: TextStyle(decoration: TextDecoration.underline))),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          )
        )
      ],
    );
  }
}