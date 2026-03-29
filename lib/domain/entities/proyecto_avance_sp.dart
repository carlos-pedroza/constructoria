class ProyectoAvanceSp {
  ProyectoAvanceSp({
    required this.idproyecto,
    required this.claveProyecto,
    required this.nombre,
    required this.totalTareas,
    required this.avancePromedio,
    required this.avancePorcentaje,
  });

  final int idproyecto;
  final String claveProyecto;
  final String nombre;
  final int totalTareas;

  /// Promedio (0.0000 - 1.0000)
  final double avancePromedio;

  /// Porcentaje (0.00 - 100.00)
  final double avancePorcentaje;

  factory ProyectoAvanceSp.fromJson(dynamic json) {
    return ProyectoAvanceSp(
      idproyecto: (json['idproyecto'] as num?)?.toInt() ?? 0,
      claveProyecto: (json['clave_proyecto'] as String?) ?? '',
      nombre: (json['nombre'] as String?) ?? '',
      totalTareas: (json['total_tareas'] as num?)?.toInt() ?? 0,
      avancePromedio: (json['avance_promedio'] as num?)?.toDouble() ?? 0.0,
      avancePorcentaje: (json['avance_porcentaje'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static List<ProyectoAvanceSp> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProyectoAvanceSp.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idproyecto': idproyecto,
      'clave_proyecto': claveProyecto,
      'nombre': nombre,
      'total_tareas': totalTareas,
      'avance_promedio': avancePromedio,
      'avance_porcentaje': avancePorcentaje,
    };
  }

  @override
  String toString() {
    return 'ProyectoAvanceSp{idproyecto: $idproyecto, claveProyecto: $claveProyecto, nombre: $nombre, totalTareas: $totalTareas, avancePromedio: $avancePromedio, avancePorcentaje: $avancePorcentaje}';
  }
}
