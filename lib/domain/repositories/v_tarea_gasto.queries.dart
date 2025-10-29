class VTipoGastoQueries {
  static const String getAll = r'''
    query {
      VTareaGastos {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        costo
        creado
        idproyecto
        code
        tarea_descripcion
        fecha_inicio
        fecha_fin
        idempleado
        idestado_tarea
        avance
        orden
        tipo_gasto_nombre
        tipo_gasto_descripcion
        tipo_gasto_codigo
        tipo_gasto_costo
      }
    }
  ''';

  static const String getByTarea = r'''
    query VTareaGastosByTarea($idtarea: Int!) {
      VTareaGastosByTarea(idtarea: $idtarea) {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        costo
        creado
        idproyecto
        code
        tarea_descripcion
        fecha_inicio
        fecha_fin
        idempleado
        idestado_tarea
        avance
        orden
        tipo_gasto_nombre
        tipo_gasto_descripcion
        tipo_gasto_codigo
        tipo_gasto_costo
      }
    }
  ''';

  static const String getByProyecto = r'''
    query VTareaGastosByProyecto($idproyecto: Int!) {
      VTareaGastosByProyecto(idproyecto: $idproyecto) {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        costo
        creado
        idproyecto
        code
        tarea_descripcion
        fecha_inicio
        fecha_fin
        idempleado
        idestado_tarea
        avance
        orden
        tipo_gasto_nombre
        tipo_gasto_descripcion
        tipo_gasto_codigo
        tipo_gasto_costo
      }
    }
  ''';
}