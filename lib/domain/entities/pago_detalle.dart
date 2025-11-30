class PagoDetalle {
  PagoDetalle({
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
    this.nombreProyecto,
    required this.concepto,
    required this.notas,
    required this.creadoEn,
    required this.actualizadoEn,
    this.beneficiarioNombre,
    this.tipoBeneficiario,
    this.metodoPago,
    this.estatusPago,
    this.formaPagoSat,
    this.moneda,
    this.aprobadoPor,
    this.aprobadorNombre,
  });

  int? idpago;
  final int idTipoBeneficiario;
  final int beneficiarioId;
  final double monto;
  final int idMoneda;
  final int idMetodoPago;
  final int idEstatusPago;
  final DateTime fechaProgramada;
  final DateTime fechaPago;
  final int idFormaPagoSat;
  final String referenciaBancaria;
  final String cuentaOrigen;
  final String cuentaDestino;
  final String documentoUrl;
  final String comprobantePagoUrl;
  final int? idProyecto;
  final String? nombreProyecto;
  final String concepto;
  final String notas;
  final DateTime creadoEn;
  final DateTime actualizadoEn;
  final String? beneficiarioNombre;
  final String? tipoBeneficiario;
  final String? metodoPago;
  final String? estatusPago;
  final String? formaPagoSat;
  final String? moneda;
  final int? aprobadoPor;
  final String? aprobadorNombre;

  factory PagoDetalle.fromJson(dynamic json) {
    return PagoDetalle(
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
      nombreProyecto: json['nombre_proyecto'] as String?,
      concepto: json['concepto'] as String,
      notas: json['notas'] as String,
      creadoEn: DateTime.parse(json['creado_en'] as String),
      actualizadoEn: DateTime.parse(json['actualizado_en'] as String),
      beneficiarioNombre: json['beneficiario_nombre'] as String?,
      tipoBeneficiario: json['tipo_beneficiario'] as String?,
      metodoPago: json['metodo_pago'] as String?,
      estatusPago: json['estatus_pago'] as String?,
      formaPagoSat: json['forma_pago_sat'] as String?,
      moneda: json['moneda'] as String?,
      aprobadoPor: json['aprobado_por'] as int?,
      aprobadorNombre: json['aprobador_nombre'] as String?,
    );
  }

  static List<PagoDetalle> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PagoDetalle.fromJson(json)).toList();
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
      'nombre_proyecto': nombreProyecto,
      'concepto': concepto,
      'notas': notas,
      'creado_en': creadoEn.toIso8601String(),
      'actualizado_en': actualizadoEn.toIso8601String(),
      'beneficiario_nombre': beneficiarioNombre,
      'tipo_beneficiario': tipoBeneficiario,
      'metodo_pago': metodoPago,
      'estatus_pago': estatusPago,
      'forma_pago_sat': formaPagoSat,
      'moneda': moneda,
      'aprobado_por': aprobadoPor,
      'aprobador_nombre': aprobadorNombre,
    };
  }

  @override
  String toString() {
    return 'PagoDetalle{idpago: $idpago, idTipoBeneficiario: $idTipoBeneficiario, beneficiarioId: $beneficiarioId, monto: $monto, idMoneda: $idMoneda, idMetodoPago: $idMetodoPago, idEstatusPago: $idEstatusPago, fechaProgramada: $fechaProgramada, fechaPago: $fechaPago, idFormaPagoSat: $idFormaPagoSat, referenciaBancaria: $referenciaBancaria, cuentaOrigen: $cuentaOrigen, cuentaDestino: $cuentaDestino, documentoUrl: $documentoUrl, comprobantePagoUrl: $comprobantePagoUrl, idProyecto: $idProyecto, nombreProyecto: $nombreProyecto, concepto: $concepto, notas: $notas, creadoEn: $creadoEn, actualizadoEn: $actualizadoEn, beneficiarioNombre: $beneficiarioNombre, tipoBeneficiario: $tipoBeneficiario, metodoPago: $metodoPago, estatusPago: $estatusPago, formaPagoSat: $formaPagoSat, moneda: $moneda, aprobadoPor: $aprobadoPor, aprobadorNombre: $aprobadorNombre}';
  }
}
