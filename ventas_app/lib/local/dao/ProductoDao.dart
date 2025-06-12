
import 'package:floor/floor.dart';
import 'package:ventas_app/modelo/ProductoModelo.dart';

@dao
abstract class ProductoDao{
  @Query('select * from producto')
  Future<List<ProductoDto>> findAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<ProductoDto> datos);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(ProductoDto datos);

  @Query('select * from producto where id_producto=:id')
  Future<List<ProductoDto>> findById(int id);

  @Update()
  Future<void> update(ProductoDto datos);

  @Query("delete from producto where id_producto=:id")
  Future<void> deleteE(int id);
  
  @delete
  Future<void> deleteAll(List<ProductoDto> datos);
 
  @Query("select MAX(id_producto) FROM producto")
  Future<int?> getMaxId();

}