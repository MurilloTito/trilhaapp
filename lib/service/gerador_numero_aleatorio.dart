import 'dart:math';

class GerarNumeroAleatorioService {
  
  static int gerarNumeroRandom(int numeroMaximo) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(numeroMaximo);
  }

}