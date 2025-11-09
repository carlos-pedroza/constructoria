class Proveedor {
  final int? idProveedor;
  final String rfc;
  final String razonSocial;
  final String? nombreComercial;
  final int idTipoPersona;
  final String? telefono;
  final String? correoElectronico;
  final String? paginaWeb;
  final String? contactoNombre;
  final String? contactoPuesto;
  final String? calle;
  final String? numeroExterior;
  final String? numeroInterior;
  final String? colonia;
  final String? municipio;
  final String? estado;
  final String? pais;
  final String? codigoPostal;
  final String? banco;
  final String? cuentaBancaria;
  final String? clabe;
  final int? idTipoCuenta;
  final int? idMoneda;
  final String? usoCfdi;
  final String? metodoPago;
  final String? formaPago;
  final int diasCredito;
  final double? limiteCredito;
  final bool retencionIva;
  final bool retencionIsr;
  final bool activo;
  final DateTime? fechaAlta;
  final DateTime? fechaActualizacion;
  final String? notas;
  final String? responsableLegalNombre;
  final String? responsableLegalPuesto;
  final String? responsableLegalTelefono;
  final String? responsableLegalCorreo;
  final String? responsableLegalIdentificacion;
  final String? responsableLegalRfc;
  final int? creadoPor;
  final int? actualizadoPor;

  Proveedor({
    this.idProveedor,
    required this.rfc,
    required this.razonSocial,
    this.nombreComercial,
    required this.idTipoPersona,
    this.telefono,
    this.correoElectronico,
    this.paginaWeb,
    this.contactoNombre,
    this.contactoPuesto,
    this.calle,
    this.numeroExterior,
    this.numeroInterior,
    this.colonia,
    this.municipio,
    this.estado,
    this.pais,
    this.codigoPostal,
    this.banco,
    this.cuentaBancaria,
    this.clabe,
    this.idTipoCuenta,
    this.idMoneda,
    this.usoCfdi,
    this.metodoPago,
    this.formaPago,
    this.diasCredito = 0,
    this.limiteCredito,
    this.retencionIva = false,
    this.retencionIsr = false,
    this.activo = true,
    this.fechaAlta,
    this.fechaActualizacion,
    this.notas,
    this.responsableLegalNombre,
    this.responsableLegalPuesto,
    this.responsableLegalTelefono,
    this.responsableLegalCorreo,
    this.responsableLegalIdentificacion,
    this.responsableLegalRfc,
    this.creadoPor,
    this.actualizadoPor,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      idProveedor: json['id_proveedor'],
      rfc: json['rfc'],
      razonSocial: json['razon_social'],
      nombreComercial: json['nombre_comercial'],
      idTipoPersona: json['id_tipo_persona'],
      telefono: json['telefono'],
      correoElectronico: json['correo_electronico'],
      paginaWeb: json['pagina_web'],
      contactoNombre: json['contacto_nombre'],
      contactoPuesto: json['contacto_puesto'],
      calle: json['calle'],
      numeroExterior: json['numero_exterior'],
      numeroInterior: json['numero_interior'],
      colonia: json['colonia'],
      municipio: json['municipio'],
      estado: json['estado'],
      pais: json['pais'],
      codigoPostal: json['codigo_postal'],
      banco: json['banco'],
      cuentaBancaria: json['cuenta_bancaria'],
      clabe: json['clabe'],
      idTipoCuenta: json['id_tipo_cuenta'],
      idMoneda: json['id_moneda'],
      usoCfdi: json['uso_cfdi'],
      metodoPago: json['metodo_pago'],
      formaPago: json['forma_pago'],
      diasCredito: json['dias_credito'] ?? 0,
      limiteCredito: json['limite_credito'] != null ? (json['limite_credito'] as num).toDouble() : null,
      retencionIva: json['retencion_iva'] == 1,
      retencionIsr: json['retencion_isr'] == 1,
      activo: json['activo'] == 1,
      fechaAlta: json['fecha_alta'] != null ? DateTime.parse(json['fecha_alta']) : null,
      fechaActualizacion: json['fecha_actualizacion'] != null ? DateTime.parse(json['fecha_actualizacion']) : null,
      notas: json['notas'],
      responsableLegalNombre: json['responsable_legal_nombre'],
      responsableLegalPuesto: json['responsable_legal_puesto'],
      responsableLegalTelefono: json['responsable_legal_telefono'],
      responsableLegalCorreo: json['responsable_legal_correo'],
      responsableLegalIdentificacion: json['responsable_legal_identificacion'],
      responsableLegalRfc: json['responsable_legal_rfc'],
      creadoPor: json['creado_por'],
      actualizadoPor: json['actualizado_por'],
    );
  }

  static List<Proveedor> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Proveedor.fromJson(json)).toList();
  }
}
