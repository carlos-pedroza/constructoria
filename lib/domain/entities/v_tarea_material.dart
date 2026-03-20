import 'package:constructoria/domain/entities/periodo.dart';
import 'package:constructoria/domain/entities/tarea_material.dart';
import 'package:constructoria/domain/entities/tipo_valor.dart';

class VTareaMaterial {
    VTareaMaterial({
    required this.idtareaMaterial,
    required this.idtarea,
    required this.idMaterial,
    required this.idPeriodo,
    required this.idTipoValor,
    required this.periodoNombre,
    required this.tipoValorNombre,
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
    required this.subtotal, 
    required this.startDate, 
    required this.endDate,
  });

  final int idtareaMaterial;
  final int idtarea;
  final int idMaterial;
  final int idPeriodo;
  final int idTipoValor;
  final String periodoNombre;
  final String tipoValorNombre;
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
  final double subtotal;
  final DateTime startDate;
  final DateTime endDate;

  double get total {
    if (idTipoValor == TipoValor.calculado && idPeriodo == Periodo.mensual) {
      final days = endDate.difference(startDate).inDays;
      return subtotal * (days * avance);
    }
    return subtotal;
  }

  factory VTareaMaterial.fromJson(Map<String, dynamic> json, {required DateTime startDate, required DateTime endDate}) {
    return VTareaMaterial(
      idtareaMaterial: json['idtarea_material'],
      idtarea: json['idtarea'],
      idMaterial: json['id_material'],
      idPeriodo: json['idperiodo'] as int? ?? 1,
      idTipoValor: json['idtipo_valor'] as int? ?? 1,
      periodoNombre: json['periodo_nombre'] as String? ?? '',
      tipoValorNombre: json['tipo_valor_nombre'] as String? ?? '',
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
      subtotal: (json['total'] as num).toDouble(),
      startDate: startDate,
      endDate: endDate,
    );
  }

  static List<VTareaMaterial> fromJsonList(List<dynamic> jsonList, {required DateTime startDate, required DateTime endDate}) {
    return jsonList.map((json) => VTareaMaterial.fromJson(json, startDate: startDate, endDate: endDate)).toList();
  }

  TareaMaterial toTareaMaterial() {
    return TareaMaterial(
      idtareaMaterial: idtareaMaterial,
      idtarea: idtarea,
      idMaterial: idMaterial,
      idPeriodo: idPeriodo,
      idTipoValor: idTipoValor,
      cantidad: cantidad.toInt(),
      costo: costo,
      creado: creado,
    );
  }
}
