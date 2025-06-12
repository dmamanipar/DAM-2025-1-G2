import 'dart:async';
import 'package:floor/floor.dart';
import 'package:ventas_app/local/dao/CategoriaDao.dart';
import 'package:ventas_app/local/dao/MarcaDao.dart';
import 'package:ventas_app/local/dao/ProductoDao.dart';
import 'package:ventas_app/local/dao/UnidadMediadDao.dart';
import 'package:ventas_app/modelo/CategoriaModelo.dart';
import 'package:ventas_app/modelo/MarcaModelo.dart';
import 'package:ventas_app/modelo/ProductoModelo.dart';
import 'package:ventas_app/modelo/UnidadMedidaModelo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version: 1, entities: [ProductoDto, Marca, Categoria, UnidadMedida])
abstract class AppDatabase extends FloorDatabase{
  ProductoDao get productoDao;
  CategoriaDao get categoriaDao;
  MarcaDao get marcaDao;
  UnidadMedidaDao get unidadmedidaDao;
}