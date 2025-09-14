import 'package:constructoria/domain/repositories/empleado_perfil_queries.dart';

class EmpleadoPerfil {
  const EmpleadoPerfil({
    required this.idempleadoPerfil,
    required this.idempleado,
    required this.idperfil,
    required this.acceso,
  });

  final int? idempleadoPerfil;
  final int idempleado;
  final int idperfil;
  final bool acceso;

  factory EmpleadoPerfil.fromJson(Map<String, dynamic> json) {
    return EmpleadoPerfil(
      idempleadoPerfil: json['idempleado_perfil'] as int,
      idempleado: json['idempleado'] as int,
      idperfil: json['idperfil'] as int,
      acceso: json['acceso'] as bool,
    );
  }

  static List<EmpleadoPerfil> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EmpleadoPerfil.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idempleado_perfil': idempleadoPerfil,
      'idempleado': idempleado,
      'idperfil': idperfil,
      'acceso': acceso,
    };
  }

  Map<String, dynamic> data() {
    if(idempleadoPerfil == null) {
      return createJson();
    } else {
      return updateJson();
    }
  }

  Map<String, dynamic> createJson() {
    return {
      "input": {
        "idempleado": idempleado,
        "idperfil": idperfil,
        "acceso": acceso
      }
    };
  }

  Map<String, dynamic> updateJson() {
    return {
      "idempleado_perfil": idempleadoPerfil,
      "input": {
        "idempleado": idempleado,
        "idperfil": idperfil,
        "acceso": acceso
      }
    };
  }

  String query() {
    if(idempleadoPerfil == null) {
      return EmpleadoPerfilQueries.createEmpleadoPerfil;
    } else {
      return EmpleadoPerfilQueries.updateEmpleadoPerfil;
    }
  }


  @override
  String toString() {
    return 'EmpleadoPerfil{idempleadoPerfil: $idempleadoPerfil, idempleado: $idempleado, idperfil: $idperfil}';
  }
}
