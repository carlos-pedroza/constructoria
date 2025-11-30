class MetodoPago {
  MetodoPago({
    this.idMetodoPago,
    required this.clave,
    required this.descripcion,
  });

  int? idMetodoPago;
  final String clave;
  final String descripcion;

  factory MetodoPago.fromJson(dynamic json) {
    return MetodoPago(
      idMetodoPago: json['id_metodo_pago'] as int?,
      clave: json['clave'] as String,
      descripcion: json['descripcion'] as String,
    );
  }

  factory MetodoPago.empty() {
    return MetodoPago(
      idMetodoPago: null,
      clave: '',
      descripcion: '',
    );
  }

  static List<MetodoPago> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MetodoPago.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_metodo_pago': idMetodoPago,
      'clave': clave,
      'descripcion': descripcion,
    };
  }

  Map<String, dynamic> createJson() {
    return {
      'clave': clave,
      'descripcion': descripcion,
    };
  }

  Map<String, dynamic> updateJson() {
    return {
      'id_metodo_pago': idMetodoPago,
      'clave': clave,
      'descripcion': descripcion,
    };
  }

  @override
  String toString() {
    return 'MetodoPago{idMetodoPago: $idMetodoPago, clave: $clave, descripcion: $descripcion}';
  }
}
