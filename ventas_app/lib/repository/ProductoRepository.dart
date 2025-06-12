import 'package:dio/dio.dart';
import 'package:ventas_app/apis/categoria_api.dart';
import 'package:ventas_app/apis/marca_api.dart';
import 'package:ventas_app/apis/producto_api.dart';
import 'package:ventas_app/apis/unidadmedida_api.dart';
import 'package:ventas_app/local/condb/ConexionDB.dart';
import 'package:ventas_app/mappers/ProductoMapper.dart';
import 'package:ventas_app/modelo/MessageModelo.dart';
import 'package:ventas_app/modelo/ProductoModelo.dart';
import 'package:ventas_app/util/NetworConnection.dart';
import 'package:ventas_app/util/TokenUtil.dart';

class ProductoRepository with ConexionDB{
  ProductoApi? productoApi;
  CategoriaApi? categoriaApi;
  MarcaApi? marcaApi;
  UnidadmedidaApi? unidadmedidaApi;

  ProductoRepository(){
    Dio _dio=Dio();
    _dio.options.headers["Content-Type"]="application/json";
    productoApi=ProductoApi(_dio);
    categoriaApi=CategoriaApi(_dio);
    marcaApi=MarcaApi(_dio);
    unidadmedidaApi=UnidadmedidaApi(_dio);
  }

  Future<List<ProductoResp>> getEntidad() async{
    final db=await conection();
    final productoDao=db.productoDao;
    final categoriaDao=db.categoriaDao;
    final marcaDao=db.marcaDao;
    final unidadMedDao=db.unidadmedidaDao;
    if(await isConected()){
      var datoC= await categoriaApi!.getCategoria(TokenUtil.TOKEN);
      await categoriaDao.insertAll(datoC);

      var datoM= await marcaApi!.getMarca(TokenUtil.TOKEN);
      await marcaDao.insertAll(datoM);

      var datoU= await unidadmedidaApi!.getUnidadMedida(TokenUtil.TOKEN);
      await unidadMedDao.insertAll(datoU);

      var datoP= await productoApi!.getProducto(TokenUtil.TOKEN);
      for(ProductoResp to in datoP){
        await productoDao.insert(ProductoMapper.toDto(to));
      }
      return datoP;
    }else{
      List<ProductoResp> lista=[];
      var dataP=await productoDao.findAll();
      for(ProductoDto da in dataP){
      final categoria=await categoriaDao.findById(da.categoria);
      final marca=await marcaDao.findById(da.marca);
      final unidamedida=await unidadMedDao.findById(da.unidadMedida);
      lista.add(ProductoMapper.toResp(da,
          categoria: categoria!,
          marca: marca!,
          unidadMedida: unidamedida!));
      }
    return lista;
    }
    //return await productoApi!.getProducto(TokenUtil.TOKEN).then((value)=>value);
  }

  Future<Message> deleteEntidad(int id) async{
    return await productoApi!.deleteProducto(TokenUtil.TOKEN, id);
  }

  Future<ProductoResp> updateEntidad(int id, ProductoDto producto) async{
    return await productoApi!.updateProducto(TokenUtil.TOKEN, id, producto);
  }

  Future<Message> createEntidad(ProductoDto producto) async{
    return await productoApi!.crearProducto(TokenUtil.TOKEN, producto);
  }

}