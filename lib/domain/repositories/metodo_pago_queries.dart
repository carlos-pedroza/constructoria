class MetodoPagoQueries {
  static const String getAllMetodoPagos = '''
    query {
      metodoPagos {
        id_metodo_pago
        clave
        descripcion
      }
    }
    ''';

  static const String getMetodoPagoById = '''
    query GetMetodoPagoById(
      \$id_metodo_pago: Int!
    ) {
      metodoPago(id_metodo_pago: \$id_metodo_pago) {
        id_metodo_pago
        clave
        descripcion
      }
    }
    ''';

  static const String createMetodoPago = '''
    mutation CreateMetodoPago(
      \$clave: String!,
      \$descripcion: String!
    ) {
      createMetodoPago(input: {
        clave: \$clave,
        descripcion: \$descripcion
      }) {
        id_metodo_pago
        clave
        descripcion
      }
    }
    ''';

  static const String updateMetodoPago = '''
    mutation UpdateMetodoPago(
      \$id_metodo_pago: Int!,
      \$clave: String!,
      \$descripcion: String!
    ) {
      updateMetodoPago(id_metodo_pago: \$id_metodo_pago, input: {
        clave: \$clave,
        descripcion: \$descripcion
      }) {
        id_metodo_pago
        clave
        descripcion
      }
    }
    ''';

  static const String deleteMetodoPago = '''
    mutation RemoveMetodoPago(\$id_metodo_pago: Int!) {
      removeMetodoPago(id_metodo_pago: \$id_metodo_pago)
    }
    ''';
}
