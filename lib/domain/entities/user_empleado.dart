import 'package:constructoria/domain/entities/empleado.dart';

class UserEmpleado {
  UserEmpleado({
    this.idUserEmpleado,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
  });

  int? idUserEmpleado;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;

  factory UserEmpleado.fromEmpleado(Empleado empleado) {
    return UserEmpleado(
      idUserEmpleado: empleado.idempleado,
      nombre: empleado.nombre,
      apellidoPaterno: empleado.apellidoPaterno,
      apellidoMaterno: empleado.apellidoMaterno,
    );
  }

  factory UserEmpleado.fromJson(Map<String, dynamic> json) {
    return UserEmpleado(
      idUserEmpleado: json['idUserEmpleado'] as int,
      nombre: json['nombre'] as String,
      apellidoPaterno: json['apellido_paterno'] as String,
      apellidoMaterno: json['apellido_materno'] as String,
    );
  }

  static List<UserEmpleado> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserEmpleado.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idUserEmpleado': idUserEmpleado,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
    };
  }

  @override
  String toString() {
    return 'UserEmpleado{idUserEmpleado: $idUserEmpleado, nombre: $nombre, apellidoPaterno: $apellidoPaterno, apellidoMaterno: $apellidoMaterno}';
  }
}
