class EstadoTarea {
  EstadoTarea({
    this.idestadoTarea,
    required this.nombre,
    required this.descripcion,
  });

  int? idestadoTarea;
  final String nombre;
  final String descripcion;

  factory EstadoTarea.fromJson(dynamic json) {
    return EstadoTarea(
      idestadoTarea: json['idestado_tarea'] as int?,
      nombre: json['nombre'] as String? ?? '',
      descripcion: json['descripcion'] as String? ?? '',
    );
  }

  static List<EstadoTarea> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EstadoTarea.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idestado_tarea': idestadoTarea,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  @override
  String toString() {
    return 'EstadoTarea{idestadoTarea: $idestadoTarea, nombre: $nombre, descripcion: $descripcion}';
  }
}