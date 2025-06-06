import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ventas_app/modelo/CategoriaModelo.dart';
import 'package:ventas_app/modelo/MarcaModelo.dart';
import 'package:ventas_app/modelo/ProductoModelo.dart';
import 'package:ventas_app/modelo/UnidadMedidaModelo.dart';
import 'package:ventas_app/repository/CategoriaRepository.dart';
import 'package:ventas_app/repository/MarcaRepository.dart';
import 'package:ventas_app/repository/ProductoRepository.dart';
import 'package:ventas_app/repository/UnidadMedidaRepository.dart';

part 'producto_event.dart';
part 'producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {

  late final ProductoRepository _productoRepository;
  late final MarcaRepository _marcaRepository;
  late final CategoriaRepository _categoriaRepository;
  late final UnidadMedidaRepository _unidadMedidaRepository;

  ProductoBloc(this._productoRepository, this._categoriaRepository,
      this._marcaRepository, this._unidadMedidaRepository) : super(ProductoInitialState()) {
    on<ProductoEvent>((event, emit) async{
      if(event is ListarProductoEvent){
        emit(ProductoLoaginState());
        try{
          List<ProductoResp> productList=await _productoRepository.getEntidad();
          emit(ProductoLoadedState(productList));
        }catch(e){
          emit(ProductoError(e as Error));
        }
      }else if(event is DeleteProductoEvent){
        try{
          await _productoRepository.deleteEntidad(event.producto!.idProducto);
          emit(ProductoLoaginState());
          List<ProductoResp> productList=await _productoRepository.getEntidad();
          emit(ProductoLoadedState(productList));
        }catch(e){
          emit(ProductoError(e as Error));
        }
      }else if(event is CreateProductoEvent){
        try{
          await _productoRepository.createEntidad(event.producto);
          emit(ProductoLoaginState());
          List<ProductoResp> productList=await _productoRepository.getEntidad();
          emit(ProductoLoadedState(productList));
        }catch(e){
          emit(ProductoError(e as Error));
        }
      }else if(event is UpdateProductoEvent){
        try{
          await _productoRepository.updateEntidad(event.producto!.idProducto, event.producto!);
          emit(ProductoLoaginState());
          List<ProductoResp> productList=await _productoRepository.getEntidad();
          emit(ProductoLoadedState(productList));
        }catch(e){
          emit(ProductoError(e as Error));
        }
      }else if(event is CreateProductoFormDataEvent){
        try{
          List<Marca> marcaList=await _marcaRepository.getEntidad();
          List<Categoria> categoriaList=await _categoriaRepository.getEntidad();
          List<UnidadMedida> unidadmedidaList=await _unidadMedidaRepository.getEntidad();
          emit(ProductoLoadedFormDataState(marcaList, categoriaList, unidadmedidaList));
        }catch(e){
          emit(ProductoError(e as Error));
        }
      }else if(event is FiltrarProductosEvent){
        emit(ProductoLoaginState());
        try{
          List<ProductoResp> productoList= await _productoRepository.getEntidad();
          List<ProductoResp> productosFiltrados = productoList.where((producto) {
            return producto.nombre.toLowerCase().contains(event.query.toLowerCase());
          }).toList();

          emit(ProductoLoadedFiltroState(productoList, productosFiltrados));
        } catch(e){
          emit(ProductoError(e as Error)) ;
        }
      }
    });
  }
}
