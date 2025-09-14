import 'package:intl/intl.dart';

class Proyecto {
  Proyecto({
    this.idproyecto,
    required this.claveProyecto,
    required this.nombre,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.idestado,
    required this.presupuesto,
    required this.ubicacion,
    required this.clienteNombre,
    required this.clienteContacto,
    required this.clienteEmail,
    required this.clienteTelefono,
    required this.clienteDireccion,
    required this.responsableId,
    required this.createdAt,
    required this.updatedAt,
  });

  int? idproyecto;
  final String claveProyecto;
  final String nombre;
  final String descripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final int idestado;
  final double presupuesto;
  final String ubicacion;
  final String clienteNombre;
  final String clienteContacto;
  final String clienteEmail;
  final String clienteTelefono;
  final String clienteDireccion;
  final int responsableId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Proyecto.fromJson(dynamic json) {
    return Proyecto(
      idproyecto: json['idproyecto'] as int?,
      claveProyecto: json['clave_proyecto'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String? ?? '',
      fechaInicio: json['fecha_inicio'] != null ? DateTime.parse(json['fecha_inicio']) : DateTime.now(),
      fechaFin: json['fecha_fin'] != null ? DateTime.parse(json['fecha_fin']) : DateTime.now(),
      idestado: json['idestado'] as int,
      presupuesto: json['presupuesto'] != null ? (json['presupuesto'] as num).toDouble() : 0.0,
      ubicacion: json['ubicacion'] as String? ?? '',
      clienteNombre: json['cliente_nombre'] as String? ?? '',
      clienteContacto: json['cliente_contacto'] as String? ?? '',
      clienteEmail: json['cliente_email'] as String? ?? '',
      clienteTelefono: json['cliente_telefono'] as String? ?? '',
      clienteDireccion: json['cliente_direccion'] as String? ?? '',
      responsableId: json['responsable_id'] as int? ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  factory Proyecto.empty() {
    return Proyecto(
      claveProyecto: '',
      nombre: '',
      descripcion: '',
      fechaInicio: DateTime.now(),
      fechaFin: DateTime.now(),
      idestado: 0,
      presupuesto: 0.0,
      ubicacion: '',
      clienteNombre: '',
      clienteContacto: '',
      clienteEmail: '',
      clienteTelefono: '',
      clienteDireccion: '',
      responsableId: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static List<Proyecto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Proyecto.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
      return {
        'idproyecto': idproyecto,
        'clave_proyecto': claveProyecto,
        'nombre': nombre,
        'descripcion': descripcion,
        'fecha_inicio': DateFormat('yyyy-MM-dd').format(fechaInicio),
        'fecha_fin': DateFormat('yyyy-MM-dd').format(fechaFin),
        'idestado': idestado,
        'presupuesto': presupuesto,
        'ubicacion': ubicacion,
        'cliente_nombre': clienteNombre,
        'cliente_contacto': clienteContacto,
        'cliente_email': clienteEmail,
        'cliente_telefono': clienteTelefono,
        'cliente_direccion': clienteDireccion,
        'responsable_id': responsableId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
  }

  Map<String, dynamic> data() {
      if (idproyecto == null) {
        return createJson();
      }
      return updateJson();
  }

  Map<String, dynamic> createJson() {
    return {
      'input': {
        'clave_proyecto': claveProyecto,
        'nombre': nombre,
        'descripcion': descripcion,
        'fecha_inicio': DateFormat('yyyy-MM-dd').format(fechaInicio),
        'fecha_fin': DateFormat('yyyy-MM-dd').format(fechaFin),
        'idestado': idestado,
        'presupuesto': presupuesto,
        'ubicacion': ubicacion,
        'cliente_nombre': clienteNombre,
        'cliente_contacto': clienteContacto,
        'cliente_email': clienteEmail,
        'cliente_telefono': clienteTelefono,
        'cliente_direccion': clienteDireccion,
        'responsable_id': responsableId,
      }
    };
  }

  Map<String, dynamic> updateJson() {
    return {
      'idproyecto': idproyecto,
      'input': {
        'clave_proyecto': claveProyecto,
        'nombre': nombre,
        'descripcion': descripcion,
        'fecha_inicio': DateFormat('yyyy-MM-dd').format(fechaInicio),
        'fecha_fin': DateFormat('yyyy-MM-dd').format(fechaFin),
        'idestado': idestado,
        'presupuesto': presupuesto,
        'ubicacion': ubicacion,
        'cliente_nombre': clienteNombre,
        'cliente_contacto': clienteContacto,
        'cliente_email': clienteEmail,
        'cliente_telefono': clienteTelefono,
        'cliente_direccion': clienteDireccion,
        'responsable_id': responsableId,
      }
    };
  }

  @override
  String toString() {
    return 'Proyecto{idproyecto: $idproyecto, claveProyecto: $claveProyecto, nombre: $nombre, descripcion: $descripcion, fechaInicio: $fechaInicio, fechaFin: $fechaFin, idestado: $idestado, presupuesto: $presupuesto, ubicacion: $ubicacion, clienteNombre: $clienteNombre, clienteContacto: $clienteContacto, clienteEmail: $clienteEmail, clienteTelefono: $clienteTelefono, clienteDireccion: $clienteDireccion, responsableId: $responsableId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
