import 'package:ventas_app/local/db/database.dart';

mixin ConexionDB{
  Future<AppDatabase> conection() async{
    return await $FloorAppDatabase.databaseBuilder('ventas.db').build();
  }
}