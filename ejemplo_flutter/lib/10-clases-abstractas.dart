void main() {
  final perro = new Perro();
  final gato = new Gato();
  sonidoAnimal( perro );
  sonidoAnimal( gato );
}


void sonidoAnimal( Animal animal ) {
  animal.emitirSonido();
}



abstract class Animal {
  late int patas;
  void emitirSonido();
}

class Perro implements Animal {
 late int patas;
  //void emitirSonido() => print('Guauuuuuuuu');
  void emitirSonido(){
    print('Guauuuuuuuu');
  }
}

class Gato implements Animal {
  late int patas;
  late  int cola;
  void emitirSonido() => print('Miauuuuuuuu');
}
