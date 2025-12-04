class Pago {
  Pago({
    this.idpago,
    required this.idTipoBeneficiario,
    required this.beneficiarioId,
    required this.monto,
    required this.idMoneda,
    required this.idMetodoPago,
    required this.idEstatusPago,
    required this.fechaProgramada,
    required this.fechaPago,
    required this.idFormaPagoSat,
    required this.referenciaBancaria,
    required this.cuentaOrigen,
    required this.cuentaDestino,
    required this.documentoUrl,
    required this.comprobantePagoUrl,
    this.idProyecto,
    required this.concepto,
    required this.notas,
    required this.creadoEn,
    required this.actualizadoEn,
    this.aprobadoPor,
  });

  int? idpago;
  final int idTipoBeneficiario;
  final int beneficiarioId;
  final double monto;
  final int idMoneda;
  final int idMetodoPago;
  int idEstatusPago;
  final DateTime fechaProgramada;
  final DateTime fechaPago;
  final int idFormaPagoSat;
  final String referenciaBancaria;
  final String cuentaOrigen;
  final String cuentaDestino;
  final String documentoUrl;
  final String comprobantePagoUrl;
  final int? idProyecto;
  final String concepto;
  final String notas;
  final DateTime creadoEn;
  final DateTime actualizadoEn;
  final int? aprobadoPor;

  factory Pago.fromJson(dynamic json) {
    return Pago(
      idpago: json['idpago'] as int?,
      idTipoBeneficiario: json['id_tipo_beneficiario'] as int,
      beneficiarioId: json['beneficiario_id'] as int,
      monto: (json['monto'] as num).toDouble(),
      idMoneda: json['id_moneda'] as int,
      idMetodoPago: json['id_metodo_pago'] as int,
      idEstatusPago: json['id_estatus_pago'] as int,
      fechaProgramada: DateTime.parse(json['fecha_programada'] as String),
      fechaPago: DateTime.parse(json['fecha_pago'] as String),
      idFormaPagoSat: json['id_forma_pago_sat'] as int,
      referenciaBancaria: json['referencia_bancaria'] as String,
      cuentaOrigen: json['cuenta_origen'] as String,
      cuentaDestino: json['cuenta_destino'] as String,
      documentoUrl: json['documento_url'] as String,
      comprobantePagoUrl: json['comprobante_pago_url'] as String,
      idProyecto: json['idproyecto'] as int?,
      concepto: json['concepto'] as String,
      notas: json['notas'] as String,
      creadoEn: DateTime.parse(json['creado_en'] as String),
      actualizadoEn: DateTime.parse(json['actualizado_en'] as String),
      aprobadoPor: json['aprobado_por'] as int?,
    );
  }

  factory Pago.empty() {
    return Pago(
      idpago: null,
      idTipoBeneficiario: 0,
      beneficiarioId: 0,
      monto: 0.0,
      idMoneda: 0,
      idMetodoPago: 0,
      idEstatusPago: 1,
      fechaProgramada: DateTime.now(),
      fechaPago: DateTime.now(),
      idFormaPagoSat: 0,
      referenciaBancaria: '',
      cuentaOrigen: '',
      cuentaDestino: '',
      documentoUrl: '',
      comprobantePagoUrl: '',
      idProyecto: null,
      concepto: '',
      notas: '',
      creadoEn: DateTime.now(),
      actualizadoEn: DateTime.now(),
      aprobadoPor: null,
    );
  }

  static List<Pago> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Pago.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idpago': idpago,
      'id_tipo_beneficiario': idTipoBeneficiario,
      'beneficiario_id': beneficiarioId,
      'monto': monto,
      'id_moneda': idMoneda,
      'id_metodo_pago': idMetodoPago,
      'id_estatus_pago': idEstatusPago,
      'fecha_programada': fechaProgramada.toIso8601String(),
      'fecha_pago': fechaPago.toIso8601String(),
      'id_forma_pago_sat': idFormaPagoSat,
      'referencia_bancaria': referenciaBancaria,
      'cuenta_origen': cuentaOrigen,
      'cuenta_destino': cuentaDestino,
      'documento_url': documentoUrl,
      'comprobante_pago_url': comprobantePagoUrl,
      'idproyecto': idProyecto,
      'concepto': concepto,
      'notas': notas,
      'creado_en': creadoEn.toIso8601String(),
      'actualizado_en': actualizadoEn.toIso8601String(),
      'aprobado_por': aprobadoPor,
    };
  }

  @override
  String toString() {
    return 'Pago{idpago: $idpago, idTipoBeneficiario: $idTipoBeneficiario, beneficiarioId: $beneficiarioId, monto: $monto, idMoneda: $idMoneda, idMetodoPago: $idMetodoPago, idEstatusPago: $idEstatusPago, fechaProgramada: $fechaProgramada, fechaPago: $fechaPago, idFormaPagoSat: $idFormaPagoSat, referenciaBancaria: $referenciaBancaria, cuentaOrigen: $cuentaOrigen, cuentaDestino: $cuentaDestino, documentoUrl: $documentoUrl, comprobantePagoUrl: $comprobantePagoUrl, idProyecto: $idProyecto, concepto: $concepto, notas: $notas, creadoEn: $creadoEn, actualizadoEn: $actualizadoEn, aprobadoPor: $aprobadoPor}';
  }
}
