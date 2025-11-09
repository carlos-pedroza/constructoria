class TipoCuenta {
  final int? idTipoCuenta;
  final String clave;
  final String descripcion;

  TipoCuenta({
    this.idTipoCuenta,
    required this.clave,
    required this.descripcion,
  });

  factory TipoCuenta.fromJson(Map<String, dynamic> json) {
    return TipoCuenta(
      idTipoCuenta: json['id_tipo_cuenta'],
      clave: json['clave'],
      descripcion: json['descripcion'],
    );
  }

  static List<TipoCuenta> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TipoCuenta.fromJson(json)).toList();
  }
}
