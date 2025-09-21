import 'package:constructoria/domain/repositories/proyecto_queries.dart';
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
    this.estado,
    required this.presupuesto,
    required this.ubicacion,
    required this.clienteNombre,
    required this.clienteContacto,
    required this.clienteEmail,
    required this.clienteTelefono,
    required this.clienteDireccion,
    required this.responsableId,
    this.responsable,
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
  final String? estado;
  final double presupuesto;
  final String ubicacion;
  final String clienteNombre;
  final String clienteContacto;
  final String clienteEmail;
  final String clienteTelefono;
  final String clienteDireccion;
  final int responsableId;
  final String? responsable;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Proyecto.fromJson(dynamic json) {
    String? estadoNombre;
    if (json['estado'] != null) {
      if (json['estado'] is Map && json['estado']['nombre'] != null) {
        estadoNombre = json['estado']['nombre'] as String;
      }
    }

    String? responsableNombre;
    if (json['responsable'] != null) {
      if (json['responsable'] is Map) {
        final r = json['responsable'];
        responsableNombre = [r['nombre'], r['apellido_paterno'], r['apellido_materno']]
          .where((e) => e != null && (e as String).isNotEmpty)
          .join(' ');
      } else if (json['responsable'] is String) {
        responsableNombre = json['responsable'] as String;
      }
    }

    DateTime fechaInicio = DateTime.now();
    if (json['fecha_inicio'] != null) {
      try {
        fechaInicio = DateTime.parse(json['fecha_inicio']);
      } catch (_) {
        fechaInicio = DateTime.now();
      }
    }
    DateTime fechaFin = DateTime.now();
    if (json['fecha_fin'] != null) {
      try {
        fechaFin = DateTime.parse(json['fecha_fin']);
      } catch (_) {
        fechaFin = DateTime.now();
      }
    }

    return Proyecto(
      idproyecto: json['idproyecto'] as int?,
      claveProyecto: json['clave_proyecto'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String? ?? '',
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
      idestado: json['idestado'] as int,
      estado: estadoNombre,
      presupuesto: json['presupuesto'] != null ? (json['presupuesto'] as num).toDouble() : 0.0,
      ubicacion: json['ubicacion'] as String? ?? '',
      clienteNombre: json['cliente_nombre'] as String? ?? '',
      clienteContacto: json['cliente_contacto'] as String? ?? '',
      clienteEmail: json['cliente_email'] as String? ?? '',
      clienteTelefono: json['cliente_telefono'] as String? ?? '',
      clienteDireccion: json['cliente_direccion'] as String? ?? '',
      responsableId: json['responsable_id'] as int? ?? 0,
      responsable: responsableNombre,
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
        'fecha_inicio': DateFormat('yyyy-MM-dd 00:00:00').format(fechaInicio),
        'fecha_fin': DateFormat('yyyy-MM-dd 00:00:00').format(fechaFin),
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
      "input": {
        "clave_proyecto": claveProyecto,
        "nombre": nombre,
        "descripcion": descripcion,
        "fecha_inicio": DateFormat('yyyy-MM-dd 00:00:00').format(fechaInicio),
        "fecha_fin": DateFormat('yyyy-MM-dd 00:00:00').format(fechaFin),
        "idestado": idestado,
        "presupuesto": 1800000,
        "ubicacion": ubicacion,
        "cliente_nombre": clienteNombre,
        "cliente_contacto": clienteContacto,
        "cliente_email": clienteEmail,
        "cliente_telefono": clienteTelefono,
        "cliente_direccion": clienteDireccion,
        "responsable_id": responsableId
      }
    };
  }

  Map<String, dynamic> updateJson() {
    return {
      "idproyecto": idproyecto,
      "input": {
          "clave_proyecto": claveProyecto,
          "nombre": nombre,
          "descripcion": descripcion,
          "fecha_inicio": DateFormat('yyyy-MM-dd 00:00:00').format(fechaInicio),
          "fecha_fin": DateFormat('yyyy-MM-dd 00:00:00').format(fechaFin),
          "idestado": idestado,
          "presupuesto": presupuesto,
          "ubicacion": ubicacion,
          "cliente_nombre": clienteNombre,
          "cliente_contacto": clienteContacto,
          "cliente_email": clienteEmail,
          "cliente_telefono": clienteTelefono,
          "cliente_direccion": clienteDireccion,
          "responsable_id": responsableId
      }
    };
  }

  String get query {
	if (idproyecto == null) {
	  return ProyectoQueries.createProyecto;
	} else {
	  return ProyectoQueries.updateProyecto;
	}
  }

  @override
  String toString() {
    return 'Proyecto{idproyecto: $idproyecto, claveProyecto: $claveProyecto, nombre: $nombre, descripcion: $descripcion, fechaInicio: $fechaInicio, fechaFin: $fechaFin, idestado: $idestado, presupuesto: $presupuesto, ubicacion: $ubicacion, clienteNombre: $clienteNombre, clienteContacto: $clienteContacto, clienteEmail: $clienteEmail, clienteTelefono: $clienteTelefono, clienteDireccion: $clienteDireccion, responsableId: $responsableId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
