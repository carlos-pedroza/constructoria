class ProyectoQueries {

  static const String getAllProyectos = '''
    query {
      getAllProyectos {
        idproyecto
        nombre
        clave_proyecto
        descripcion
        fecha_inicio
        fecha_fin
        idestado
        estado {
            nombre
        }
        presupuesto
        ubicacion
        cliente_nombre
        cliente_contacto
        cliente_email
        cliente_telefono
        cliente_direccion
        responsable_id
        responsable {
            nombre
            apellido_paterno
            apellido_materno
        }
      }
    }
  ''';

  static const String getProyectoById = '''
    query GetProyectoById(\$idproyecto: Int!) {
      getProyectoById(idproyecto: \$idproyecto) {
        idproyecto
        nombre
        clave_proyecto
        descripcion
        fecha_inicio
        fecha_fin
        idestado
        estado {
            nombre
        }
        presupuesto
        ubicacion
        cliente_nombre
        cliente_contacto
        cliente_email
        cliente_telefono
        cliente_direccion
        responsable_id
        responsable {
            nombre
            apellido_paterno
            apellido_materno
        }
      }
    }
  ''';

  static const String createProyecto = '''
    mutation CreateProyecto(\$input: ProyectoDto!) {
      createProyecto(input: \$input) {
        idproyecto
        nombre
        clave_proyecto
        nombre
        descripcion
        fecha_inicio
        fecha_fin
        idestado
        presupuesto
        ubicacion
        cliente_nombre
        cliente_contacto
        cliente_email
        cliente_telefono
        cliente_direccion
        responsable_id
      }
    }
  ''';

  static const String updateProyecto = '''
    mutation UpdateProyecto(\$idproyecto: Int!, \$input: ProyectoDto!) {
      updateProyecto(idproyecto: \$idproyecto, input: \$input) {
        idproyecto
        nombre
        clave_proyecto
        nombre
        descripcion
        fecha_inicio
        fecha_fin
        idestado
        presupuesto
        ubicacion
        cliente_nombre
        cliente_contacto
        cliente_email
        cliente_telefono
        cliente_direccion
        responsable_id
      }
    }
  ''';

  static const String deleteProyecto = '''
    mutation DeleteProyecto(\$idproyecto: Int!) {
      deleteProyecto(idproyecto: \$idproyecto)
    }
  ''';

  static const String getResumenProyecto = r'''
    query ($idproyecto: Int!) {
      getResumenProyecto(idproyecto: $idproyecto) {
        idproyecto
        porcentaje_avance
        total_gasto
        total_material
      }
    }
  ''';

  static const String proyectoManoObraSum = r'''
    query ($idproyecto: Int!){
      proyectoManoObraSum(idproyecto: $idproyecto) {
        idproyecto
        total_mano_obra
        total_mano_obra_avance
      }
    }
  ''';

}