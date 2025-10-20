class TareaGastoQueries {
  static const String create = '''
    mutation CreateTareaGasto(
      \$idtarea: Int!,
      \$id_tipo_gasto: Int!,
      \$costo: Float!,
      \$creado: DateTime!
    ) {
      createTareaGasto(
        idtarea: \$idtarea,
        id_tipo_gasto: \$id_tipo_gasto,
        costo: \$costo,
        creado: \$creado
      ) {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        costo
        creado
      }
    }
  ''';

  static const String update = '''
    mutation UpdateTareaGasto(
      \$id: Int!,
      \$idtarea: Int!,
      \$id_tipo_gasto: Int!,
      \$costo: Float!,
      \$creado: DateTime!
    ) {
      updateTareaGasto(
        id: \$id,
        idtarea: \$idtarea,
        id_tipo_gasto: \$id_tipo_gasto,
        costo: \$costo,
        creado: \$creado
      ) {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        costo
        creado
      }
    }
  ''';

  static const String delete = '''
    mutation RemoveTareaGasto(\$id: Int!) {
      removeTareaGasto(id: \$id)
    }
  ''';

  static const String getById = '''
    query TareaGasto(\$id: Int!) {
      tareaGasto(id: \$id) {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        costo
        creado
      }
    }
  ''';

  static const String getAll = '''
    query {
      tareaGastos {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        costo
        creado
      }
    }
  ''';
}
