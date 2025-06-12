import 'package:floor/floor.dart';
import 'package:ventas_app/modelo/MarcaModelo.dart';

@dao
abstract class MarcaDao{

  @Query('select * from marca')
  Future<List<Marca>> findAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<Marca> datos);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(Marca datos);

  @Query('select * from marca where id_marca=:id')
  Future<Marca?> findById(int id);
}