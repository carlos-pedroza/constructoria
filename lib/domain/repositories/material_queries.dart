class MaterialQueries {
  static const String create = '''
    mutation CreateMaterial(
      \$nombre: String!,
      \$descripcion: String!,
      \$unidad: String!,
      \$codigo: String!,
      \$costo: Float!
    ) {
      createMaterial(
        input: {
          nombre: \$nombre,
          descripcion: \$descripcion,
          unidad: \$unidad,
          codigo: \$codigo,
          costo: \$costo
        }
      ) {
        id_material
        nombre
        descripcion
        unidad
        codigo
      }
    }
  ''';

  static const String update= '''
    mutation UpdateMaterial(
      \$id: Int!,
      \$nombre: String!,
      \$descripcion: String!,
      \$unidad: String!,
      \$codigo: String!,
      \$costo: Float!
    ) {
      updateMaterial(
        id: \$id,
        input: {
          nombre: \$nombre,
          descripcion: \$descripcion,
          unidad: \$unidad,
          codigo: \$codigo,
          costo: \$costo
        }
      ) {
        id_material
        nombre
        descripcion
        unidad
        codigo
        costo
      }
    }
  ''';

  static const String delete = '''
    mutation RemoveMaterial(\$id: Int!) {
      removeMaterial(id: \$id)
    }
  ''';

  static const String getById = '''
    query Material(\$id: Int!) {
      material(id: \$id) {
        id_material
        nombre
        descripcion
        unidad
        codigo
      }
    }
  ''';

  static const String getAll = '''
    query {
      materials {
        id_material
        nombre
        descripcion
        unidad
        codigo
        costo
      }
    }
  ''';
}
