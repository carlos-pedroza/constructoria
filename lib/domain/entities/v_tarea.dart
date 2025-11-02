import 'package:constructoria/domain/entities/tarea.dart';

class VTarea {
  VTarea({
    required this.idtarea,
    required this.idproyecto,
    required this.code,
    required this.tareaDescripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.idempleado,
    required this.empleadoNombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.costoPorHora,
    required this.activo,
    required this.idestadoTarea,
    required this.estadoTareaNombre,
    required this.estadoTareaDescripcion,
    required this.avance,
    required this.totalManoObra,
    required this.totalManoObraAvance,
    required this.orden,
  });

  final int idtarea;
  final int idproyecto;
  final String code;
  final String tareaDescripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final int idempleado;
  final String empleadoNombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final double costoPorHora;
  final bool activo;
  int idestadoTarea;
  String estadoTareaNombre;
  final String estadoTareaDescripcion;
  double avance;
  final double totalManoObra;
  final double totalManoObraAvance;
  final int orden;

  double get horasTrabajadas {
    int totalDiasHabiles = 0;
    DateTime actual = fechaInicio;
    while (!actual.isAfter(fechaFin)) {
      // Lunes=1, ..., Viernes=5
      if (actual.weekday >= DateTime.monday && actual.weekday <= DateTime.friday) {
        totalDiasHabiles++;
      }
      actual = actual.add(Duration(days: 1));
    }
    // Si la tarea inicia y termina el mismo día, considerar solo la diferencia de horas de ese día
    if (fechaInicio.year == fechaFin.year && fechaInicio.month == fechaFin.month && fechaInicio.day == fechaFin.day) {
      double horas = fechaFin.difference(fechaInicio).inHours.toDouble();
      return horas > 8 ? 8 : (horas < 0 ? 0 : horas);
    }
    return totalDiasHabiles * 8.0;
  }

  String get responsable {
    return '$empleadoNombre $apellidoPaterno $apellidoMaterno';
  }

  factory VTarea.fromJson(Map<String, dynamic> json) {
    return VTarea(
      idtarea: json['idtarea'],
      idproyecto: json['idproyecto'],
      code: json['code'],
      tareaDescripcion: json['tarea_descripcion'],
      fechaInicio: DateTime.parse(json['fecha_inicio']),
      fechaFin: DateTime.parse(json['fecha_fin']),
      idempleado: json['idempleado'],
      empleadoNombre: json['empleado_nombre'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      costoPorHora: (json['costo_por_hora'] as num).toDouble(),
      activo: json['activo'] == 1,
      idestadoTarea: json['idestado_tarea'],
      estadoTareaNombre: json['estado_tarea_nombre'],
      estadoTareaDescripcion: json['estado_tarea_descripcion'],
      avance: (json['avance'] as num).toDouble(),
      totalManoObra: (json['total_mano_obra'] as num).toDouble(),
      totalManoObraAvance: (json['total_mano_obra_avance'] as num).toDouble(),
      orden: json['orden'],
    );
  }

  static List<VTarea> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => VTarea.fromJson(json)).toList();
  }

  Tarea toTarea() {
    return Tarea(
      idtarea: idtarea,
      idproyecto: idproyecto,
      code: code,
      descripcion: tareaDescripcion,
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
      idempleado: idempleado,
      idestadoTarea: idestadoTarea,
      avance: avance,
      costoPorHora: costoPorHora,
      orden: orden
    );
  }
}