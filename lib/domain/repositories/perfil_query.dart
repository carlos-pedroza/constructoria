class PerfilQuery {
  static const String getAllPerfiles = '''
    query GetAllPerfiles {
        perfiles {
            idperfil
            code
            nombre
        }
    }
  ''';

  static const String getPerfilById = '''
    query GetPerfilById(
      \$idperfil: ID!
    ) {
      perfil(idperfil: \$idperfil) {
        idperfil
        code
        nombre
      }
    }
  ''';

  static const String createPerfil = '''
    mutation CreatePerfil(
      \$nombre: String!,
      \$descripcion: String!
    ) {
      createPerfil(input: {
        nombre: \$nombre,
        descripcion: \$descripcion
      }) {
        idperfil
        code
        nombre
      }
    }
  ''';

  static const String updatePerfil = '''
    mutation UpdatePerfil(
      \$idperfil: ID!,
      \$nombre: String,
      \$descripcion: String
    ) {
      updatePerfil(idperfil: \$idperfil, input: {
        nombre: \$nombre,
        code: \$descripcion
      }) {
        idperfil
        code
        nombre
      }
    }
  ''';

  static const String removePerfil = '''
    mutation RemovePerfil(\$idperfil: ID!) {
      removePerfil(idperfil: \$idperfil)
    }
  ''';
}
