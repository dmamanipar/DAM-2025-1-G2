void main() {
  final wolverine = new Heroe(/*nombre: 'Logan',*/ poder:
  'Regeneración');
  wolverine.nombre="Logan";
//wolverine.nombre = 'LoganX';
//wolverine.poder = 'RegeneraciónX';
  print(wolverine);
}


class Heroe {
  late String nombre;
  String poder;

  Heroe({required this.poder});

  String toString() {
    return 'Heroe: nombre: ${this.nombre}, poder: ${this.poder}';
  }
}
