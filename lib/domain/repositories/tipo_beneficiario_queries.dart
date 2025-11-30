class TipoBeneficiarioQueries {
  static const String getAllTipoBeneficiarios = '''
    query {
      tipoBeneficiarios {
        id_tipo_beneficiario
        clave
        descripcion
      }
    }
    ''';

  static const String getTipoBeneficiarioById = '''
    query GetTipoBeneficiarioById(
      \$id_tipo_beneficiario: Int!
    ) {
      tipoBeneficiario(id_tipo_beneficiario: \$id_tipo_beneficiario) {
        id_tipo_beneficiario
        clave
        descripcion
      }
    }
    ''';

  static const String createTipoBeneficiario = '''
    mutation CreateTipoBeneficiario(
      \$clave: String!,
      \$descripcion: String!
    ) {
      createTipoBeneficiario(input: {
        clave: \$clave,
        descripcion: \$descripcion
      }) {
        id_tipo_beneficiario
        clave
        descripcion
      }
    }
    ''';

  static const String updateTipoBeneficiario = '''
    mutation UpdateTipoBeneficiario(
      \$id_tipo_beneficiario: Int!,
      \$clave: String!,
      \$descripcion: String!
    ) {
      updateTipoBeneficiario(id_tipo_beneficiario: \$id_tipo_beneficiario, input: {
        clave: \$clave,
        descripcion: \$descripcion
      }) {
        id_tipo_beneficiario
        clave
        descripcion
      }
    }
    ''';

  static const String deleteTipoBeneficiario = '''
    mutation RemoveTipoBeneficiario(\$id_tipo_beneficiario: Int!) {
      removeTipoBeneficiario(id_tipo_beneficiario: \$id_tipo_beneficiario)
    }
    ''';
}
