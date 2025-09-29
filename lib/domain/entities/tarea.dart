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
  });

  int? idtarea;
  final int idproyecto;
  final String code;
  final String descripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final int idempleado;
  final String? empleado;
  final int idestadoTarea;
  final double avance;
  final EstadoTarea? estadoTarea;
  int orden;

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
    );
  }

  static List<Tarea> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Tarea.fromJson(json)).toList();
  }

  static Tarea newItem({ required int idproyecto}) {
    return Tarea(
      idproyecto: idproyecto,
      code: '',
      descripcion: '',
      fechaInicio: DateTime.now(),
      fechaFin: DateTime.now(),
      idempleado: 0,
      idestadoTarea: 0,
      avance: 0.0,
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
    return 'Tarea{idtarea: $idtarea, idproyecto: $idproyecto, code: $code, descripcion: $descripcion, fechaInicio: $fechaInicio, fechaFin: $fechaFin, idempleado: $idempleado, idestadoTarea: $idestadoTarea, avance: $avance, estadoTarea: $estadoTarea}';
  }
}