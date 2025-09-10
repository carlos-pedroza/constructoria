import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:intl/intl.dart';

class Empleado {
  Empleado({
    this.idempleado,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.curp,
    required this.rfc,
    required this.nss,
    required this.direccion,
    required this.telefono,
    required this.correo,
    required this.password,
    required this.fechaIngreso,
    required this.puesto,
    required this.departamento,
    required this.salario,
    required this.estadoCivil,
    required this.sexo,
    required this.nacionalidad,
    required this.tipoContrato,
    required this.jornadaLaboral,
    required this.banco,
    required this.cuentaBancaria,
    required this.costoPorHora,
    required this.activo,
  });

  int? idempleado;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final DateTime fechaNacimiento;
  final String curp;
  final String rfc;
  final String nss;
  final String direccion;
  final String telefono;
  final String correo;
  final String password;
  final DateTime fechaIngreso;
  final String puesto;
  final String departamento;
  final double salario;
  final String estadoCivil;
  final String sexo;
  final String nacionalidad;
  final String tipoContrato;
  final String jornadaLaboral;
  final String banco;
  final String cuentaBancaria;
  final double costoPorHora;
  final bool activo;

  factory Empleado.fromJson(dynamic json) {
    return Empleado(
      idempleado: json['idempleado'] as int,
      nombre: json['nombre'] as String,
      apellidoPaterno: json['apellido_paterno'] as String,
      apellidoMaterno: json['apellido_materno'] as String,
      fechaNacimiento: DateTime.parse(json['fecha_nacimiento'] as String),
      curp: json['curp'] as String,
      rfc: json['rfc'] as String,
      nss: json['nss'] as String,
      direccion: json['direccion'] as String,
      telefono: json['telefono'] as String,
      correo: json['correo'] as String,
      password: json['password'] as String,
      fechaIngreso: DateTime.parse(json['fecha_ingreso'] as String),
      puesto: json['puesto'] as String,
      departamento: json['departamento'] as String,
      salario: (json['salario'] as num).toDouble(),
      estadoCivil: json['estado_civil'] as String,
      sexo: json['sexo'] as String,
      nacionalidad: json['nacionalidad'] as String,
      tipoContrato: json['tipo_contrato'] as String,
      jornadaLaboral: json['jornada_laboral'] as String,
      banco: json['banco'] as String,
      cuentaBancaria: json['cuenta_bancaria'] as String,
      costoPorHora: (json['costo_por_hora'] as num).toDouble(),
      activo: (json['activo'] == 1 || json['activo'] == true),
    );
  }

  factory Empleado.clone({Empleado? empleado}) {
    return Empleado(
      idempleado: empleado?.idempleado,
      nombre: empleado?.nombre ?? '',
      apellidoPaterno: empleado?.apellidoPaterno ?? '',
      apellidoMaterno: empleado?.apellidoMaterno ?? '',
      fechaNacimiento: empleado?.fechaNacimiento ?? DateTime.now(),
      curp: empleado?.curp ?? '',
      rfc: empleado?.rfc ?? '',
      nss: empleado?.nss ?? '',
      direccion: empleado?.direccion ?? '',
      telefono: empleado?.telefono ?? '',
      correo: empleado?.correo ?? '',
      password: empleado?.password ?? '',
      fechaIngreso: empleado?.fechaIngreso ?? DateTime.now(),
      puesto: empleado?.puesto ?? '',
      departamento: empleado?.departamento ?? '',
      salario: empleado?.salario ?? 0.0,
      estadoCivil: empleado?.estadoCivil ?? 'Soltero',
      sexo: empleado?.sexo ?? '',
      nacionalidad: empleado?.nacionalidad ?? '',
      tipoContrato: empleado?.tipoContrato ?? '',
      jornadaLaboral: empleado?.jornadaLaboral ?? '',
      banco: empleado?.banco ?? '',
      cuentaBancaria: empleado?.cuentaBancaria ?? '',
      costoPorHora: empleado?.costoPorHora ?? 0.0,
      activo: empleado?.activo ?? true,
    );
  }

  factory Empleado.empty() {
    return Empleado(
      nombre: '',
      apellidoPaterno: '',
      apellidoMaterno: '',
      fechaNacimiento: DateTime.now(),
      curp: '',
      rfc: '',
      nss: '',
      direccion: '',
      telefono: '',
      correo: '',
      password: '',
      fechaIngreso: DateTime.now(),
      puesto: '',
      departamento: '',
      salario: 0.0,
      estadoCivil: 'Soltero',
      sexo: '',
      nacionalidad: '',
      tipoContrato: '',
      jornadaLaboral: '',
      banco: '',
      cuentaBancaria: '',
      costoPorHora: 0.0,
      activo: true,
    );
  }

  static List<Empleado> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Empleado.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    if (idempleado == null) {
      return createJson();
    }
    return updateJson();
  }

  Map<String, dynamic> toJson2() {
    return {
      'idempleado': idempleado,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'fecha_nacimiento': DateFormat('yyyy-MM-dd').format(fechaNacimiento),
      'curp': curp,
      'rfc': rfc,
      'nss': nss,
      'direccion': direccion,
      'telefono': telefono,
      'correo': correo,
      'password': password,
      'fecha_ingreso': DateFormat('yyyy-MM-dd').format(fechaIngreso),
      'puesto': puesto,
      'departamento': departamento,
      'salario': salario,
      'estado_civil': estadoCivil,
      'sexo': sexo,
      'nacionalidad': nacionalidad,
      'tipo_contrato': tipoContrato,
      'jornada_laboral': jornadaLaboral,
      'banco': banco,
      'cuenta_bancaria': cuentaBancaria,
      'costo_por_hora': costoPorHora,
      'activo': activo,
    };
  }

  Map<String, dynamic> createJson() {
    return {
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'fecha_nacimiento': DateFormat('yyyy-MM-dd').format(fechaNacimiento),
      'curp': curp,
      'rfc': rfc,
      'nss': nss,
      'direccion': direccion,
      'telefono': telefono,
      'correo': correo,
      'password': password,
      'fecha_ingreso': DateFormat('yyyy-MM-dd').format(fechaIngreso),
      'puesto': puesto,
      'departamento': departamento,
      'salario': salario,
      'estado_civil': estadoCivil,
      'sexo': sexo,
      'nacionalidad': nacionalidad,
      'tipo_contrato': tipoContrato,
      'jornada_laboral': jornadaLaboral,
      'banco': banco,
      'cuenta_bancaria': cuentaBancaria,
      'costo_por_hora': costoPorHora,
      'activo': activo,
    };
  }

  Map<String, dynamic> updateJson() {
    return {
      'idempleado': idempleado,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'fecha_nacimiento': DateFormat('yyyy-MM-dd').format(fechaNacimiento),
      'curp': curp,
      'rfc': rfc,
      'nss': nss,
      'direccion': direccion,
      'telefono': telefono,
      'correo': correo,
      'password': password,
      'fecha_ingreso': DateFormat('yyyy-MM-dd').format(fechaIngreso),
      'puesto': puesto,
      'departamento': departamento,
      'salario': salario,
      'estado_civil': estadoCivil,
      'sexo': sexo,
      'nacionalidad': nacionalidad,
      'tipo_contrato': tipoContrato,
      'jornada_laboral': jornadaLaboral,
      'banco': banco,
      'cuenta_bancaria': cuentaBancaria,
      'costo_por_hora': costoPorHora,
      'activo': activo,
    };
  }

  String query() {
    if (idempleado == null) {
      return EmpleadoQueries.createEmpleado;
    } else {
      return EmpleadoQueries.updateEmpleado;
    }
  }

  @override
  String toString() {
    return 'Empleado{idempleado: $idempleado, nombre: $nombre, apellidoPaterno: $apellidoPaterno, apellidoMaterno: $apellidoMaterno, fechaNacimiento: $fechaNacimiento, curp: $curp, rfc: $rfc, nss: $nss, direccion: $direccion, telefono: $telefono, correo: $correo, password: $password, fechaIngreso: $fechaIngreso, puesto: $puesto, departamento: $departamento, salario: $salario, estadoCivil: $estadoCivil, sexo: $sexo, nacionalidad: $nacionalidad, tipoContrato: $tipoContrato, jornadaLaboral: $jornadaLaboral, banco: $banco, cuentaBancaria: $cuentaBancaria, costoPorHora: $costoPorHora, activo: $activo}';
  }
}
