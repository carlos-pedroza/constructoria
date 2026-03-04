class TareaGastoQueries {
  static const String create = '''
    mutation CreateTareaGasto(
      \$idtarea: Int!,
      \$id_tipo_gasto: Int!,
      \$idperiodo: Int = 1,
      \$idtipo_valor: Int = 1,
      \$costo: Float!,
      \$creado: DateTime!
    ) {
      createTareaGasto(
        idtarea: \$idtarea,
        id_tipo_gasto: \$id_tipo_gasto,
        idperiodo: \$idperiodo,
        idtipo_valor: \$idtipo_valor,
        costo: \$costo,
        creado: \$creado
      ) {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        idperiodo
        idtipo_valor
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
      \$idperiodo: Int = 1,
      \$idtipo_valor: Int = 1,
      \$costo: Float!,
      \$creado: DateTime!
    ) {
      updateTareaGasto(
        id: \$id,
        idtarea: \$idtarea,
        id_tipo_gasto: \$id_tipo_gasto,
        idperiodo: \$idperiodo,
        idtipo_valor: \$idtipo_valor,
        costo: \$costo,
        creado: \$creado
      ) {
        idtarea_gasto
        idtarea
        id_tipo_gasto
        idperiodo
        idtipo_valor
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
        idperiodo
        idtipo_valor
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
        idperiodo
        idtipo_valor
        costo
        creado
      }
    }
  ''';
}
