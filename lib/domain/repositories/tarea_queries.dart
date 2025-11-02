class TareaQueries {
  static const String getAllTareas = '''
    query Tareas(\$idproyecto: Int!) {
      tareas(idproyecto: \$idproyecto) {
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
            costo_por_hora
        }
        idestado_tarea
        avance
        estadoTarea {
          idestado_tarea
          nombre
          descripcion
        }
        orden
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
        orden
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
      \$orden: Int!
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
        orden: \$orden
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
        orden
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
      \$avance: Float!,
      \$orden: Int!
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
        avance: \$avance,
        orden: \$orden
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
        orden
      }
    }
  ''';

  static const String deleteTarea = '''
    mutation DeleteTarea(\$id: Int!) {
      removeTarea(id: \$id)
    }
  ''';

  static const String vTareas = r'''
    query ($idproyecto: Int!){
      vTareas(idproyecto: $idproyecto) {
        idtarea
        idproyecto
        code
        tarea_descripcion
        fecha_inicio
        fecha_fin
        idempleado
        empleado_nombre
        apellido_paterno
        apellido_materno
        costo_por_hora
        activo
        idestado_tarea
        estado_tarea_nombre
        estado_tarea_descripcion
        avance
        total_mano_obra
        total_mano_obra_avance
        orden
      }
    }
  ''';
}