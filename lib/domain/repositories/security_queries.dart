class SecurityQueries {
  static const String loginEmpleado = '''
    mutation LoginEmpleado(\$correo: String!) {
      loginEmpleado(correo: \$correo) {
        result
        token
      }
    }
  ''';

  static const String loginEmpleadoPassword = '''
    mutation LoginEmpleadoPassword(\$token: String!, \$password: String!) {
      loginEmpleadoPassword(token: \$token, password: \$password) {
        result
        empleado {
          idempleado
          nombre
          apellido_paterno
          apellido_materno
          fecha_nacimiento
          curp
          rfc
          nss
          direccion
          telefono
          correo
          password
          fecha_ingreso
          puesto
          departamento
          salario
          estado_civil
          sexo
          nacionalidad
          tipo_contrato
          jornada_laboral
          banco
          cuenta_bancaria
          costo_por_hora
          activo
          empleado_perfiles {
            idempleado_perfil
            idempleado
            idperfil
          }
        }
        jwt
      }
    }
  ''';

  static const String verifyJwt = '''
    mutation VerifyJwt(\$token: String!) {
      verifyJwt(token: \$token)
    }
  ''';
}
