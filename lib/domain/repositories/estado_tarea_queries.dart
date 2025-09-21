class EstadoTareaQueries {
  static const String getAllEstadoTareas = '''
    query {
      estadoTareas {
        idestado_tarea
        nombre
        descripcion
      }
    }
  ''';

  static const String getEstadoTareaById = '''
    query GetEstadoTareaById(\$id: Int!) {
      estadoTarea(id: \$id) {
        idestado_tarea
        nombre
        descripcion
      }
    }
  ''';

  static const String createEstadoTarea = '''
    mutation CreateEstadoTarea(
      \$nombre: String!,
      \$descripcion: String!
    ) {
      createEstadoTarea(
        nombre: \$nombre,
        descripcion: \$descripcion
      ) {
        idestado_tarea
        nombre
        descripcion
      }
    }
  ''';

  static const String updateEstadoTarea = '''
    mutation UpdateEstadoTarea(
      \$id: Int!,
      \$nombre: String!,
      \$descripcion: String!
    ) {
      updateEstadoTarea(
        id: \$id,
        nombre: \$nombre,
        descripcion: \$descripcion
      ) {
        idestado_tarea
        nombre
        descripcion
      }
    }
  ''';

  static const String deleteEstadoTarea = '''
    mutation DeleteEstadoTarea(\$id: Int!) {
      removeEstadoTarea(id: \$id)
    }
  ''';
}