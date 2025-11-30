class FormaPagoSat {
  FormaPagoSat({
    this.idFormaPagoSat,
    required this.clave,
    required this.descripcion,
  });

  int? idFormaPagoSat;
  final String clave;
  final String descripcion;

  factory FormaPagoSat.fromJson(dynamic json) {
    return FormaPagoSat(
      idFormaPagoSat: json['id_forma_pago_sat'] as int?,
      clave: json['clave'] as String,
      descripcion: json['descripcion'] as String,
    );
  }

  factory FormaPagoSat.empty() {
    return FormaPagoSat(
      idFormaPagoSat: null,
      clave: '',
      descripcion: '',
    );
  }

  static List<FormaPagoSat> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FormaPagoSat.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_forma_pago_sat': idFormaPagoSat,
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
      'id_forma_pago_sat': idFormaPagoSat,
      'clave': clave,
      'descripcion': descripcion,
    };
  }

  @override
  String toString() {
    return 'FormaPagoSat{idFormaPagoSat: $idFormaPagoSat, clave: $clave, descripcion: $descripcion}';
  }
}
