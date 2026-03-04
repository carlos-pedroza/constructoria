import 'package:constructoria/domain/repositories/periodo_queries.dart';

class Periodo {
  Periodo({
    this.idperiodo,
    required this.nombre,
  });

  int? idperiodo;
  String nombre;

  factory Periodo.fromJson(dynamic json) {
    return Periodo(
      idperiodo: json['idperiodo'] as int?,
      nombre: json['nombre'] as String? ?? '',
    );
  }

  static List<Periodo> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Periodo.fromJson(json)).toList();
  }

  String get query {
    if (idperiodo == null) return PeriodoQueries.create;
    return PeriodoQueries.update;
  }

  Map<String, dynamic> data() {
    if (idperiodo == null) {
      return {
        'input': {'nombre': nombre}
      };
    }
    return {
      'idperiodo': idperiodo,
      'input': {'nombre': nombre}
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'idperiodo': idperiodo,
      'nombre': nombre,
    };
  }
}
