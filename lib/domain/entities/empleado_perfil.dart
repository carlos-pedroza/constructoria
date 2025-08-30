class EmpleadoPerfil {
  const EmpleadoPerfil({
    required this.idempleadoPerfil,
    required this.idempleado,
    required this.idperfil,
  });

  final int idempleadoPerfil;
  final int idempleado;
  final int idperfil;

  factory EmpleadoPerfil.fromJson(Map<String, dynamic> json) {
    return EmpleadoPerfil(
      idempleadoPerfil: json['idempleado_perfil'] as int,
      idempleado: json['idempleado'] as int,
      idperfil: json['idperfil'] as int,
    );
  }

  static List<EmpleadoPerfil> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EmpleadoPerfil.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idempleado_perfil': idempleadoPerfil,
      'idempleado': idempleado,
      'idperfil': idperfil,
    };
  }

  @override
  String toString() {
    return 'EmpleadoPerfil{idempleadoPerfil: $idempleadoPerfil, idempleado: $idempleado, idperfil: $idperfil}';
  }
}
