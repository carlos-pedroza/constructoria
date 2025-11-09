class Moneda {
  final int? idMoneda;
  final String clave;
  final String descripcion;
  final String? simbolo;

  Moneda({
    this.idMoneda,
    required this.clave,
    required this.descripcion,
    this.simbolo,
  });

  factory Moneda.fromJson(Map<String, dynamic> json) {
    return Moneda(
      idMoneda: json['id_moneda'],
      clave: json['clave'],
      descripcion: json['descripcion'],
      simbolo: json['simbolo'],
    );
  }

  static List<Moneda> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Moneda.fromJson(json)).toList();
  }
}
