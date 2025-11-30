class FormaPagoSatQueries {
  static const String getAllFormaPagoSats = '''
    query {
      formaPagoSats {
        id_forma_pago_sat
        clave
        descripcion
      }
    }
    ''';

  static const String getFormaPagoSatById = '''
    query GetFormaPagoSatById(
      \$id_forma_pago_sat: Int!
    ) {
      formaPagoSat(id_forma_pago_sat: \$id_forma_pago_sat) {
        id_forma_pago_sat
        clave
        descripcion
      }
    }
    ''';

  static const String createFormaPagoSat = '''
    mutation CreateFormaPagoSat(
      \$clave: String!,
      \$descripcion: String!
    ) {
      createFormaPagoSat(input: {
        clave: \$clave,
        descripcion: \$descripcion
      }) {
        id_forma_pago_sat
        clave
        descripcion
      }
    }
    ''';

  static const String updateFormaPagoSat = '''
    mutation UpdateFormaPagoSat(
      \$id_forma_pago_sat: Int!,
      \$clave: String!,
      \$descripcion: String!
    ) {
      updateFormaPagoSat(id_forma_pago_sat: \$id_forma_pago_sat, input: {
        clave: \$clave,
        descripcion: \$descripcion
      }) {
        id_forma_pago_sat
        clave
        descripcion
      }
    }
    ''';

  static const String deleteFormaPagoSat = '''
    mutation RemoveFormaPagoSat(\$id_forma_pago_sat: Int!) {
      removeFormaPagoSat(id_forma_pago_sat: \$id_forma_pago_sat)
    }
    ''';
}
