class Material {
  Material({
    this.idMaterial,
    required this.nombre,
    required this.descripcion,
    required this.unidad,
    required this.codigo,
    required this.costo,
  });

  int? idMaterial;
  String nombre;
  String descripcion;
  String unidad;
  String codigo;
  double costo;

  factory Material.fromJson(dynamic json) {
    return Material(
      idMaterial: json['id_material'] as int?,
      nombre: json['nombre'] as String? ?? '',
      descripcion: json['descripcion'] as String? ?? '',
      unidad: json['unidad'] as String? ?? '',
      codigo: json['codigo'] as String? ?? '',
      costo: json['costo'] != null ? (json['costo'] as num).toDouble() : 0.0,
    );
  }

  static List<Material> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Material.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_material': idMaterial,
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
