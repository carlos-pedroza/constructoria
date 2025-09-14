class Perfil {
  Perfil({
    required this.idperfil,
    required this.code,
    required this.nombre,
    this.acceso = false,
    this.idempleadoPerfil,
  });

  final int idperfil;
  final String code;
  final String nombre;
  bool acceso = false;
  int? idempleadoPerfil;

  factory Perfil.fromJson(Map<String, dynamic> json) {
    return Perfil(
      idperfil: json['idperfil'] as int,
      code: json['code'] as String,
      nombre: json['nombre'] as String,
    );
  }

  static List<Perfil> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Perfil.fromJson(json)).toList();
  }

  Perfil copyWith({
    int? idperfil,
    String? code,
    String? nombre,
    bool? acceso,
    int? idempleadoPerfil,
  }) {
    return Perfil(
      idperfil: idperfil ?? this.idperfil,
      code: code ?? this.code,
      nombre: nombre ?? this.nombre,
      acceso: acceso ?? this.acceso,
      idempleadoPerfil: idempleadoPerfil ?? this.idempleadoPerfil,
    );
  }

  Map<String, dynamic> toJson() {
    if (idperfil == 0) {
      return createJson();
    }
    return updateJson();
  }

  Map<String, dynamic> createJson() {
    return {'nombre': nombre};
  }

  Map<String, dynamic> updateJson() {
    return {'idperfil': idperfil, 'nombre': nombre};
  }

  @override
  String toString() {
    return 'Perfil{idperfil: $idperfil, nombre: $nombre}';
  }
}
