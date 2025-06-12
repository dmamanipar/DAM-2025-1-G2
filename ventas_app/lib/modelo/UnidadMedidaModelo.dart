import 'package:floor/floor.dart';

@Entity(tableName: 'unidadmedida')
class UnidadMedida {
  UnidadMedida({
    required this.idUnidad,
    required this.nombreMedida,
  });
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'id_unidad')
  late final int idUnidad;
  @ColumnInfo(name: 'nombre_medida')
  late final String nombreMedida;
  UnidadMedida.crear():idUnidad=0, nombreMedida="";
  factory UnidadMedida.fromJson(Map<String, dynamic> json){
    return UnidadMedida(
      idUnidad: json["idUnidad"],
      nombreMedida: json["nombreMedida"],
    );
  }

  Map<String, dynamic> toJson() => {
    "idUnidad": idUnidad,
    "nombreMedida": nombreMedida,
  };

}
