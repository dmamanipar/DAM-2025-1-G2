import 'package:dio/dio.dart';
import 'package:ventas_app/apis/marca_api.dart';
import 'package:ventas_app/local/condb/ConexionDB.dart';
import 'package:ventas_app/modelo/MarcaModelo.dart';
import 'package:ventas_app/util/NetworConnection.dart';
import 'package:ventas_app/util/TokenUtil.dart';

class MarcaRepository with ConexionDB{
  MarcaApi? marcaApi;

  MarcaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    marcaApi = MarcaApi(_dio);
  }

  Future<List<Marca>> getEntidad() async {
    final db=await conection();
    if(await isConected()){
      return await marcaApi!.getMarca(TokenUtil.TOKEN).then((
          value) => value);
    } else{
      return db.marcaDao.findAll();
    }

  }
}