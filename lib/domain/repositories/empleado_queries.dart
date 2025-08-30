class EmpleadoQueries {
  static const String getAllEmpleados = '''
    query {
      empleados {
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
    }
    ''';

  static const String getEmpleadoById = '''
    query GetEmpleadoById(
      \$idempleado: ID!
    ) {
      empleado(idempleado: \$idempleado) {
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
      }
    }
    ''';

  static const String createEmpleado = '''
    mutation CreateEmpleado(
      \$nombre: String!,
      \$apellido_paterno: String!,
      \$apellido_materno: String!,
      \$fecha_nacimiento: String!,
      \$curp: String!,
      \$rfc: String!,
      \$nss: String!,
      \$direccion: String!,
      \$telefono: String!,
      \$correo: String!,
      \$password: String!,
      \$fecha_ingreso: String!,
      \$puesto: String!,
      \$departamento: String!,
      \$salario: Float!,
      \$estado_civil: String!,
      \$sexo: String!,
      \$nacionalidad: String!,
      \$tipo_contrato: String!,
      \$jornada_laboral: String!,
      \$banco: String!,
      \$cuenta_bancaria: String!,
      \$costo_por_hora: Float!,
      \$activo: Boolean!
    ) {
      createEmpleado(input: {
        nombre: \$nombre,
        apellido_paterno: \$apellido_paterno,
        apellido_materno: \$apellido_materno,
        fecha_nacimiento: \$fecha_nacimiento,
        curp: \$curp,
        rfc: \$rfc,
        nss: \$nss,
        direccion: \$direccion,
        telefono: \$telefono,
        correo: \$correo,
        password: \$password,
        fecha_ingreso: \$fecha_ingreso,
        puesto: \$puesto,
        departamento: \$departamento,
        salario: \$salario,
        estado_civil: \$estado_civil,
        sexo: \$sexo,
        nacionalidad: \$nacionalidad,
        tipo_contrato: \$tipo_contrato,
        jornada_laboral: \$jornada_laboral,
        banco: \$banco,
        cuenta_bancaria: \$cuenta_bancaria,
        costo_por_hora: \$costo_por_hora,
        activo: \$activo
      }) {
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
      }
    }
    ''';

  static const String updateEmpleado = '''
    mutation UpdateEmpleado(
      \$idempleado: ID!,
      \$nombre: String,
      \$apellido_paterno: String,
      \$apellido_materno: String,
      \$fecha_nacimiento: String,
      \$curp: String,
      \$rfc: String,
      \$nss: String,
      \$direccion: String,
      \$telefono: String,
      \$correo: String,
      \$password: String,
      \$fecha_ingreso: String,
      \$puesto: String,
      \$departamento: String,
      \$salario: Float,
      \$estado_civil: String,
      \$sexo: String,
      \$nacionalidad: String,
      \$tipo_contrato: String,
      \$jornada_laboral: String,
      \$banco: String,
      \$cuenta_bancaria: String,
      \$costo_por_hora: Float,
      \$activo: Boolean
    ) {
      updateEmpleado(idempleado: \$idempleado, input: {
        nombre: \$nombre,
        apellido_paterno: \$apellido_paterno,
        apellido_materno: \$apellido_materno,
        fecha_nacimiento: \$fecha_nacimiento,
        curp: \$curp,
        rfc: \$rfc,
        nss: \$nss,
        direccion: \$direccion,
        telefono: \$telefono,
        correo: \$correo,
        password: \$password,
        fecha_ingreso: \$fecha_ingreso,
        puesto: \$puesto,
        departamento: \$departamento,
        salario: \$salario,
        estado_civil: \$estado_civil,
        sexo: \$sexo,
        nacionalidad: \$nacionalidad,
        tipo_contrato: \$tipo_contrato,
        jornada_laboral: \$jornada_laboral,
        banco: \$banco,
        cuenta_bancaria: \$cuenta_bancaria,
        costo_por_hora: \$costo_por_hora,
        activo: \$activo
      }) {
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
      }
    }
    ''';

  static const String deleteEmpleado = '''
    mutation DeleteEmpleado(\$idempleado: ID!) {
      deleteEmpleado(idempleado: \$idempleado) {
        idempleado
      }
    }
    ''';
}
