class Perfil {
  const Perfil({required this.idperfil, required this.nombre});

  final int idperfil;
  final String nombre;

  factory Perfil.fromJson(Map<String, dynamic> json) {
    return Perfil(
      idperfil: json['idperfil'] as int,
      nombre: json['nombre'] as String,
    );
  }

  static List<Perfil> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Perfil.fromJson(json)).toList();
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
