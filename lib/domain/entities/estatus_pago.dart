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

  static const ingresado = 1;
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

  factory EstatusPago.todos() {
    return EstatusPago(
      idEstatusPago: 0,
      clave: 'T',
      descripcion: 'Todos',
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

  static List<EstatusPago> getEstatusPagoList() {
    return [
      EstatusPago(
        idEstatusPago: ingresado,
        clave: 'ING',
        descripcion: 'Ingresado',
      ),
      EstatusPago(
        idEstatusPago: pendiente,
        clave: 'PEN',
        descripcion: 'Pendiente de Aprobación',
      ),
      EstatusPago(
        idEstatusPago: aprobado,
        clave: 'APR',
        descripcion: 'Aprobado',
      ),
      EstatusPago(
        idEstatusPago: pagado,
        clave: 'PAG',
        descripcion: 'Pagado',
      ),
      EstatusPago(
        idEstatusPago: conciliado,
        clave: 'CON',
        descripcion: 'Conciliado',
      ),
      EstatusPago(
        idEstatusPago: cancelado,
        clave: 'CAN',
        descripcion: 'Cancelado',
      ),
    ];
  }

  static List<EstatusPago> getEstatusPagoListProceso() {
    return [
      EstatusPago(
        idEstatusPago: 0,
        clave: 'T',
        descripcion: 'Todos',
      ),
      EstatusPago(
        idEstatusPago: ingresado,
        clave: 'ING',
        descripcion: 'Ingresado',
      ),
      EstatusPago(
        idEstatusPago: pendiente,
        clave: 'PEN',
        descripcion: 'Pendiente de Aprobación',
      ),
      EstatusPago(
        idEstatusPago: aprobado,
        clave: 'APR',
        descripcion: 'Aprobado',
      ),
    ];
  }

  static List<EstatusPago> getEstatusPagoListPagado() {
    return [
      EstatusPago(
        idEstatusPago: 0,
        clave: 'T',
        descripcion: 'Todos',
      ),
      EstatusPago(
        idEstatusPago: pagado,
        clave: 'PAG',
        descripcion: 'Pagado',
      ),
      EstatusPago(
        idEstatusPago: conciliado,
        clave: 'CON',
        descripcion: 'Conciliado',
      ),
      EstatusPago(
        idEstatusPago: cancelado,
        clave: 'CAN',
        descripcion: 'Cancelado',
      ),
    ];
  }

  static String  displayName(int idEstatusPago) {
    switch (idEstatusPago) {
      case ingresado:
        return 'Ingresado';
      case pendiente:
        return 'Pendiente de Aprobación';
      case aprobado:
        return 'Aprobado';
      case pagado:
        return 'Pagado';
      case conciliado:
        return 'Conciliado';
      case cancelado:
        return 'Cancelado';
      default:
        return '';
    }
  }

  static int nextId(int idEstatusPago) {
    switch (idEstatusPago) {
      case ingresado:
        return pendiente;
      case pendiente:
        return aprobado;
      case aprobado:
        return pagado;
      case pagado:
        return conciliado;
      case conciliado :
        return conciliado;
      case cancelado:
        return cancelado;
      default:
        return 0;
    }
  }

  static String nextEstatus(int idEstatusPago) {
    switch (idEstatusPago) {
      case ingresado:
        return 'Cambiar a pendiente de aprobación';
      case pendiente:
        return 'Aprobar Pago';
      case aprobado:
        return 'Marcar como Pagado';
      case pagado:
        return 'Cambiar a pago Conciliado';
      case conciliado:
        return 'Conciliado';
      case cancelado:
        return 'Cancelado';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return 'EstatusPago{idEstatusPago: $idEstatusPago, clave: $clave, descripcion: $descripcion}';
  }

  static Color getColor(int idEstatusPago) {
    switch (idEstatusPago) {
      case ingresado:
        return Colors.blueGrey;
      case pendiente:
        return Colors.orange;
      case aprobado:
        return Colors.green;
      case pagado:
        return Colors.teal;
      case conciliado:
        return Colors.blueAccent;
      case cancelado:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
