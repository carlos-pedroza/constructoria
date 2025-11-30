class PagoQueries {
  static const String getAllPagos = '''
    query {
      pagos {
        idpago
        id_tipo_beneficiario
        beneficiario_id
        monto
        id_moneda
        id_metodo_pago
        id_estatus_pago
        fecha_programada
        fecha_pago
        id_forma_pago_sat
        referencia_bancaria
        cuenta_origen
        cuenta_destino
        documento_url
        comprobante_pago_url
        idproyecto
        concepto
        notas
        creado_en
        actualizado_en
        aprobado_por
      }
    }
    ''';

  static const String getPagoById = '''
    query GetPagoById(
      \$idpago: Int!
    ) {
      pago(id: \$idpago) {
        idpago
        id_tipo_beneficiario
        beneficiario_id
        monto
        id_moneda
        id_metodo_pago
        id_estatus_pago
        fecha_programada
        fecha_pago
        id_forma_pago_sat
        referencia_bancaria
        cuenta_origen
        cuenta_destino
        documento_url
        comprobante_pago_url
        idproyecto
        concepto
        notas
        creado_en
        actualizado_en
        aprobado_por
      }
    }
    ''';

  static const String createPago = '''
    mutation CreatePago(
      \$input: PagoInput!
    ) {
      createPago(input: \$input) {
        idpago
        id_tipo_beneficiario
        beneficiario_id
        monto
        id_moneda
        id_metodo_pago
        id_estatus_pago
        fecha_programada
        fecha_pago
        id_forma_pago_sat
        referencia_bancaria
        cuenta_origen
        cuenta_destino
        documento_url
        comprobante_pago_url
        idproyecto
        concepto
        notas
        creado_en
        actualizado_en
        aprobado_por
      }
    }
    ''';

  static const String updatePago = '''
    mutation UpdatePago(
      \$idpago: Int!,
      \$input: PagoInput!
    ) {
      updatePago(id: \$idpago, input: \$input) {
        idpago
        id_tipo_beneficiario
        beneficiario_id
        monto
        id_moneda
        id_metodo_pago
        id_estatus_pago
        fecha_programada
        fecha_pago
        id_forma_pago_sat
        referencia_bancaria
        cuenta_origen
        cuenta_destino
        documento_url
        comprobante_pago_url
        idproyecto
        concepto
        notas
        creado_en
        actualizado_en
        aprobado_por
      }
    }
    ''';

  static const String deletePago = '''
    mutation RemovePago(\$idpago: Int!) {
      removePago(id: \$idpago)
    }
    ''';

  static const String getAllPagoDetalleView = '''
    query {
      pagoDetalleView {
        idpago
        id_tipo_beneficiario
        beneficiario_id
        monto
        id_moneda
        id_metodo_pago
        id_estatus_pago
        fecha_programada
        fecha_pago
        id_forma_pago_sat
        referencia_bancaria
        cuenta_origen
        cuenta_destino
        documento_url
        comprobante_pago_url
        idproyecto
        nombre_proyecto
        concepto
        notas
        creado_en
        actualizado_en
        beneficiario_nombre
        tipo_beneficiario
        metodo_pago
        estatus_pago
        forma_pago_sat
        moneda
        aprobado_por
        aprobador_nombre
      }
    }
    ''';

  static const String getPagoDetalleViewByFilter = '''
    query PagoDetalleViewByFilter(
      \$id_estatus_pago: Int!,
      \$fecha_programada_inicio: String,
      \$fecha_programada_fin: String,
      \$fecha_pago_inicio: String,
      \$fecha_pago_fin: String
    ) {
      pagoDetalleViewByFilter(
        id_estatus_pago: \$id_estatus_pago,
        fecha_programada_inicio: \$fecha_programada_inicio,
        fecha_programada_fin: \$fecha_programada_fin,
        fecha_pago_inicio: \$fecha_pago_inicio,
        fecha_pago_fin: \$fecha_pago_fin
      ) {
        idpago
        id_tipo_beneficiario
        beneficiario_id
        monto
        id_moneda
        id_metodo_pago
        id_estatus_pago
        fecha_programada
        fecha_pago
        id_forma_pago_sat
        referencia_bancaria
        cuenta_origen
        cuenta_destino
        documento_url
        comprobante_pago_url
        idproyecto
        nombre_proyecto
        concepto
        notas
        creado_en
        actualizado_en
        beneficiario_nombre
        tipo_beneficiario
        metodo_pago
        estatus_pago
        forma_pago_sat
        moneda
        aprobado_por
        aprobador_nombre
      }
    }
    ''';
}
