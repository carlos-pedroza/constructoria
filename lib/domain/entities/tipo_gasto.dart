class TipoGasto {
  TipoGasto({
    this.idTipoGasto,
    required this.nombre,
    required this.descripcion,
    required this.codigo,
    required this.costo,
  });

  int? idTipoGasto;
  String nombre;
  String descripcion;
  String codigo;
  double costo;

  factory TipoGasto.fromJson(dynamic json) {
    return TipoGasto(
      idTipoGasto: json['id_tipo_gasto'] as int?,
      nombre: json['nombre'] as String? ?? '',
      descripcion: json['descripcion'] as String? ?? '',
      codigo: json['codigo'] as String? ?? '',
      costo: json['costo'] != null ? (json['costo'] as num).toDouble() : 0.0,
    );
  }

  static List<TipoGasto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TipoGasto.fromJson(json)).toList();
  }

  Map<String, dynamic> data() {
    if(idTipoGasto != null) {
      return toJson();
    } else {
      return create();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id_tipo_gasto': idTipoGasto,
      'nombre': nombre,
      'descripcion': descripcion,
      'codigo': codigo,
      'costo': costo,
    };
  }

  Map<String, dynamic> create() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'codigo': codigo,
      'costo': costo,
    };
  }

  @override
  String toString() {
    return '$codigo\t$nombre\t$costo';
  }
}
