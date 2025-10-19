class TipoGastoQueries {
  static const String create = '''
    mutation CreateTipoGasto(
        \$nombre: String!,
        \$descripcion: String!,
        \$codigo: String!,
        \$costo: Float!
    ) {
      createTipoGasto(nombre: \$nombre, descripcion: \$descripcion, codigo: \$codigo, costo: \$costo) {
        id_tipo_gasto
        nombre
        descripcion
        codigo
        costo
      }
    }
  ''';

  static const String update = '''
    mutation UpdateTipoGasto(
        \$id: Int!,
        \$nombre: String!,
        \$descripcion: String!,
        \$codigo: String!,
        \$costo: Float!
    ) {
      updateTipoGasto(id: \$id,nombre: \$nombre, descripcion: \$descripcion, codigo: \$codigo, costo: \$costo) {
        id_tipo_gasto
        nombre
        descripcion
        codigo
        costo
      }
    }
  ''';

  static const String delete = '''
    mutation RemoveTipoGasto(\$id: Int!) {
      removeTipoGasto(id: \$id)
    }
  ''';

  static const String getById = '''
    query TipoGasto(\$id: Int!) {
      tipoGasto(id: \$id) {
        id_tipo_gasto
        nombre
        descripcion
        codigo
        costo
      }
    }
  ''';

  static const String getAll = '''
    query TipoGastos {
      tipoGastos {
        id_tipo_gasto
        nombre
        descripcion
        codigo
        costo
      }
    }
  ''';
}
