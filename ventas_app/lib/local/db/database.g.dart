// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductoDao? _productoDaoInstance;

  CategoriaDao? _categoriaDaoInstance;

  MarcaDao? _marcaDaoInstance;

  UnidadMedidaDao? _unidadmedidaDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `producto` (`id_producto` INTEGER NOT NULL, `nombre` TEXT NOT NULL, `pu` REAL NOT NULL, `pu_old` REAL NOT NULL, `utilidad` REAL NOT NULL, `stock` REAL NOT NULL, `stock_old` REAL NOT NULL, `categoria` INTEGER NOT NULL, `marca` INTEGER NOT NULL, `unidadMedida` INTEGER NOT NULL, PRIMARY KEY (`id_producto`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `marca` (`id_marca` INTEGER NOT NULL, `nombre` TEXT NOT NULL, PRIMARY KEY (`id_marca`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `categoria` (`id_categoria` INTEGER NOT NULL, `nombre` TEXT NOT NULL, PRIMARY KEY (`id_categoria`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `unidadmedida` (`id_unidad` INTEGER NOT NULL, `nombre_medida` TEXT NOT NULL, PRIMARY KEY (`id_unidad`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductoDao get productoDao {
    return _productoDaoInstance ??= _$ProductoDao(database, changeListener);
  }

  @override
  CategoriaDao get categoriaDao {
    return _categoriaDaoInstance ??= _$CategoriaDao(database, changeListener);
  }

  @override
  MarcaDao get marcaDao {
    return _marcaDaoInstance ??= _$MarcaDao(database, changeListener);
  }

  @override
  UnidadMedidaDao get unidadmedidaDao {
    return _unidadmedidaDaoInstance ??=
        _$UnidadMedidaDao(database, changeListener);
  }
}

class _$ProductoDao extends ProductoDao {
  _$ProductoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productoDtoInsertionAdapter = InsertionAdapter(
            database,
            'producto',
            (ProductoDto item) => <String, Object?>{
                  'id_producto': item.idProducto,
                  'nombre': item.nombre,
                  'pu': item.pu,
                  'pu_old': item.puOld,
                  'utilidad': item.utilidad,
                  'stock': item.stock,
                  'stock_old': item.stockOld,
                  'categoria': item.categoria,
                  'marca': item.marca,
                  'unidadMedida': item.unidadMedida
                }),
        _productoDtoUpdateAdapter = UpdateAdapter(
            database,
            'producto',
            ['id_producto'],
            (ProductoDto item) => <String, Object?>{
                  'id_producto': item.idProducto,
                  'nombre': item.nombre,
                  'pu': item.pu,
                  'pu_old': item.puOld,
                  'utilidad': item.utilidad,
                  'stock': item.stock,
                  'stock_old': item.stockOld,
                  'categoria': item.categoria,
                  'marca': item.marca,
                  'unidadMedida': item.unidadMedida
                }),
        _productoDtoDeletionAdapter = DeletionAdapter(
            database,
            'producto',
            ['id_producto'],
            (ProductoDto item) => <String, Object?>{
                  'id_producto': item.idProducto,
                  'nombre': item.nombre,
                  'pu': item.pu,
                  'pu_old': item.puOld,
                  'utilidad': item.utilidad,
                  'stock': item.stock,
                  'stock_old': item.stockOld,
                  'categoria': item.categoria,
                  'marca': item.marca,
                  'unidadMedida': item.unidadMedida
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductoDto> _productoDtoInsertionAdapter;

  final UpdateAdapter<ProductoDto> _productoDtoUpdateAdapter;

  final DeletionAdapter<ProductoDto> _productoDtoDeletionAdapter;

  @override
  Future<List<ProductoDto>> findAll() async {
    return _queryAdapter.queryList('select * from producto',
        mapper: (Map<String, Object?> row) => ProductoDto(
            idProducto: row['id_producto'] as int,
            nombre: row['nombre'] as String,
            pu: row['pu'] as double,
            puOld: row['pu_old'] as double,
            utilidad: row['utilidad'] as double,
            stock: row['stock'] as double,
            stockOld: row['stock_old'] as double,
            categoria: row['categoria'] as int,
            marca: row['marca'] as int,
            unidadMedida: row['unidadMedida'] as int));
  }

  @override
  Future<List<ProductoDto>> findById(int id) async {
    return _queryAdapter.queryList(
        'select * from producto where id_producto=?1',
        mapper: (Map<String, Object?> row) => ProductoDto(
            idProducto: row['id_producto'] as int,
            nombre: row['nombre'] as String,
            pu: row['pu'] as double,
            puOld: row['pu_old'] as double,
            utilidad: row['utilidad'] as double,
            stock: row['stock'] as double,
            stockOld: row['stock_old'] as double,
            categoria: row['categoria'] as int,
            marca: row['marca'] as int,
            unidadMedida: row['unidadMedida'] as int),
        arguments: [id]);
  }

  @override
  Future<void> deleteE(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from producto where id_producto=?1',
        arguments: [id]);
  }

  @override
  Future<int?> getMaxId() async {
    return _queryAdapter.query('select MAX(id_producto) FROM producto',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertAll(List<ProductoDto> datos) async {
    await _productoDtoInsertionAdapter.insertList(
        datos, OnConflictStrategy.replace);
  }

  @override
  Future<void> insert(ProductoDto datos) async {
    await _productoDtoInsertionAdapter.insert(
        datos, OnConflictStrategy.replace);
  }

  @override
  Future<void> update(ProductoDto datos) async {
    await _productoDtoUpdateAdapter.update(datos, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAll(List<ProductoDto> datos) async {
    await _productoDtoDeletionAdapter.deleteList(datos);
  }
}

class _$CategoriaDao extends CategoriaDao {
  _$CategoriaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoriaInsertionAdapter = InsertionAdapter(
            database,
            'categoria',
            (Categoria item) => <String, Object?>{
                  'id_categoria': item.idCategoria,
                  'nombre': item.nombre
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Categoria> _categoriaInsertionAdapter;

  @override
  Future<List<Categoria>> findAll() async {
    return _queryAdapter.queryList('select * from categoria',
        mapper: (Map<String, Object?> row) => Categoria(
            idCategoria: row['id_categoria'] as int,
            nombre: row['nombre'] as String));
  }

  @override
  Future<Categoria?> findById(int id) async {
    return _queryAdapter.query('select * from categoria where id_categoria=?1',
        mapper: (Map<String, Object?> row) => Categoria(
            idCategoria: row['id_categoria'] as int,
            nombre: row['nombre'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertAll(List<Categoria> datos) async {
    await _categoriaInsertionAdapter.insertList(
        datos, OnConflictStrategy.replace);
  }

  @override
  Future<void> insert(Categoria datos) async {
    await _categoriaInsertionAdapter.insert(datos, OnConflictStrategy.replace);
  }
}

class _$MarcaDao extends MarcaDao {
  _$MarcaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _marcaInsertionAdapter = InsertionAdapter(
            database,
            'marca',
            (Marca item) => <String, Object?>{
                  'id_marca': item.idMarca,
                  'nombre': item.nombre
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Marca> _marcaInsertionAdapter;

  @override
  Future<List<Marca>> findAll() async {
    return _queryAdapter.queryList('select * from marca',
        mapper: (Map<String, Object?> row) => Marca(
            idMarca: row['id_marca'] as int, nombre: row['nombre'] as String));
  }

  @override
  Future<Marca?> findById(int id) async {
    return _queryAdapter.query('select * from marca where id_marca=?1',
        mapper: (Map<String, Object?> row) => Marca(
            idMarca: row['id_marca'] as int, nombre: row['nombre'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertAll(List<Marca> datos) async {
    await _marcaInsertionAdapter.insertList(datos, OnConflictStrategy.replace);
  }

  @override
  Future<void> insert(Marca datos) async {
    await _marcaInsertionAdapter.insert(datos, OnConflictStrategy.replace);
  }
}

class _$UnidadMedidaDao extends UnidadMedidaDao {
  _$UnidadMedidaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _unidadMedidaInsertionAdapter = InsertionAdapter(
            database,
            'unidadmedida',
            (UnidadMedida item) => <String, Object?>{
                  'id_unidad': item.idUnidad,
                  'nombre_medida': item.nombreMedida
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UnidadMedida> _unidadMedidaInsertionAdapter;

  @override
  Future<List<UnidadMedida>> findAll() async {
    return _queryAdapter.queryList('select * from unidadmedida',
        mapper: (Map<String, Object?> row) => UnidadMedida(
            idUnidad: row['id_unidad'] as int,
            nombreMedida: row['nombre_medida'] as String));
  }

  @override
  Future<UnidadMedida?> findById(int id) async {
    return _queryAdapter.query('select * from unidadmedida where id_unidad=?1',
        mapper: (Map<String, Object?> row) => UnidadMedida(
            idUnidad: row['id_unidad'] as int,
            nombreMedida: row['nombre_medida'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertAll(List<UnidadMedida> datos) async {
    await _unidadMedidaInsertionAdapter.insertList(
        datos, OnConflictStrategy.replace);
  }

  @override
  Future<void> insert(UnidadMedida datos) async {
    await _unidadMedidaInsertionAdapter.insert(
        datos, OnConflictStrategy.replace);
  }
}
