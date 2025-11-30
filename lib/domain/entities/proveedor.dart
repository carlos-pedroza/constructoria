import 'package:constructoria/domain/entities/tipo_persona.dart';
import 'package:constructoria/domain/entities/tipo_cuenta.dart';
import 'package:constructoria/domain/entities/moneda.dart';
import 'package:constructoria/domain/repositories/proveedor_queries.dart';
class Proveedor {
  final int? idProveedor;
  final String rfc;
  final String razonSocial;
  final String nombreComercial;
  final int idTipoPersona;
  final TipoPersona? tipoPersona;
  final String telefono;
  final String correoElectronico;
  final String paginaWeb;
  final String contactoNombre;
  final String contactoPuesto;
  final String calle;
  final String numeroExterior;
  final String numeroInterior;
  final String colonia;
  final String municipio;
  final String estado;
  final String pais;
  final String codigoPostal;
  final String banco;
  final String cuentaBancaria;
  final String clabe;
  final int idTipoCuenta;
  final TipoCuenta? tipoCuenta;
  final int idMoneda;
  final Moneda? moneda;
  final String usoCfdi;
  final String metodoPago;
  final String formaPago;
  final int diasCredito;
  final double limiteCredito;
  final bool retencionIva;
  final bool retencionIsr;
  final bool activo;
  final DateTime fechaAlta;
  final DateTime fechaActualizacion;
  final String notas;
  final String responsableLegalNombre;
  final String responsableLegalPuesto;
  final String responsableLegalTelefono;
  final String responsableLegalCorreo;
  final String responsableLegalIdentificacion;
  final String responsableLegalRfc;
  final int creadoPor;
  final int actualizadoPor;

  Proveedor({
    this.idProveedor,
    this.rfc = '',
    this.razonSocial = '',
    this.nombreComercial = '',
    this.idTipoPersona = 0,
    this.tipoPersona,
    this.telefono = '',
    this.correoElectronico = '',
    this.paginaWeb = '',
    this.contactoNombre = '',
    this.contactoPuesto = '',
    this.calle = '',
    this.numeroExterior = '',
    this.numeroInterior = '',
    this.colonia = '',
    this.municipio = '',
    this.estado = '',
    this.pais = '',
    this.codigoPostal = '',
    this.banco = '',
    this.cuentaBancaria = '',
    this.clabe = '',
    this.idTipoCuenta = 0,
    this.tipoCuenta,
    this.idMoneda = 0,
    this.moneda,
    this.usoCfdi = '',
    this.metodoPago = '',
    this.formaPago = '',
    this.diasCredito = 0,
    this.limiteCredito = 0.0,
    this.retencionIva = false,
    this.retencionIsr = false,
    this.activo = true,
    DateTime? fechaAlta,
    DateTime? fechaActualizacion,
    this.notas = '',
    this.responsableLegalNombre = '',
    this.responsableLegalPuesto = '',
    this.responsableLegalTelefono = '',
    this.responsableLegalCorreo = '',
    this.responsableLegalIdentificacion = '',
    this.responsableLegalRfc = '',
    this.creadoPor = 0,
    this.actualizadoPor = 0,
  })  : fechaAlta = fechaAlta ?? DateTime.now(),
        fechaActualizacion = fechaActualizacion ?? DateTime.now();

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      idProveedor: json['id_proveedor'],
      rfc: json['rfc'] ?? '',
      razonSocial: json['razon_social'] ?? '',
      nombreComercial: json['nombre_comercial'] ?? '',
      idTipoPersona: json['id_tipo_persona'] ?? 0,
      tipoPersona: json['tipo_persona'] != null ? TipoPersona.fromJson(json['tipo_persona']) : null,
      telefono: json['telefono'] ?? '',
      correoElectronico: json['correo_electronico'] ?? '',
      paginaWeb: json['pagina_web'] ?? '',
      contactoNombre: json['contacto_nombre'] ?? '',
      contactoPuesto: json['contacto_puesto'] ?? '',
      calle: json['calle'] ?? '',
      numeroExterior: json['numero_exterior'] ?? '',
      numeroInterior: json['numero_interior'] ?? '',
      colonia: json['colonia'] ?? '',
      municipio: json['municipio'] ?? '',
      estado: json['estado'] ?? '',
      pais: json['pais'] ?? '',
      codigoPostal: json['codigo_postal'] ?? '',
      banco: json['banco'] ?? '',
      cuentaBancaria: json['cuenta_bancaria'] ?? '',
      clabe: json['clabe'] ?? '',
      idTipoCuenta: json['id_tipo_cuenta'] ?? 0,
      tipoCuenta: json['tipo_cuenta'] != null ? TipoCuenta.fromJson(json['tipo_cuenta']) : null,
      idMoneda: json['id_moneda'] ?? 0,
      moneda: json['moneda'] != null ? Moneda.fromJson(json['moneda']) : null,
      usoCfdi: json['uso_cfdi'] ?? '',
      metodoPago: json['metodo_pago'] ?? '',
      formaPago: json['forma_pago'] ?? '',
      diasCredito: json['dias_credito'] ?? 0,
      limiteCredito: json['limite_credito'] != null ? (json['limite_credito'] as num).toDouble() : 0.0,
      retencionIva: json['retencion_iva'] == true || json['retencion_iva'] == 1,
      retencionIsr: json['retencion_isr'] == true || json['retencion_isr'] == 1,
      activo: json['activo'] == true || json['activo'] == 1,
      fechaAlta: json['fecha_alta'] != null ? DateTime.parse(json['fecha_alta']) : null,
      fechaActualizacion: json['fecha_actualizacion'] != null ? DateTime.parse(json['fecha_actualizacion']) : null,
      notas: json['notas'] ?? '',
      responsableLegalNombre: json['responsable_legal_nombre'] ?? '',
      responsableLegalPuesto: json['responsable_legal_puesto'] ?? '',
      responsableLegalTelefono: json['responsable_legal_telefono'] ?? '',
      responsableLegalCorreo: json['responsable_legal_correo'] ?? '',
      responsableLegalIdentificacion: json['responsable_legal_identificacion'] ?? '',
      responsableLegalRfc: json['responsable_legal_rfc'] ?? '',
      creadoPor: json['creado_por'] ?? 0,
      actualizadoPor: json['actualizado_por'] ?? 0,
    );
  }

  static List<Proveedor> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Proveedor.fromJson(json)).toList();
  }

  static Proveedor empty() {
    return Proveedor(
      rfc: '',
      razonSocial: '',
      idTipoPersona: 0,
    );
  }

  String get query {
    if(idProveedor == null) {
      return ProveedorQueries.createProveedor;
    }
    return ProveedorQueries.updateProveedor;
  }

  Map<String, dynamic> data() {
    if(idProveedor == null) {
      return create();
    }
    return update();  
  }

  Map<String, dynamic> create() {
    return {
      "input": {
        "rfc": rfc,
        "razon_social": razonSocial,
        "nombre_comercial": nombreComercial,
        "id_tipo_persona": idTipoPersona,
        "telefono": telefono,
        "correo_electronico": correoElectronico,
        "pagina_web": paginaWeb,
        "contacto_nombre": contactoNombre,
        "contacto_puesto": contactoPuesto,
        "calle": calle,
        "numero_exterior": numeroExterior,
        "numero_interior": numeroInterior,
        "colonia": colonia,
        "municipio": municipio,
        "estado": estado,
        "pais": pais,
        "codigo_postal": codigoPostal,
        "banco": banco,
        "cuenta_bancaria": cuentaBancaria,
        "clabe": clabe,
        "id_tipo_cuenta": idTipoCuenta,
        "id_moneda": idMoneda,
        "uso_cfdi": usoCfdi,
        "metodo_pago": metodoPago,
        "forma_pago": formaPago,
        "dias_credito": diasCredito,
        "limite_credito": limiteCredito,
        "retencion_iva": retencionIva,
        "retencion_isr": retencionIsr,
        "activo": activo,
        "notas": notas,
        "responsable_legal_nombre": responsableLegalNombre,
        "responsable_legal_puesto": responsableLegalPuesto,
        "responsable_legal_telefono": responsableLegalTelefono,
        "responsable_legal_correo": responsableLegalCorreo,
        "responsable_legal_identificacion": responsableLegalIdentificacion,
        "responsable_legal_rfc": responsableLegalRfc,
        "creado_por": 1,
        "actualizado_por": 1
      }
    };
  }

  Map<String, dynamic> update() {
    return {
      "id_proveedor": idProveedor,
      "input": {
        "rfc": rfc,
        "razon_social": razonSocial,
        "nombre_comercial": nombreComercial,
        "id_tipo_persona": idTipoPersona,
        "telefono": telefono,
        "correo_electronico": correoElectronico,
        "pagina_web": paginaWeb,
        "contacto_nombre": contactoNombre,
        "contacto_puesto": contactoPuesto,
        "calle": calle,
        "numero_exterior": numeroExterior,
        "numero_interior": numeroInterior,
        "colonia": colonia,
        "municipio": municipio,
        "estado": estado,
        "pais": pais,
        "codigo_postal": codigoPostal,
        "banco": banco,
        "cuenta_bancaria": cuentaBancaria,
        "clabe": clabe,
        "id_tipo_cuenta": idTipoCuenta,
        "id_moneda": idMoneda,
        "uso_cfdi": usoCfdi,
        "metodo_pago": metodoPago,
        "forma_pago": formaPago,
        "dias_credito": diasCredito,
        "limite_credito": limiteCredito,
        "retencion_iva": retencionIva,
        "retencion_isr": retencionIsr,
        "activo": activo,
        "notas": notas,
        "responsable_legal_nombre": responsableLegalNombre,
        "responsable_legal_puesto": responsableLegalPuesto,
        "responsable_legal_telefono": responsableLegalTelefono,
        "responsable_legal_correo": responsableLegalCorreo,
        "responsable_legal_identificacion": responsableLegalIdentificacion,
        "responsable_legal_rfc": responsableLegalRfc,
        "creado_por": 1,
        "actualizado_por": 1
      }
    };
  }
}
