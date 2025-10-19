import 'package:intl/intl.dart';

class TareaMaterial {
  TareaMaterial({
    this.idtareaMaterial,
    required this.idtarea,
    required this.idMaterial,
    required this.cantidad,
    required this.costo,
    required this.creado,
  });

  int? idtareaMaterial;
  int idtarea;
  int idMaterial;
  int cantidad;
  double costo;
  DateTime creado;

  factory TareaMaterial.fromJson(dynamic json) {
    return TareaMaterial(
      idtareaMaterial: json['idtarea_material'] as int?,
      idtarea: json['idtarea'] as int,
      idMaterial: json['id_material'] as int,
      cantidad: json['cantidad'] as int,
      costo: json['costo'] != null ? (json['costo'] as num).toDouble() : 0.0,
      creado: json['creado'] != null ? DateTime.parse(json['creado']) : DateTime.now(),
    );
  }

  static List<TareaMaterial> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TareaMaterial.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idtarea_material': idtareaMaterial,
      'idtarea': idtarea,
      'id_material': idMaterial,
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
