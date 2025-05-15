void main() {
  final rawJson = {'nombre': 'Tony Stark', 'poder': 'Dinero'};

// final ironman = new Heroe( nombre: rawJson['nombre']!, poder: rawJson['poder']! );
  final ironman = Heroe.fromJson(rawJson);
  print(ironman);
// final wolverine = new Heroe(nombre:'Logan', poder: 'Regeneración');
// print( wolverine );
}


class Heroe {
  late String nombre;
  late String poder;

  Heroe({required this.nombre, required this.poder});
  //Heroe();

  Heroe.fromJson(Map<String, String> json)
      : this.nombre = json['nombre']!,
        this.poder = json['poder'] ?? 'No tiene poder';


  String toString() {
    return 'Heroe: nombre: ${this.nombre}, poder: ${this.poder}';
  }
}
