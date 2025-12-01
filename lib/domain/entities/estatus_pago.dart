import 'package:constructoria/domain/repositories/estatus_pago_queries.dart';
import 'package:flutter/material.dart';

class EstatusPago {
  EstatusPago({
    this.idEstatusPago,
    required this.clave,
    required this.descripcion,
  });

  int? idEstatusPago;
  final String clave;
  final String descripcion;

  static const ingresdo = 1;
  static const pendiente = 2;
  static const aprobado = 3;
  static const pagado = 4;
  static const conciliado = 5;
  static const cancelado = 6;
  

  String get Query {
    if (idEstatusPago == null) {
      return EstatusPagoQueries.createEstatusPago;
    }
    return EstatusPagoQueries.updateEstatusPago;
  }

  factory EstatusPago.fromJson(dynamic json) {
    return EstatusPago(
      idEstatusPago: json['id_estatus_pago'] as int?,
      clave: json['clave'] as String,
      descripcion: json['descripcion'] as String,
    );
  }

  factory EstatusPago.empty() {
    return EstatusPago(
      idEstatusPago: null,
      clave: '',
      descripcion: '',
    );
  }

  static List<EstatusPago> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EstatusPago.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_estatus_pago': idEstatusPago,
      'clave': clave,
      'descripcion': descripcion,
    };
  }

  Map<String, dynamic> createJson() {
    return {
      'clave': clave,
      'descripcion': descripcion,
    };
  }

  Map<String, dynamic> updateJson() {
    return {
      'id_estatus_pago': idEstatusPago,
      'clave': clave,
      'descripcion': descripcion,
    };
  }

  @override
  String toString() {
    return 'EstatusPago{idEstatusPago: $idEstatusPago, clave: $clave, descripcion: $descripcion}';
  }

  static Color getColor(int idEstatusPago) {
    switch (idEstatusPago) {
      case ingresdo:
        return Colors.blue;
      case pendiente:
        return Colors.orange;
      case aprobado:
        return Colors.green;
      case pagado:
        return Colors.teal;
      case conciliado:
        return Colors.tealAccent;
      case cancelado:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
