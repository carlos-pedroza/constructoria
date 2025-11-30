class EstatusPagoQueries {
  static const String getAllEstatusPagos = '''
    query {
      estatusPagos {
        id_estatus_pago
        clave
        descripcion
      }
    }
    ''';

  static const String getEstatusPagoById = '''
    query GetEstatusPagoById(
      \$id_estatus_pago: Int!
    ) {
      estatusPago(id_estatus_pago: \$id_estatus_pago) {
        id_estatus_pago
        clave
        descripcion
      }
    }
    ''';

  static const String createEstatusPago = '''
    mutation CreateEstatusPago(
      \$clave: String!,
      \$descripcion: String!
    ) {
      createEstatusPago(input: {
        clave: \$clave,
        descripcion: \$descripcion
      }) {
        id_estatus_pago
        clave
        descripcion
      }
    }
    ''';

  static const String updateEstatusPago = '''
    mutation UpdateEstatusPago(
      \$id_estatus_pago: Int!,
      \$clave: String!,
      \$descripcion: String!
    ) {
      updateEstatusPago(id_estatus_pago: \$id_estatus_pago, input: {
        clave: \$clave,
        descripcion: \$descripcion
      }) {
        id_estatus_pago
        clave
        descripcion
      }
    }
    ''';

  static const String deleteEstatusPago = '''
    mutation RemoveEstatusPago(\$id_estatus_pago: Int!) {
      removeEstatusPago(id_estatus_pago: \$id_estatus_pago)
    }
    ''';
}