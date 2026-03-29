class PagoResumenEstatusMoneda {
  PagoResumenEstatusMoneda({
    required this.idEstatusPago,
    this.estatusPago,
    required this.idMoneda,
    this.moneda,
    required this.montoTotal,
    required this.pagosCount,
  });

  final int idEstatusPago;
  final String? estatusPago;
  final int idMoneda;
  final String? moneda;
  final double montoTotal;
  final int pagosCount;

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  factory PagoResumenEstatusMoneda.fromJson(dynamic json) {
    return PagoResumenEstatusMoneda(
      idEstatusPago: _toInt(json['id_estatus_pago']),
      estatusPago: json['estatus_pago'] as String?,
      idMoneda: _toInt(json['id_moneda']),
      moneda: json['moneda'] as String?,
      montoTotal: _toDouble(json['monto_total']),
      pagosCount: _toInt(json['pagos_count']),
    );
  }

  static List<PagoResumenEstatusMoneda> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PagoResumenEstatusMoneda.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_estatus_pago': idEstatusPago,
      'estatus_pago': estatusPago,
      'id_moneda': idMoneda,
      'moneda': moneda,
      'monto_total': montoTotal,
      'pagos_count': pagosCount,
    };
  }

  @override
  String toString() {
    return 'PagoResumenEstatusMoneda{idEstatusPago: $idEstatusPago, estatusPago: $estatusPago, idMoneda: $idMoneda, moneda: $moneda, montoTotal: $montoTotal, pagosCount: $pagosCount}';
  }
}
