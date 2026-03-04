class TipoValorQueries {
  static const String getAll = r'''
    query TipoValores {
      tipoValores {
        idtipo_valor
        nombre
      }
    }
  ''';

  static const String getById = r'''
    query TipoValor($id: Int!) {
      tipoValor(id: $id) {
        idtipo_valor
        nombre
      }
    }
  ''';

  static const String create = r'''
    mutation CreateTipoValor($input: TipoValorInput!) {
      createTipoValor(input: $input) {
        idtipo_valor
        nombre
      }
    }
  ''';

  static const String update = r'''
    mutation UpdateTipoValor($idtipo_valor: Int!, $input: TipoValorInput!) {
      updateTipoValor(idtipo_valor: $idtipo_valor, input: $input) {
        idtipo_valor
        nombre
      }
    }
  ''';

  static const String remove = r'''
    mutation RemoveTipoValor($idtipo_valor: Int!) {
      removeTipoValor(idtipo_valor: $idtipo_valor)
    }
  ''';
}
