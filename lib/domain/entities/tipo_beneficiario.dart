class TipoBeneficiario {
  TipoBeneficiario({
    this.idTipoBeneficiario,
    required this.clave,
    required this.descripcion,
  });

  int? idTipoBeneficiario;
  final String clave;
  final String descripcion;

  static const proveedor = 1;
  static const empleado = 2; 

  factory TipoBeneficiario.fromJson(dynamic json) {
    return TipoBeneficiario(
      idTipoBeneficiario: json['id_tipo_beneficiario'] as int?,
      clave: json['clave'] as String,
      descripcion: json['descripcion'] as String,
    );
  }

  factory TipoBeneficiario.empty() {
    return TipoBeneficiario(
      idTipoBeneficiario: null,
      clave: '',
      descripcion: '',
    );
  }

  static List<TipoBeneficiario> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TipoBeneficiario.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_tipo_beneficiario': idTipoBeneficiario,
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
      'id_tipo_beneficiario': idTipoBeneficiario,
      'clave': clave,
      'descripcion': descripcion,
    };
  }

  @override
  String toString() {
    return 'TipoBeneficiario{idTipoBeneficiario: $idTipoBeneficiario, clave: $clave, descripcion: $descripcion}';
  }
}
