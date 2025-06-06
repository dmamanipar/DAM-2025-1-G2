
import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ventas_app/bloc/producto/producto_bloc.dart';
import 'package:ventas_app/comp/DropDownFormField.dart';
import 'package:ventas_app/modelo/ProductoModelo.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ProductoFormEditB extends StatefulWidget {
  ProductoResp modelA;
  ProductoFormEditB({required this.modelA}):super();
  @override
  _ProductoFormEditState createState() => _ProductoFormEditState(modelA: modelA);
}

class _ProductoFormEditState extends State<ProductoFormEditB> {
  ProductoResp modelA;
  _ProductoFormEditState({required this.modelA}):super();

  TextEditingController _fecha = new TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Position? currentPosition;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  late String _nombreProducto="";
  late double _pu=0;
  late double _puOld=0;
  late double _utilidad=0;
  late double _stock=0;
  late double _stockOld=0;
  late String _categoria=modelA.categoria.idCategoria.toString();
  late String _marca=modelA.marca.idMarca.toString();
  late String _unidadmedida=modelA.unidadMedida.idUnidad.toString();


  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  @override
  void initState(){
    super.initState();
    BlocProvider.of<ProductoBloc>(context).add(CreateProductoFormDataEvent());
  }

  void capturaNombrePro(valor){ this._nombreProducto=valor;}
  void capturaPu(valor){ this._pu=valor;}
  void capturaPuOld(valor){ this._puOld=valor;}
  void capturaUtilidad(valor){ this._utilidad=valor;}
  void capturaStock(valor){ this._stock=valor;}
  void capturaStockOld(valor){ this._stockOld=valor;}
  void capturaCategoria(valor){ this._categoria=valor;}
  void capturaMarca(valor){ this._marca=valor;}
  void capturaUnidadMedida(valor){ this._unidadmedida=valor;}



  late List<Map<String, String>> categorias = [];
  late List<Map<String, String>> marcas = [];
  late List<Map<String, String>> unidades = [];

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Act. ProductoB"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body:  BlocBuilder<ProductoBloc,ProductoState>(
        builder: (context,state){
          if(state is ProductoLoadedFormDataState){

            marcas = state.marcaList.map((datos) => {'value': '${datos.idMarca}', 'display': '${datos.nombre}'}).toList();
            categorias = state.categoriaList.map((datos) => {'value': '${datos.idCategoria}', 'display': '${datos.nombre}'}).toList();
            unidades = state.unidadMedidaList.map((datos) => {'value': '${datos.idUnidad}', 'display': '${datos.nombreMedida}'}).toList();

            return SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.all(24),
                    //color: AppTheme.nearlyWhite,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          _buildDatoCadena(capturaNombrePro, modelA.nombre, "Nombre Producto:"),

                          _buildDatoDecimal(capturaPu, modelA.pu.toString() ,"Precio. Unitario"),
                          _buildDatoDecimal(capturaPuOld, modelA.puOld.toString() ,"Precio. Unit. Anterior"),
                          _buildDatoDecimal(capturaUtilidad, modelA.utilidad.toString() ,"Utilidad"),
                          _buildDatoDecimal(capturaStock, modelA.stock.toString() ,"Stock Actual"),
                          _buildDatoDecimal(capturaStockOld, modelA.stockOld.toString() ,"Stock. Anterior"),

                          _buildDatoLista(capturaCategoria,_categoria=modelA.categoria.idCategoria.toString(), "Categoria:", categorias),
                          _buildDatoLista(capturaMarca,_marca=modelA.marca.idMarca.toString(), "Marca:", marcas),
                          _buildDatoLista(capturaUnidadMedida,_unidadmedida=modelA.unidadMedida.idUnidad.toString(), "Unidad Medida:", unidades),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<ProductoBloc>(context).add(ListarProductoEvent());
                                      Navigator.pop(context, true);
                                    },
                                    child: Text('Cancelar')),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Processing Data'),
                                        ),
                                      );
                                      _formKey.currentState!.save();
                                      ProductoDto mp = new ProductoDto.unlaunched();
                                      /*mp.latitud=currentPosition!.latitude.toString();
                                mp.longitud=currentPosition!.longitude.toString();*/
                                      /*final prefs= await SharedPreferences.getInstance();
                                mp.userCreate = "${prefs.getString('usernameLogin')}";*/

                                      mp.nombre = _nombreProducto;
                                      mp.idProducto=modelA.idProducto;
                                      mp.pu=_pu;
                                      mp.puOld=_puOld;
                                      mp.utilidad=_utilidad;
                                      mp.stock=_stock;
                                      mp.stockOld=_stockOld;
                                      mp.categoria=int.parse(_categoria);
                                      mp.marca=int.parse(_marca);
                                      mp.unidadMedida=int.parse(_unidadmedida);

                                      BlocProvider.of<ProductoBloc>(context).add(UpdateProductoEvent(mp));
                                      Navigator.pop(context, () {
                                        setState(() {
                                          BlocProvider.of<ProductoBloc>(context).add(FiltrarProductosEvent(""));
                                        });
                                      });

                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'No estan bien los datos de los campos!'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Guardar'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )));
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

    );
  }

  Widget _buildDatoEntero(Function obtValor, String _dato,String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _dato,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoDecimal(Function obtValor, String _dato,String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _dato,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(double.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor,String _dato, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _dato,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget _buildDatoLista(Function obtValor,_dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }

Widget _buildDatoListaDos(Function obtValor,_dato, String labelx, List<dynamic> listaDato){
  return DropdownButtonFormField<dynamic>(
    value: _dato,
    items: listaDato.map((cat) {
      return DropdownMenuItem(value: cat, child: Text(cat.nombre));
    }).toList(),
    onChanged: (value) => setState(() => _dato = value),
    decoration: InputDecoration(labelText: labelx),
    validator: (value) => value == null ? 'Seleccione un item' : null,
  );
}
  Future<void> _selectDate(BuildContext context, Function obtValor) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        obtValor(selectedDate.toString());
      });
    }
  }
  Widget _buildDatoFecha(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: _fecha,
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: (){
        _selectDate(context,obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }
  Future<void> _selectTime(BuildContext context,Function obtValor) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child){
          return MediaQuery(
            data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        }
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        //obtValor("${selectedTime!.hour}:${selectedTime!.minute}");
        obtValor("${(selectedTime!.hour)<10?"0"+(selectedTime!.hour).toString():selectedTime!.hour}:${(selectedTime!.minute)<10?"0"+(selectedTime!.minute).toString():selectedTime!.minute}:00");
        //_horai.text="${selectedTime!.hour}:${selectedTime!.minute}";
      });
    }
  }
  Widget _buildDatoHora(Function obtValor, Function capControl, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: capControl(),
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: (){
        _selectTime(context, obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
        //_horai.text=value!;
      },
    );
  }
  Future<bool> permiso() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
  Future<void>  getCurrentLocation() async {
    final hasPermission = await permiso();
    if (!hasPermission) {
      return;
    }
    if (mounted){
      Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true)
          .then((Position position) {
        if(mounted){
          setState(() {
            currentPosition = position;
            //getCurrentLocationAddress();
          });
        }
      }).catchError((e) {
        print(e);
      });
    }
  }

}