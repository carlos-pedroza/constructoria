import 'package:constructoria/domain/entities/periodo.dart';
import 'package:constructoria/domain/entities/tarea_gasto.dart';
import 'package:constructoria/domain/entities/tipo_valor.dart';
import 'package:intl/intl.dart';

class VTareaGasto {
  VTareaGasto({
    this.idtareaGasto,
    required this.idtarea,
    required this.idTipoGasto,
    required this.idPeriodo,
    required this.idTipoValor,
    required this.periodoNombre,
    required this.tipoValorNombre,
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
    required this.startDate,
    required this.endDate,
  });

  int? idtareaGasto;
  int idtarea;
  int idTipoGasto;
  int idPeriodo;
  int idTipoValor;
  String periodoNombre;
  String tipoValorNombre;
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
  DateTime startDate;
  DateTime endDate;

  double get total {
    if (idTipoValor == TipoValor.calculado && idPeriodo == Periodo.mensual) {
      final days = endDate.difference(startDate).inDays;
      return tipoGastoCosto * (days * avance);
    }
    return tipoGastoCosto;
  }

  factory VTareaGasto.fromJson(dynamic json, {required DateTime startDate, required DateTime endDate}) {
    return VTareaGasto(
      idtareaGasto: json['idtarea_gasto'] as int?,
      idtarea: json['idtarea'] as int,
      idTipoGasto: json['id_tipo_gasto'] as int,
      idPeriodo: json['idperiodo'] as int? ?? 1,
      idTipoValor: json['idtipo_valor'] as int? ?? 1,
      periodoNombre: json['periodo_nombre'] as String? ?? '',
      tipoValorNombre: json['tipo_valor_nombre'] as String? ?? '',
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
      startDate: startDate,
      endDate: endDate,
    );
  }

  static List<VTareaGasto> fromJsonList(List<dynamic> jsonList, {required DateTime startDate, required DateTime endDate}) {
    return jsonList.map((json) => VTareaGasto.fromJson(json, startDate: startDate, endDate: endDate)).toList();
  }

  TareaGasto toTareaGasto() {
    return TareaGasto(
      idtareaGasto: idtareaGasto,
      idtarea: idtarea,
      idTipoGasto: idTipoGasto,
      idPeriodo: idPeriodo,
      idTipoValor: idTipoValor,
      costo: costo,
      creado: creado,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idtarea_gasto': idtareaGasto,
      'idtarea': idtarea,
      'id_tipo_gasto': idTipoGasto,
      'idperiodo': idPeriodo,
      'idtipo_valor': idTipoValor,
      'periodo_nombre': periodoNombre,
      'tipo_valor_nombre': tipoValorNombre,
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