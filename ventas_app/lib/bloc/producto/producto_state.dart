part of 'producto_bloc.dart';

@immutable
sealed class ProductoState {}

final class ProductoInitialState extends ProductoState {}
class ProductoLoaginState extends ProductoState{
}
class ProductoLoadedState extends ProductoState{
  List<ProductoResp> productoList;
  ProductoLoadedState(this.productoList);
}
class ProductoLoadedFormDataState extends ProductoState{
  List<Marca> marcaList;
  List<Categoria> categoriaList;
  List<UnidadMedida> unidadMedidaList;
  ProductoLoadedFormDataState(this.marcaList, this.categoriaList, this.unidadMedidaList);
}

class ProductoError extends ProductoState{
  Error e;
  ProductoError(this.e);
}

