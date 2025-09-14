class EmpleadoPerfilQueries {
  static const String getAllEmpleadosPerfiles = '''
    query EmpleadoPerfiles (\$idempleado: Int!) {
      empleadoPerfiles(idempleado: \$idempleado) {
        idempleado_perfil
        idempleado
        idperfil
        acceso
      }
    }
  ''';

  static const String perfilesPorEmpleado = '''
    query PerfilesPorEmpleado(\$idempleado: Int!) {
      perfilesPorEmpleado(idempleado: \$idempleado) {
        idperfil
        code
        nombre
        acceso
        idempleado_perfil
      }
    }
  ''';

  static const String getEmpleadoPerfilById = '''
    query GetEmpleadoPerfilById(
      \$id: ID! 
    ) {
      empleadoPerfil(id: \$id) {
        idempleado_perfil
        idempleado
        idperfil
        acceso
        empleado {
          idempleado
          nombre
          apellido_paterno
          apellido_materno
        }
        perfil {
          idperfil
          nombre
          descripcion
        }
      }
    }
  ''';

  static const String createEmpleadoPerfil = '''
    mutation CreateEmpleadoPerfil(\$input: EmpleadoPerfilInput!) {
      createEmpleadoPerfil(input: \$input) {
        idempleado_perfil
        idempleado
        idperfil
        acceso
      }
    }
  ''';

  static const String updateEmpleadoPerfil = '''
    mutation UpdateEmpleadoPerfil(\$idempleado_perfil: Int!, \$input: EmpleadoPerfilInput!) {
      updateEmpleadoPerfil(idempleado_perfil: \$idempleado_perfil, input: \$input) {
        idempleado_perfil
        idempleado
        idperfil
        acceso
      }
    }
  ''';
}
