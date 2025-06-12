import 'package:floor/floor.dart';
import 'package:ventas_app/modelo/UnidadMedidaModelo.dart';

@dao
abstract class UnidadMedidaDao{
  @Query('select * from unidadmedida')
  Future<List<UnidadMedida>> findAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<UnidadMedida> datos);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(UnidadMedida datos);

  @Query('select * from unidadmedida where id_unidad=:id')
  Future<UnidadMedida?> findById(int id);

}