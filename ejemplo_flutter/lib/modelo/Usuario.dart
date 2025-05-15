class Usuario {
  int? iD;
  String? nOMBRE;
  String? aPELLIDOS;
  int? dNI;
  int? iDPERFIL;
  String? nOMBREPERFIL;
  String? eSTADOPERFIL;

  Usuario(
      {this.iD,
        this.nOMBRE,
        this.aPELLIDOS,
        this.dNI,
        this.iDPERFIL,
        this.nOMBREPERFIL,
        this.eSTADOPERFIL});

  Usuario.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nOMBRE = json['NOMBRE'];
    aPELLIDOS = json['APELLIDOS'];
    dNI = json['DNI'];
    iDPERFIL = json['ID_PERFIL'];
    nOMBREPERFIL = json['NOMBRE_PERFIL'];
    eSTADOPERFIL = json['ESTADO_PERFIL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NOMBRE'] = this.nOMBRE;
    data['APELLIDOS'] = this.aPELLIDOS;
    data['DNI'] = this.dNI;
    data['ID_PERFIL'] = this.iDPERFIL;
    data['NOMBRE_PERFIL'] = this.nOMBREPERFIL;
    data['ESTADO_PERFIL'] = this.eSTADOPERFIL;
    return data;
  }
}