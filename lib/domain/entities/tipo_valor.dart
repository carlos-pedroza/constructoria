import 'package:constructoria/domain/repositories/tipo_valor_queries.dart';

class TipoValor {
  TipoValor({
    this.idtipoValor,
    required this.nombre,
  });

  static const fijo = 1;
  static const calculado = 2;

  int? idtipoValor;
  String nombre;

  factory TipoValor.fromJson(dynamic json) {
    return TipoValor(
      idtipoValor: json['idtipo_valor'] as int?,
      nombre: json['nombre'] as String? ?? '',
    );
  }

  static List<TipoValor> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TipoValor.fromJson(json)).toList();
  }

  String get query {
    if (idtipoValor == null) return TipoValorQueries.create;
    return TipoValorQueries.update;
  }

  Map<String, dynamic> data() {
    if (idtipoValor == null) {
      return {
        'input': {'nombre': nombre}
      };
    }
    return {
      'idtipo_valor': idtipoValor,
      'input': {'nombre': nombre}
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'idtipo_valor': idtipoValor,
      'nombre': nombre,
    };
  }
}
