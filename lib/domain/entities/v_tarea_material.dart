import 'package:constructoria/domain/entities/tarea_material.dart';

class VTareaMaterial {
    VTareaMaterial({
    required this.idtareaMaterial,
    required this.idtarea,
    required this.idMaterial,
    required this.cantidad,
    required this.costo,
    required this.creado,
    required this.nombre,
    required this.descripcion,
    required this.unidad,
    required this.codigo,
    required this.costoSugerido,
    required this.idproyecto,
    required this.tareaCode,
    required this.tareaDescripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.idempleado,
    required this.idestadoTarea,
    required this.avance,
    required this.orden,
  });

  final int idtareaMaterial;
  final int idtarea;
  final int idMaterial;
  final double cantidad;
  final double costo;
  final DateTime creado;
  final String nombre;
  final String descripcion;
  final String unidad;
  final String codigo;
  final double costoSugerido;
  final int idproyecto;
  final String tareaCode;
  final String tareaDescripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final int idempleado;
  final int idestadoTarea;
  final double avance;
  final int orden;

  factory VTareaMaterial.fromJson(Map<String, dynamic> json) {
    return VTareaMaterial(
      idtareaMaterial: json['idtarea_material'],
      idtarea: json['idtarea'],
      idMaterial: json['id_material'],
      cantidad: (json['cantidad'] as num).toDouble(),
      costo: (json['costo'] as num).toDouble(),
      creado: DateTime.parse(json['creado']),
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      unidad: json['unidad'],
      codigo: json['codigo'],
      costoSugerido: (json['costo_sugerido'] as num).toDouble(),
      idproyecto: json['idproyecto'],
      tareaCode: json['tarea_code'],
      tareaDescripcion: json['tarea_descripcion'],
      fechaInicio: DateTime.parse(json['fecha_inicio']),
      fechaFin: DateTime.parse(json['fecha_fin']),
      idempleado: json['idempleado'],
      idestadoTarea: json['idestado_tarea'],
      avance: (json['avance'] as num).toDouble(),
      orden: json['orden'],
    );
  }

  static List<VTareaMaterial> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => VTareaMaterial.fromJson(json)).toList();
  }

  TareaMaterial toTareaMaterial() {
    return TareaMaterial(
      idtareaMaterial: idtareaMaterial,
      idtarea: idtarea,
      idMaterial: idMaterial,
      cantidad: cantidad.toInt(),
      costo: costo,
      creado: creado,
    );
  }
}
