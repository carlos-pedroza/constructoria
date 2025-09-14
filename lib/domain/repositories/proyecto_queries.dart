class ProyectoQueries {
  static const String getProyectos = '''
    query GetProyectos {
      proyectos {
        id
        nombre
        descripcion
        fechaInicio
        fechaFin
        estado
      }
    }
  ''';

  static const String getAllProyectos = '''
    query {
      getAllProyectos {
        idproyecto
        clave_proyecto
        nombre
        descripcion
        fecha_inicio
        fecha_fin
        idestado
        presupuesto
        ubicacion
        cliente_nombre
        cliente_contacto
        cliente_email
        cliente_telefono
        cliente_direccion
        responsable_id
        created_at
        updated_at
      }
    }
  ''';

  static const String getProyectoById = '''
    query GetProyectoById(\$idproyecto: Int!) {
      getProyectoById(idproyecto: \$idproyecto) {
        idproyecto
        nombre
        clave_proyecto
        // ...otros campos
      }
    }
  ''';

  static const String createProyecto = '''
    mutation CreateProyecto(\$input: ProyectoInput!) {
      createProyecto(input: \$input) {
        idproyecto
        nombre
      }
    }
  ''';

  static const String updateProyecto = '''
    mutation UpdateProyecto(\$idproyecto: Int!, \$input: ProyectoInput!) {
      updateProyecto(
        idproyecto: \$idproyecto,
        input: \$input
      ) {
        idproyecto
        nombre
        presupuesto
      }
    }
  ''';

  static const String deleteProyecto = '''
    mutation DeleteProyecto(\$idproyecto: Int!) {
      deleteProyecto(idproyecto: \$idproyecto)
    }
  ''';

}