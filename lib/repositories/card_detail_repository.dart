import '../models/card_detail.dart';

class CardDetailRepository {
    Future<CardDetail> get() async {
      await Future.delayed(Duration(seconds: 3));
      return CardDetail(
        1,
        'Meu Card',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfYBInJyGYkGdrcryoHDPAzkJt6QMcGJImhXzvhSQe&s',
        'Gostaria de enfatizar que a revolução dos costumes auxilia a preparação e a composição das diretrizes de desenvolvimento para o futuro.',
      );
  }
}