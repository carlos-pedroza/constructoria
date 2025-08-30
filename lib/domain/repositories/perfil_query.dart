class PerfilQuery {
  static const String getAllPerfiles = '''
    query GetAllPerfiles {
      perfiles {
        idperfil
        nombre
        descripcion
      }
    }
  ''';

  static const String getPerfilById = '''
    query GetPerfilById(
      \$idperfil: ID!
    ) {
      perfil(idperfil: \$idperfil) {
        idperfil
        nombre
        descripcion
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
        nombre
        descripcion
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
        descripcion: \$descripcion
      }) {
        idperfil
        nombre
        descripcion
      }
    }
  ''';

  static const String deletePerfil = '''
    mutation DeletePerfil(\$idperfil: ID!) {
      deletePerfil(idperfil: \$idperfil) {
        idperfil
      }
    }
  ''';
}
