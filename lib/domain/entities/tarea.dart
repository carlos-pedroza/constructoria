import 'package:constructoria/domain/repositories/tarea_queries.dart';
import 'package:intl/intl.dart';
import 'estado_tarea.dart';

class Tarea {
  Tarea({
    this.idtarea,
    required this.idproyecto,
    required this.code,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.idempleado,
    this.empleado,
    required this.idestadoTarea,
    required this.avance,
    this.estadoTarea,
    this.orden = 0,
    required this.costoPorHora,
  });

  int? idtarea;
  final int idproyecto;
  String code;
  String descripcion;
  DateTime fechaInicio;
  DateTime fechaFin;
  int idempleado;
  final String? empleado;
  int idestadoTarea;
  double avance;
  EstadoTarea? estadoTarea;
  final double costoPorHora;
  int orden;

  double get costoTotalManoObra {
    return (horasTrabajadas * costoPorHora) * avance;
  }

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

  factory Tarea.fromJson(dynamic json) {
    String? empleadoNombre;
    if (json['empleado'] != null) {
      if (json['empleado'] is Map) {
        final e = json['empleado'];
        empleadoNombre = [e['nombre'], e['apellido_paterno'], e['apellido_materno']]
          .where((v) => v != null && (v as String).isNotEmpty)
          .join(' ');
      } else if (json['empleado'] is String) {
        empleadoNombre = json['empleado'] as String;
      }
    }
    return Tarea(
      idtarea: json['idtarea'] as int?,
      idproyecto: json['idproyecto'] as int,
      code: json['code'] as String? ?? '',
      descripcion: json['descripcion'] as String? ?? '',
      fechaInicio: json['fecha_inicio'] != null
          ? DateTime.parse(json['fecha_inicio'])
          : DateTime.now(),
      fechaFin: json['fecha_fin'] != null
          ? DateTime.parse(json['fecha_fin'])
          : DateTime.now(),
      idempleado: json['idempleado'] as int,
      empleado: empleadoNombre,
      idestadoTarea: json['idestado_tarea'] as int,
      avance: json['avance'] != null ? (json['avance'] as num).toDouble() : 0.0,
      estadoTarea: json['estadoTarea'] != null
          ? EstadoTarea.fromJson(json['estadoTarea'])
          : null,
      orden: json['orden'] as int? ?? 0,
      costoPorHora: json['empleado'] != null && json['empleado']['costo_por_hora'] != null
          ? (json['empleado']['costo_por_hora'] as num).toDouble()
          : 0.0,
    );
  }

  static List<Tarea> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Tarea.fromJson(json)).toList();
  }

  static Tarea newItem({ required int idproyecto, String code = '', String descripcion = '', DateTime? fechaInicio, DateTime? fechaFin, int idempleado = 0, int idestadoTarea = EstadoTarea.pendiente, double avance = 0.0 }) {
    return Tarea(
      idproyecto: idproyecto,
      code: code,
      descripcion: descripcion,
      fechaInicio: fechaInicio ?? DateTime.now(),
      fechaFin: fechaFin ?? DateTime.now(),
      idempleado: idempleado,
      idestadoTarea: idestadoTarea,
      avance: avance,
      costoPorHora: 0.0,
    );
  }

  String get query {
    if (idtarea == null) {
      return TareaQueries.createTarea;
    }
    return TareaQueries.updateTarea;
  }

  Map<String, dynamic> data(int NOrden) {
    if(idtarea == null) {
      return createJson(NOrden);
    }
    return updateJson(NOrden);
  }

  Map<String, dynamic> createJson(int NOrden) {
    return {
      'idproyecto': idproyecto,
      'code': code,
      'descripcion': descripcion,
      'fecha_inicio': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaInicio),
      'fecha_fin': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaFin),
      'idempleado': idempleado,
      'idestado_tarea': EstadoTarea.pendiente,
      'avance': avance,
      'orden': NOrden,
    };
  }

  Map<String, dynamic> updateJson(int NOrden) {
    return {
      'id': idtarea,
      'idproyecto': idproyecto,
      'code': code,
      'descripcion': descripcion,
      'fecha_inicio': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaInicio),
      'fecha_fin': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaFin),
      'idempleado': idempleado,
      'idestado_tarea': idestadoTarea,
      'avance': avance,
      'orden': NOrden,
    };
  }

  Map<String, dynamic> update() {
    return {
      'id': idtarea,
      'idproyecto': idproyecto,
      'code': code,
      'descripcion': descripcion,
      'fecha_inicio': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaInicio),
      'fecha_fin': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaFin),
      'idempleado': idempleado,
      'idestado_tarea': idestadoTarea,
      'avance': avance,
      'orden': orden,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'idtarea': idtarea,
      'idproyecto': idproyecto,
      'code': code,
      'descripcion': descripcion,
      'fecha_inicio': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaInicio),
      'fecha_fin': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaFin),
      'idempleado': idempleado,
      'idestado_tarea': idestadoTarea,
      'avance': avance,
      'orden': orden,
    };
  }

  @override
  String toString() {
    return '$code\t$descripcion\t${DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaInicio)}\t${DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaFin)}';
  }
}