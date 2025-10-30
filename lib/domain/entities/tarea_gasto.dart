import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/repositories/tarea_gasto_queries.dart';
import 'package:intl/intl.dart';

class TareaGasto {
  TareaGasto({
    this.idtareaGasto,
    required this.idtarea,
    required this.idTipoGasto,
    required this.costo,
    required this.creado,
  });

  int? idtareaGasto;
  int idtarea;
  int? idTipoGasto;
  double costo;
  DateTime creado;

  String get query {
    if(idtareaGasto == null) {
      return TareaGastoQueries.create;
    } else {
      return TareaGastoQueries.update;
    }
  }

  factory TareaGasto.fromJson(dynamic json) {
    return TareaGasto(
      idtareaGasto: json['idtarea_gasto'] as int?,
      idtarea: json['idtarea'] as int,
      idTipoGasto: json['id_tipo_gasto'] as int,
      costo: json['costo'] != null ? (json['costo'] as num).toDouble() : 0.0,
      creado: json['creado'] != null ? DateTime.parse(json['creado']) : DateTime.now(),
    );
  }

  factory TareaGasto.empty(Tarea tarea) {
    return TareaGasto(
      idtareaGasto: null,
      idtarea: tarea.idtarea!,
      idTipoGasto: null,
      costo: 0.0,
      creado: DateTime.now(),
    );
  }

  static List<TareaGasto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TareaGasto.fromJson(json)).toList();
  }

  Map<String, dynamic> data() {
    if(idtareaGasto == null) {
      return create();
    } else {
      return toJson();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'idtarea_gasto': idtareaGasto,
      'idtarea': idtarea,
      'id_tipo_gasto': idTipoGasto,
      'costo': costo,
      'creado': DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado),
    };
  }

  Map<String, dynamic> create() {
    return {
      "idtarea": idtarea,
      "id_tipo_gasto": idTipoGasto,
      "costo": costo,
      "creado": DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado)
    };
  }

  @override
  String toString() {
    return '$idTipoGasto\t$costo\t${DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado)}';
  }
}
