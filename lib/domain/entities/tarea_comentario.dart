import 'package:intl/intl.dart';

class TareaComentario {
  TareaComentario({
    this.idtareaComentario,
    required this.idtarea,
    required this.comentarios,
    required this.idempleado,
    this.empleadoNombre,
    required this.creado,
  });

  int? idtareaComentario;
  int idtarea;
  String comentarios;
  int idempleado;
  String? empleadoNombre;
  DateTime creado;

  factory TareaComentario.fromJson(dynamic json) {
    return TareaComentario(
      idtareaComentario: json['idtarea_comentario'] as int?,
      idtarea: json['idtarea'] as int,
      comentarios: json['comentarios'] as String? ?? '',
      idempleado: json['idempleado'] as int,
      empleadoNombre: '${json['empleado']?['nombre']} ${json['empleado']?['apellido_paterno']} ${json['empleado']?['apellido_materno']}',
      creado: json['creado'] != null ? DateTime.parse(json['creado']) : DateTime.now(),
    );
  }

  static List<TareaComentario> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TareaComentario.fromJson(json)).toList();
  }

  factory TareaComentario.empty(int idtarea, int idempleado) {
    return TareaComentario(
      idtareaComentario: null,
      idtarea: idtarea,
      comentarios: '',
      idempleado: idempleado,
      creado: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    if(idtareaComentario == null) {
      return {
        "idtarea": idtarea,
        "comentarios": comentarios,
        "idempleado": idtarea,
        "creado": "2025-11-16T13:41:00Z"
      };
    }
    return {
      'idtarea_comentario': idtareaComentario,
      'idtarea': idtarea,
      'comentarios': comentarios,
      'idempleado': idempleado,
      'creado': DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado),
    };
  }

  @override
  String toString() {
    return '$idtareaComentario\t$idtarea\t$comentarios\t${DateFormat('yyyy-MM-ddTHH:mm:ss').format(creado)}';
  }
}