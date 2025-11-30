import 'package:constructoria/domain/entities/tarea_gasto.dart';
import 'package:intl/intl.dart';

class VTareaGasto {
  VTareaGasto({
    this.idtareaGasto,
    required this.idtarea,
    required this.idTipoGasto,
    required this.costo,
    required this.creado,
    required this.idproyecto,
    required this.code,
    required this.tareaDescripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.idempleado,
    required this.idestadoTarea,
    required this.avance,
    required this.orden,
    required this.tipoGastoNombre,
    required this.tipoGastoDescripcion,
    required this.tipoGastoCodigo,
    required this.tipoGastoCosto,
  });

  int? idtareaGasto;
  int idtarea;
  int idTipoGasto;
  double costo;
  DateTime creado;
  int idproyecto;
  String code;
  String tareaDescripcion;
  DateTime fechaInicio;
  DateTime fechaFin;
  int idempleado;
  int idestadoTarea;
  double avance;
  int orden;
  String tipoGastoNombre;
  String tipoGastoDescripcion;
  String tipoGastoCodigo;
  double tipoGastoCosto;

  factory VTareaGasto.fromJson(dynamic json) {
    return VTareaGasto(
      idtareaGasto: json['idtarea_gasto'] as int?,
      idtarea: json['idtarea'] as int,
      idTipoGasto: json['id_tipo_gasto'] as int,
      costo: json['costo'] != null ? (json['costo'] as num).toDouble() : 0.0,
      creado: json['creado'] != null ? DateTime.parse(json['creado']) : DateTime.now(),
      idproyecto: json['idproyecto'] as int,
      code: json['code'] as String? ?? '',
      tareaDescripcion: json['tarea_descripcion'] as String? ?? '',
      fechaInicio: json['fecha_inicio'] != null ? DateTime.parse(json['fecha_inicio']) : DateTime.now(),
      fechaFin: json['fecha_fin'] != null ? DateTime.parse(json['fecha_fin']) : DateTime.now(),
      idempleado: json['idempleado'] as int,
      idestadoTarea: json['idestado_tarea'] as int,
      avance: json['avance'] != null ? (json['avance'] as num).toDouble() : 0.0,
      orden: json['orden'] as int? ?? 0,
      tipoGastoNombre: json['tipo_gasto_nombre'] as String? ?? '',
      tipoGastoDescripcion: json['tipo_gasto_descripcion'] as String? ?? '',
      tipoGastoCodigo: json['tipo_gasto_codigo'] as String? ?? '',
      tipoGastoCosto: json['tipo_gasto_costo'] != null ? (json['tipo_gasto_costo'] as num).toDouble() : 0.0,
    );
  }

  static List<VTareaGasto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => VTareaGasto.fromJson(json)).toList();
  }

  TareaGasto toTareaGasto() {
    return TareaGasto(
      idtareaGasto: idtareaGasto,
      idtarea: idtarea,
      idTipoGasto: idTipoGasto,
      costo: costo,
      creado: creado,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idtarea_gasto': idtareaGasto,
      'idtarea': idtarea,
      'id_tipo_gasto': idTipoGasto,
      'costo': costo,
      'creado': DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado),
      'idproyecto': idproyecto,
      'code': code,
      'tarea_descripcion': tareaDescripcion,
      'fecha_inicio': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaInicio),
      'fecha_fin': DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechaFin),
      'idempleado': idempleado,
      'idestado_tarea': idestadoTarea,
      'avance': avance,
      'orden': orden,
      'tipo_gasto_nombre': tipoGastoNombre,
      'tipo_gasto_descripcion': tipoGastoDescripcion,
      'tipo_gasto_codigo': tipoGastoCodigo,
      'tipo_gasto_costo': tipoGastoCosto,
    };
  }
}