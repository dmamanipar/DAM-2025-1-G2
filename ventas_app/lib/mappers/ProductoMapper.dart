import 'package:ventas_app/modelo/CategoriaModelo.dart';
import 'package:ventas_app/modelo/MarcaModelo.dart';
import 'package:ventas_app/modelo/ProductoModelo.dart';
import 'package:ventas_app/modelo/UnidadMedidaModelo.dart';

class ProductoMapper{
  static ProductoDto toDto(ProductoResp resp){
    return ProductoDto(idProducto: resp.idProducto,
        nombre: resp.nombre,
        pu: resp.pu,
        puOld: resp.puOld,
        utilidad: resp.utilidad,
        stock: resp.stock,
        stockOld: resp.stockOld,
        categoria: resp.categoria.idCategoria,
        marca: resp.marca.idMarca,
        unidadMedida: resp.unidadMedida.idUnidad);
  }
  static ProductoResp toResp(
      ProductoDto dto,
          {required Categoria categoria,
            required Marca marca,
            required UnidadMedida unidadMedida
          }
      ){
    return ProductoResp(idProducto: dto.idProducto,
        nombre: dto.nombre,
        pu: dto.pu,
        puOld: dto.puOld,
        utilidad: dto.utilidad,
        stock: dto.stock,
        stockOld: dto.stockOld,
        categoria: categoria,
        marca: marca,
        unidadMedida: unidadMedida);
      }

}