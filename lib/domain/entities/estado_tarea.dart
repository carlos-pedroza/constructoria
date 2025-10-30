class EstadoTarea {
  EstadoTarea({
    this.idestadoTarea,
    required this.nombre,
    required this.descripcion,
  });

  int? idestadoTarea;
  final String nombre;
  final String descripcion;

  static const int pendiente = 1;
  static const int enProgreso = 2;
  static const int enRevision = 3;
  static const int completada = 4;
  static const int bloqueada = 5;
  static const int cancelada = 6;

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

  static String estadoToString(int estadoId) {
    switch (estadoId) {
      case pendiente:
        return 'Pendiente';
      case enProgreso:
        return 'En Progreso';
      case enRevision:
        return 'En Revisión';
      case completada:
        return 'Completada';
      case bloqueada:
        return 'Bloqueada';
      case cancelada:
        return 'Cancelada';
      default:
        return 'Desconocido';
    }
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