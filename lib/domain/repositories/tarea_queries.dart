class TareaQueries {
  static const String getAllTareas = '''
    query {
      tareas {
        idtarea
        idproyecto
        code
        descripcion
        fecha_inicio
        fecha_fin
        idempleado
        empleado {
            nombre
            apellido_paterno
            apellido_materno
        }
        idestado_tarea
        avance
        estadoTarea {
          idestado_tarea
          nombre
          descripcion
        }
      }
    }
  ''';

  static const String getTareaById = '''
    query GetTareaById(\$id: Int!) {
      tarea(id: \$id) {
        idtarea
        idproyecto
        code
        descripcion
        fecha_inicio
        fecha_fin
        idempleado
        empleado {
            nombre
            apellido_paterno
            apellido_materno
        }
        idestado_tarea
        avance
        estadoTarea {
          idestado_tarea
          nombre
          descripcion
        }
      }
    }
  ''';

  static const String createTarea = '''
    mutation CreateTarea(
      \$idproyecto: Int!,
      \$code: String!,
      \$descripcion: String!,
      \$fecha_inicio: DateTime!,
      \$fecha_fin: DateTime!,
      \$idempleado: Int!,
      \$idestado_tarea: Int!,
      \$avance: Float!
    ) {
      createTarea(
        idproyecto: \$idproyecto,
        code: \$code,
        descripcion: \$descripcion,
        fecha_inicio: \$fecha_inicio,
        fecha_fin: \$fecha_fin,
        idempleado: \$idempleado,
        idestado_tarea: \$idestado_tarea,
        avance: \$avance
      ) {
        idtarea
        idproyecto
        code
        descripcion
        fecha_inicio
        fecha_fin
        idempleado
        idestado_tarea
        avance
      }
    }
  ''';

  static const String updateTarea = '''
    mutation UpdateTarea(
      \$id: Int!,
      \$idproyecto: Int!,
      \$code: String!,
      \$descripcion: String!,
      \$fecha_inicio: DateTime!,
      \$fecha_fin: DateTime!,
      \$idempleado: Int!,
      \$idestado_tarea: Int!,
      \$avance: Float!
    ) {
      updateTarea(
        id: \$id,
        idproyecto: \$idproyecto,
        code: \$code,
        descripcion: \$descripcion,
        fecha_inicio: \$fecha_inicio,
        fecha_fin: \$fecha_fin,
        idempleado: \$idempleado,
        idestado_tarea: \$idestado_tarea,
        avance: \$avance
      ) {
        idtarea
        idproyecto
        code
        descripcion
        fecha_inicio
        fecha_fin
        idempleado
        idestado_tarea
        avance
      }
    }
  ''';

  static const String deleteTarea = '''
    mutation DeleteTarea(\$id: Int!) {
      removeTarea(id: \$id)
    }
  ''';
}