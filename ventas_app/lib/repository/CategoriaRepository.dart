import 'package:dio/dio.dart';
import 'package:ventas_app/apis/categoria_api.dart';
import 'package:ventas_app/local/condb/ConexionDB.dart';
import 'package:ventas_app/modelo/CategoriaModelo.dart';
import 'package:ventas_app/util/NetworConnection.dart';
import 'package:ventas_app/util/TokenUtil.dart';

class CategoriaRepository with ConexionDB{
  CategoriaApi? categoriaApi;

  CategoriaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    categoriaApi = CategoriaApi(_dio);
  }

  Future<List<Categoria>> getEntidad() async {
    final db=await conection();
    if(await isConected()){
    return await categoriaApi!.getCategoria(TokenUtil.TOKEN).then((
        value) => value);
    } else{
      return db.categoriaDao.findAll();
    }
  }
}