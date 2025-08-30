class EmpleadoPerfilQueries {
  static const String getAllEmpleadosPerfiles = '''
    query GetAllEmpleadosPerfiles {
      empleadoPerfiles {
        idempleado_perfil
        idempleado
        idperfil
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

  static const String getEmpleadoPerfilById = '''
    query GetEmpleadoPerfilById(
      \$id: ID! 
    ) {
      empleadoPerfil(id: \$id) {
        idempleado_perfil
        idempleado
        idperfil
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
    mutation CreateEmpleadoPerfil(
      \$idempleado: ID!,
      \$idperfil: ID!
    ) {
      createEmpleadoPerfil(input: {
        idempleado: \$idempleado,
        idperfil: \$idperfil
      }) {
        idempleado_perfil
        idempleado
        idperfil
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
}
