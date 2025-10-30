class TareaMaterialQueries {
  static const String create = r'''
    mutation CreateTareaMaterial ($input: TareaMaterialInput!) {
      createTareaMaterial(input: $input) {
        idtarea_material
        idtarea
        id_material
        cantidad
        costo
        creado
      }
    }
  ''';

  static const String update = r'''
    mutation UpdateTareaMaterial($id: Int!, $input: TareaMaterialInput!) {
      updateTareaMaterial(id: $id, input: $input) {
        idtarea_material
        idtarea
        id_material
        cantidad
        costo
        creado
      }
    }
  ''';

  static const String delete = r'''
    mutation ($id: Int!) {
      removeTareaMaterial(id: $id)
    }
  ''';

  static const String getById = r'''
    query TareaMaterial($id: Int!) {
      tareaMaterial(id: $id) {
        idtarea_material
        idtarea
        id_material
        cantidad
        costo
        creado
      }
    }
  ''';

  static const String getAll= r'''
    query {
      tareaMaterials {
        idtarea_material
        idtarea
        id_material
        cantidad
        costo
        creado
      }
    }
  ''';

  static const String getByTarea = r'''
    query VTareaMaterialByTarea($idtarea: Int!) {
      vTareaMaterialByTarea(idtarea: $idtarea) {
        idtarea_material
        idtarea
        id_material
        cantidad
        costol
        creado
        nombre
        descripcion
        unidad
        codigo
        costo_sugerido
        idproyecto
        tarea_code
        tarea_descripcion
        fecha_inicio
        fecha_fin
        idempleado
        idestado_tarea
        avance
        orden
      }
    }
  ''';

  static const String getByProyecto = r'''
    query VTareaMaterialByProyecto($idproyecto: Int!) {
      vTareaMaterialByProyecto(idproyecto: $idproyecto) {
        idtarea_material
        idtarea
        id_material
        cantidad
        costol
        creado
        nombre
        descripcion
        unidad
        codigo
        costo_sugerido
        idproyecto
        tarea_code
        tarea_descripcion
        fecha_inicio
        fecha_fin
        idempleado
        idestado_tarea
        avance
        orden
      }
    }
  ''';
}
