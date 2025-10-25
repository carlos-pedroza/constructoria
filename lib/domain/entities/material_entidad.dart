import 'package:constructoria/domain/repositories/material_queries.dart';

class MaterialEntidad {
  MaterialEntidad({
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

  factory MaterialEntidad.fromJson(dynamic json) {
    return MaterialEntidad(
      idMaterial: json['id_material'] as int?,
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

  String get query {
    if (idMaterial != null) {
      return MaterialQueries.update;
    } else {
      return MaterialQueries.create;
    }
  }

  Map<String, dynamic> data() {
    if (idMaterial != null) {
      return update();
    } else {
      return create();
    }
  }

  Map<String, dynamic> update() {
    return {
      'id': idMaterial,
      'nombre': nombre,
      'descripcion': descripcion,
      'unidad': unidad,
      'codigo': codigo,
      'costo': costo,
    };
  }

    Map<String, dynamic> create() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'unidad': unidad,
      'codigo': codigo,
      'costo': costo,
    };
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
