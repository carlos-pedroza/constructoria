class MaterialEntidad {
  MaterialEntidad({
    this.idMaterialEntidad,
    required this.nombre,
    required this.descripcion,
    required this.unidad,
    required this.codigo,
    required this.costo,
  });

  int? idMaterialEntidad;
  String nombre;
  String descripcion;
  String unidad;
  String codigo;
  double costo;

  factory MaterialEntidad.fromJson(dynamic json) {
    return MaterialEntidad(
      idMaterialEntidad: json['id_MaterialEntidad'] as int?,
      nombre: json['nombre'] as String? ?? '',
      descripcion: json['descripcion'] as String? ?? '',
      unidad: json['unidad'] as String? ?? '',
      codigo: json['codigo'] as String? ?? '',
      costo: json['costo'] != null ? (json['costo'] as num).toDouble() : 0.0,
    );
  }

  static List<MaterialEntidad> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MaterialEntidad.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_MaterialEntidad': idMaterialEntidad,
      'nombre': nombre,
      'descripcion': descripcion,
      'unidad': unidad,
      'codigo': codigo,
      'costo': costo,
    };
  }

  @override
  String toString() {
    return '$codigo\t$nombre\t$costo';
  }
}
