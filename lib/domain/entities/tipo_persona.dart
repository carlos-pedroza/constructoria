class TipoPersona {
  final int? idTipoPersona;
  final String clave;
  final String descripcion;

  TipoPersona({
    this.idTipoPersona,
    required this.clave,
    required this.descripcion,
  });

  factory TipoPersona.fromJson(Map<String, dynamic> json) {
    return TipoPersona(
      idTipoPersona: json['id_tipo_persona'],
      clave: json['clave'],
      descripcion: json['descripcion'],
    );
  }

  static List<TipoPersona> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TipoPersona.fromJson(json)).toList();
  }
}
