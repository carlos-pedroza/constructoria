class TareaComentarioQueries {
  static const String create = '''
    mutation (
      \$idtarea: Int!,
      \$comentarios: String!,
      \$idempleado: Int!,
      \$creado: DateTime!
    ) {
      createTareaComentario(
        idtarea: \$idtarea,
        comentarios: \$comentarios,
        idempleado: \$idempleado,
        creado: \$creado
      ) {
        idtarea_comentario
        idtarea
        comentarios
        idempleado
        creado
        empleado {
          idempleado
          nombre
          apellido_paterno
          apellido_materno
          correo
        }
      }
    }
  ''';

  static const String update = '''
    mutation (
      \$idtarea_comentario: Int!,
      \$idtarea: Int!,
      \$comentarios: String!,
      \$idempleado: Int!,
      \$creado: DateTime!
    ) {
      updateTareaComentario(
        idtarea_comentario: \$idtarea_comentario,
        idtarea: \$idtarea,
        comentarios: \$comentarios,
        idempleado: \$idempleado,
        creado: \$creado
      ) {
        idtarea_comentario
        idtarea
        comentarios
        idempleado
        creado
        empleado {
          idempleado
          nombre
          apellido_paterno
          apellido_materno
          correo
        }
      }
    }
  ''';

  static const String getAll = '''
    query {
      tareaComentarios {
        idtarea_comentario
        idtarea
        comentarios
        idempleado
        creado
        empleado {
          idempleado
          nombre
          apellido_paterno
          apellido_materno
          correo
        }
      }
    }
  ''';

  static const String getById = '''
    query (\$idtarea_comentario: Int!) {
      tareaComentario(idtarea_comentario: \$idtarea_comentario) {
        idtarea_comentario
        idtarea
        comentarios
        idempleado
        creado
        empleado {
          idempleado
          nombre
          apellido_paterno
          apellido_materno
          correo
        }
      }
    }
  ''';
}
