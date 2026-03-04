import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/repositories/tarea_material_queries.dart';
import 'package:intl/intl.dart';

class TareaMaterial {
  TareaMaterial({
    this.idtareaMaterial,
    required this.idtarea,
    required this.idMaterial,
    required this.idPeriodo,
    required this.idTipoValor,
    required this.cantidad,
    required this.costo,
    required this.creado,
  });

  int? idtareaMaterial;
  int idtarea;
  int idMaterial;
  int idPeriodo;
  int idTipoValor;
  int cantidad;
  double costo;
  DateTime creado;

  String get query {
    if(idtareaMaterial == null) {
      return TareaMaterialQueries.create;
    } else {
      return TareaMaterialQueries.update;
    }
  }

  factory TareaMaterial.fromJson(dynamic json) {
    return TareaMaterial(
      idtareaMaterial: json['idtarea_material'] as int?,
      idtarea: json['idtarea'] as int,
      idMaterial: json['id_material'] as int,
      idPeriodo: json['idperiodo'] as int? ?? 1,
      idTipoValor: json['idtipo_valor'] as int? ?? 1,
      cantidad: json['cantidad'] as int,
      costo: json['costo'] != null ? (json['costo'] as num).toDouble() : 0.0,
      creado: json['creado'] != null ? DateTime.parse(json['creado']) : DateTime.now(),
    );
  }

  static List<TareaMaterial> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TareaMaterial.fromJson(json)).toList();
  }

  factory TareaMaterial.empty(Tarea tarea) {
    return TareaMaterial(
      idtareaMaterial: null,
      idtarea: tarea.idtarea!,
      idMaterial: 0,
      idPeriodo: 1,
      idTipoValor: 1,
      cantidad: 0,
      costo: 0.0,
      creado: DateTime.now(),
    );
  }

  Map<String, dynamic> data() {
    if(idtareaMaterial == null) {
      return create();
    } else {
      return update();
    }
  }


  Map<String, dynamic> create() {
    final input = <String, dynamic>{
      'idtarea': idtarea,
      'id_material': idMaterial,
      'idperiodo': idPeriodo,
      'idtipo_valor': idTipoValor,
      'cantidad': cantidad,
      'costo': costo,
      'creado': DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado),
    };

    return {'input': input};
  }

  Map<String, dynamic> update() {
    final input = <String, dynamic>{
      'idtarea': idtarea,
      'id_material': idMaterial,
      'idperiodo': idPeriodo,
      'idtipo_valor': idTipoValor,
      'cantidad': cantidad,
      'costo': costo,
      'creado': DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado),
    };

    return {'id': idtareaMaterial, 'input': input};
  }

  Map<String, dynamic> toJson() {
    return {
      'idtarea_material': idtareaMaterial,
      'idtarea': idtarea,
      'id_material': idMaterial,
      'idperiodo': idPeriodo,
      'idtipo_valor': idTipoValor,
      'cantidad': cantidad,
      'costo': costo,
      'creado': DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado),
    };
  }

  @override
  String toString() {
    return '$idMaterial\t$cantidad\t$costo\t${DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado)}';
  }
}