class ResumenProyecto {
  final int idproyecto;
  final double porcentajeAvance;
  final double totalGasto;
  final double totalMaterial;

  ResumenProyecto({
    required this.idproyecto,
    required this.porcentajeAvance,
    required this.totalGasto,
    required this.totalMaterial,
  });

  factory ResumenProyecto.fromJson(Map<String, dynamic> json) {
    return ResumenProyecto(
      idproyecto: json['idproyecto'],
      porcentajeAvance: (json['porcentaje_avance'] as num).toDouble(),
      totalGasto: (json['total_gasto'] as num).toDouble(),
      totalMaterial: (json['total_material'] as num).toDouble(),
    );
  }

}