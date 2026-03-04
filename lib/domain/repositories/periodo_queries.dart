class PeriodoQueries {
  static const String getAll = r'''
    query Periodos {
      periodos {
        idperiodo
        nombre
      }
    }
  ''';

  static const String getById = r'''
    query Periodo($id: Int!) {
      periodo(id: $id) {
        idperiodo
        nombre
      }
    }
  ''';

  static const String create = r'''
    mutation CreatePeriodo($input: PeriodoInput!) {
      createPeriodo(input: $input) {
        idperiodo
        nombre
      }
    }
  ''';

  static const String update = r'''
    mutation UpdatePeriodo($idperiodo: Int!, $input: PeriodoInput!) {
      updatePeriodo(idperiodo: $idperiodo, input: $input) {
        idperiodo
        nombre
      }
    }
  ''';

  static const String remove = r'''
    mutation RemovePeriodo($idperiodo: Int!) {
      removePeriodo(idperiodo: $idperiodo)
    }
  ''';
}
