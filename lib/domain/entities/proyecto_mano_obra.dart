class ProyectoManoObra {
  final int idproyecto;
  final double totalManoObra;
  final double totalManoObraAvance;

  ProyectoManoObra({
    required this.idproyecto,
    required this.totalManoObra,
    required this.totalManoObraAvance,
  });

  factory ProyectoManoObra.fromJson(Map<String, dynamic> json) {
    return ProyectoManoObra(
      idproyecto: json['idproyecto'],
      totalManoObra: (json['total_mano_obra'] as num).toDouble(),
      totalManoObraAvance: (json['total_mano_obra_avance'] as num).toDouble(),
    );
  }

  static ProyectoManoObra? fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return null;
    return  ProyectoManoObra.fromJson(jsonList.first);
  }
}
