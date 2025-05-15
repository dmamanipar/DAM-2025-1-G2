void main() {
  final nombre = 'Fernando';
  saludar(nombre);
  saludar(nombre, "Holas ");
  saludar2(nombre: nombre, mensaje: "Saludos");

  saludar2( mensaje: "Saludos", nombre: nombre);
}

void saludar(String nombre, [String mensaje = 'Hi']) {
  print('$mensaje $nombre');
}

void saludar2({
  required String nombre,
  required String mensaje,
}) {
  print('$mensaje $nombre');
}
