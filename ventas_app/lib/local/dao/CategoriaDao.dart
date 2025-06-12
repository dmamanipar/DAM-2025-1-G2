
import 'package:floor/floor.dart';
import 'package:ventas_app/modelo/CategoriaModelo.dart';

@dao
abstract class CategoriaDao{

  @Query('select * from categoria')
  Future<List<Categoria>> findAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<Categoria> datos);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(Categoria datos);

  @Query('select * from categoria where id_categoria=:id')
  Future<Categoria?> findById(int id);
}