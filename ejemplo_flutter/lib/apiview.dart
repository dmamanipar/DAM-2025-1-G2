import 'package:ejemplo_flutter/api/usuario_api.dart';
import 'package:ejemplo_flutter/modelo/Usuario.dart';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final apiService = UsuarioApi(dio);
  try {
    List<Usuario> user= await apiService.listar();
    for (var userx in user) {
      print('ID: ${userx.iD}, Name: ${userx.nOMBRE}, Email: ${userx.aPELLIDOS}');
    }
    /*print('ID: ${user.first.iD}');
 print('Name: ${user.first.nOMBRE}');
 print('Email: ${user.first.aPELLIDOS}');*/
  } catch (e) {
    print('Error x: $e');
  }
}

