import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/domain/entities/empleado_perfil.dart';
import 'package:constructoria/domain/entities/perfil.dart';
import 'package:constructoria/domain/repositories/empleado_perfil_queries.dart';
import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:constructoria/domain/repositories/perfil_query.dart';
import 'package:constructoria/presentation/bloc/perfiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TrabajadorPage extends StatefulWidget {
  const TrabajadorPage({
    super.key,
    required this.client,
    required this.empleado,
    required this.refetch,
    required this.onSave,
    required this.onBack,
    required this.onDelete,
  });

  final GraphQLClient client;
  final Empleado empleado;
  final dynamic refetch;
  final void Function(dynamic refetch) onSave;
  final void Function() onBack;
  final void Function(dynamic refetch) onDelete;

  @override
  State<TrabajadorPage> createState() => _TrabajadorPageState();
}

class _TrabajadorPageState extends State<TrabajadorPage> {
  // Controladores para los campos
  final _nombreController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();
  final _curpController = TextEditingController();
  final _rfcController = TextEditingController();
  final _nssController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _fechaIngresoController = TextEditingController();
  final _puestoController = TextEditingController();
  final _departamentoController = TextEditingController();
  final _salarioController = TextEditingController();
  final _estadoCivilController = TextEditingController();
  final _sexoController = TextEditingController();
  final _nacionalidadController = TextEditingController();
  final _tipoContratoController = TextEditingController();
  final _jornadaLaboralController = TextEditingController();
  final _bancoController = TextEditingController();
  final _cuentaBancariaController = TextEditingController();
  final _costoPorHoraController = TextEditingController();
  bool _activo = false;
  late Empleado _empleado;
  var _saving = false;
  bool _isNew = true;

  Future<List<Perfil>> _fetchEmpleadoPerfiles(List<Perfil> perfiles) async {
    final query = EmpleadoPerfilQueries.getAllEmpleadosPerfiles;

    final options = QueryOptions(
      document: gql(query),
      variables: {'idempleado': widget.empleado.idempleado},
    );

    final result = await widget.client.query(options);

    if (result.hasException) {
      return [];
    }
    
    var empleadoPerfiles = EmpleadoPerfil.fromJsonList(result.data?['empleadoPerfiles'] ?? []);

    for (var perfil in perfiles) {
      var empleadoPerfil = empleadoPerfiles.where((ep) => ep.idperfil == perfil.idperfil);
      if (empleadoPerfil.isNotEmpty) {
        context.read<PerfilesBloc>().add(UpdatePerfilAcceso(perfil.idperfil, empleadoPerfil.first.acceso, empleadoPerfil.first.idempleadoPerfil));
      } 
    }
  

    return perfiles;
  }

  @override
  void initState() {
    super.initState();
    final empleado = widget.empleado;
    _isNew = empleado.idempleado == null;
    _nombreController.text = empleado.nombre;
    _apellidoPaternoController.text = empleado.apellidoPaterno;
    _apellidoMaternoController.text = empleado.apellidoMaterno;
    _fechaNacimientoController.text = empleado.fechaNacimiento
        .toIso8601String()
        .substring(0, 10);
    _curpController.text = empleado.curp;
    _rfcController.text = empleado.rfc;
    _nssController.text = empleado.nss;
    _direccionController.text = empleado.direccion;
    _telefonoController.text = empleado.telefono;
    _correoController.text = empleado.correo;
    _passwordController.text = empleado.password;
    _passwordConfirmationController.text = empleado.password;
    _fechaIngresoController.text = empleado.fechaIngreso
        .toIso8601String()
        .substring(0, 10);
    _puestoController.text = empleado.puesto;
    _departamentoController.text = empleado.departamento;
    _salarioController.text = empleado.salario.toString();
    _estadoCivilController.text = empleado.estadoCivil;
    _sexoController.text = empleado.sexo == 'M' ? 'Masculino' : 'Femenino';
    _nacionalidadController.text = empleado.nacionalidad;
    _tipoContratoController.text = empleado.tipoContrato;
    _jornadaLaboralController.text = empleado.jornadaLaboral;
    _bancoController.text = empleado.banco;
    _cuentaBancariaController.text = empleado.cuentaBancaria;
    _costoPorHoraController.text = empleado.costoPorHora.toString();
    _activo = empleado.activo;
    _empleado = empleado;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _fechaNacimientoController.dispose();
    _curpController.dispose();
    _rfcController.dispose();
    _nssController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _fechaIngresoController.dispose();
    _puestoController.dispose();
    _departamentoController.dispose();
    _salarioController.dispose();
    _estadoCivilController.dispose();
    _sexoController.dispose();
    _nacionalidadController.dispose();
    _tipoContratoController.dispose();
    _jornadaLaboralController.dispose();
    _bancoController.dispose();
    _cuentaBancariaController.dispose();
    _costoPorHoraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => PerfilesBloc(),
      child: BlocBuilder<PerfilesBloc, PerfilesState>(
        builder: (context, perfilesState) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: theme.colorScheme.secondaryContainer),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.colorScheme.outline,
                          width: 1,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: widget.onBack,
                              icon: Icon(Icons.arrow_back),
                            ),
                            SizedBox(width: 20),
                            Icon(Icons.person, size: 40),
                            SizedBox(width: 10),
                            Text(
                              'Trabajador',
                              style: theme.textTheme.headlineSmall!.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_saving)
                              SizedBox(width: 100, child: WaitTool())
                            else
                              Mutation(
                                options: MutationOptions(
                                  document: gql(_empleado.query()),
                                  onCompleted: (data) {
                                    if (data == null) return;
                                    if (data['createEmpleado'] != null || data['updateEmpleado'] != null) {
                                      try {
                                        final perfilesBloc = context.read<PerfilesBloc>();
                                        final perfiles = perfilesBloc.state.perfiles;
                                        _guardarPerfil(0, perfiles, onComplete: () {
                                          widget.onSave(widget.refetch);
                                          setState(() {
                                            _saving = false;
                                          });
                                          print('Empleado guardado: $data');
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                'El trabajador se guardó correctamente',
                                              ),
                                            ),
                                          );
                                          if(_isNew) {
                                            widget.onBack();
                                          }
                                        });
                                      }
                                      catch (e) {
                                        print('Error al guardar perfiles: $e');
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'Error al guardar perfiles del trabajador',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                    }
                                  },
                                  onError: (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Error al guardar trabajador'),
                                      ),
                                    );
                                    setState(() {
                                      _saving = false;
                                    });
                                  },
                                ),
                                builder: (runMutation, result) {
                                  return ElevatedButton.icon(
                                    onPressed: () => _onGuardar(runMutation),
                                    label: Text('Guardar'),
                                  );
                                },
                              ),
                            SizedBox(width: 10),
                            if(_empleado.idempleado != null)
                            Mutation(
                              options: MutationOptions(
                                document: gql(EmpleadoQueries.deleteEmpleado),
                                onCompleted: (data) {
                                  if (data == null) return;
                                  print('Empleado eliminado: $data');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'El trabajador se eliminó correctamente',
                                      ),
                                    ),
                                  );
                                  widget.onDelete(widget.refetch);
                                },
                                onError: (error) {
                                  print(error);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Error al eliminar trabajador'),
                                    ),
                                  );
                                },
                              ),
                              builder: (runMutation, result) {
                                return TextButton.icon(
                                  onPressed: () => _onEliminar(runMutation),
                                  label: Text(
                                    'Eliminar',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _sectionTitle(context, 'Datos Personales'),
                        Row(
                          children: [
                            Expanded(child: _textField(_nombreController, 'Nombre')),
                            Expanded(
                              child: _textField(
                                _apellidoPaternoController,
                                'Apellido Paterno',
                              ),
                            ),
                            Expanded(
                              child: _textField(
                                _apellidoMaternoController,
                                'Apellido Materno',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: TextFormField(
                                  controller: _fechaNacimientoController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Fecha de Nacimiento',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          _fechaNacimientoController.text.isNotEmpty
                                          ? DateTime.tryParse(
                                                  _fechaNacimientoController.text,
                                                ) ??
                                                DateTime.now()
                                          : DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        _fechaNacimientoController.text = pickedDate
                                            .toIso8601String()
                                            .substring(0, 10);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(child: _textField(_curpController, 'CURP')),
                            Expanded(child: _textField(_rfcController, 'RFC')),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: _textField(_nssController, 'NSS')),
                            Expanded(
                              child: _textField(_direccionController, 'Dirección'),
                            ),
                            Expanded(
                              child: _textField(_telefonoController, 'Teléfono'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: _textField(_correoController, 'Correo')),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _textFieldPassword(
                                      _passwordController,
                                      'Contraseña',
                                    ),
                                  ),
                                  Expanded(
                                    child: _textFieldPassword(
                                      _passwordConfirmationController,
                                      'Confirmar',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _sectionTitle(context, 'Datos Laborales'),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: TextFormField(
                                  controller: _fechaIngresoController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Fecha de Ingreso',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          _fechaIngresoController.text.isNotEmpty
                                          ? DateTime.tryParse(
                                                  _fechaIngresoController.text,
                                                ) ??
                                                DateTime.now()
                                          : DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        _fechaIngresoController.text = pickedDate
                                            .toIso8601String()
                                            .substring(0, 10);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(child: _textField(_puestoController, 'Puesto')),
                            Expanded(
                              child: _textField(
                                _departamentoController,
                                'Departamento',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _textField(
                                _salarioController,
                                'Salario',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: DropdownButtonFormField<String>(
                                  value: _estadoCivilController.text.isNotEmpty
                                      ? _estadoCivilController.text
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: 'Estado Civil',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Soltero',
                                      child: Text('Soltero'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Casado',
                                      child: Text('Casado'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Unión libre',
                                      child: Text('Unión libre'),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    setState(() {
                                      _estadoCivilController.text = val ?? '';
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: DropdownButtonFormField<String>(
                                  value: _sexoController.text.isNotEmpty
                                      ? _sexoController.text
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: 'Sexo',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Masculino',
                                      child: Text('Masculino'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Femenino',
                                      child: Text('Femenino'),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    setState(() {
                                      _sexoController.text = val ?? '';
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _textField(
                                _nacionalidadController,
                                'Nacionalidad',
                              ),
                            ),
                            Expanded(
                              child: _textField(
                                _tipoContratoController,
                                'Tipo de Contrato',
                              ),
                            ),
                            Expanded(
                              child: _textField(
                                _jornadaLaboralController,
                                'Jornada Laboral',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _sectionTitle(context, 'Datos Bancarios'),
                        Row(
                          children: [
                            Expanded(child: _textField(_bancoController, 'Banco')),
                            Expanded(
                              child: _textField(
                                _cuentaBancariaController,
                                'Cuenta Bancaria',
                              ),
                            ),
                            Expanded(
                              child: _textField(
                                _costoPorHoraController,
                                'Costo por Hora',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _sectionTitle(context, 'Perfiles de seguridad'),
                        Container(
                          decoration: BoxDecoration(color: theme.colorScheme.surface),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SwitchListTile(
                                        title: const Text('Activo'),
                                        value: _activo,
                                        onChanged: (val) {
                                          setState(() {
                                            _activo = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Query(
                                options: QueryOptions(
                                  document: gql(PerfilQuery.getAllPerfiles),
                                  fetchPolicy: FetchPolicy.networkOnly,
                                ),
                                builder: (result, {fetchMore, refetch}) {
                                  if (result.hasException) {
                                    return SizedBox(
                                      height: 300,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Error al cargar perfiles'),
                                        ],
                                      )
                                    );
                                  }
                                  if (result.isLoading) {
                                    return SizedBox(
                                      height: 300,
                                      child: Center(child: WaitTool())
                                    );
                                  }
                                  final perfiles = Perfil.fromJsonList(
                                    result.data?['perfiles'] ?? [],
                                  );
                                  // Actualiza el Bloc solo si está vacío
                                  if (perfilesState.perfiles.isEmpty && perfiles.isNotEmpty) {
                                    context.read<PerfilesBloc>().add(SetPerfiles(perfiles));
                                  }
                                  
                                  return FutureBuilder(
                                    future: _fetchEmpleadoPerfiles(perfilesState.perfiles),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return SizedBox(
                                          height: 300,
                                          child: Center(child: WaitTool())
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return SizedBox(
                                          height: 300,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Error al cargar perfiles del empleado'),
                                            ],
                                          )
                                        );
                                      } 

                                      return PerfilesComponent(
                                        perfiles: perfilesState.perfiles,
                                        onChanged: (perfil) {
                                          context.read<PerfilesBloc>().add(UpdatePerfilAcceso(perfil.idperfil, perfil.acceso, null));
                                        },
                                      );
                                    }
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, top: 24),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  var _oscureText = true;

  Widget _textFieldPassword(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          suffixIcon: IconButton(
            icon: Icon(_oscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _oscureText = !_oscureText;
              });
            },
          ),
        ),
        keyboardType: keyboardType,
        obscureText: _oscureText,
      ),
    );
  }

  void _onGuardar(runMutation) {
    setState(() {
      _saving = true;
    });
    if (_passwordController.text != _passwordConfirmationController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('La contraseña no coincide con la confirmación'),
        ),
      );
      setState(() {
        _saving = false;
      });
      return;
    }
    final empleado = Empleado(
      idempleado: widget.empleado.idempleado,
      nombre: _nombreController.text,
      apellidoPaterno: _apellidoPaternoController.text,
      apellidoMaterno: _apellidoMaternoController.text,
      fechaNacimiento:
          DateTime.tryParse(_fechaNacimientoController.text) ?? DateTime.now(),
      curp: _curpController.text,
      rfc: _rfcController.text,
      nss: _nssController.text,
      direccion: _direccionController.text,
      telefono: _telefonoController.text,
      correo: _correoController.text,
      password: _passwordController.text,
      fechaIngreso:
          DateTime.tryParse(_fechaIngresoController.text) ?? DateTime.now(),
      puesto: _puestoController.text,
      departamento: _departamentoController.text,
      salario: double.tryParse(_salarioController.text) ?? 0.0,
      estadoCivil: _estadoCivilController.text,
      sexo: _sexoController.text.isNotEmpty
          ? _sexoController.text.substring(0, 1).toUpperCase()
          : 'M',
      nacionalidad: _nacionalidadController.text,
      tipoContrato: _tipoContratoController.text,
      jornadaLaboral: _jornadaLaboralController.text,
      banco: _bancoController.text,
      cuentaBancaria: _cuentaBancariaController.text,
      costoPorHora: double.tryParse(_costoPorHoraController.text) ?? 0.0,
      activo: _activo,
    );
    runMutation(empleado.toJson());
  }

  Future<void> _guardarPerfil(int index, List<Perfil> perfiles, {required void Function() onComplete}) async {
    if(index >= perfiles.length) {
      onComplete();
      return;
    }
    final perfil = perfiles[index];
    var empleadoPerfil =  EmpleadoPerfil(
      idempleadoPerfil: perfil.idempleadoPerfil,
      idempleado: widget.empleado.idempleado!,
      idperfil: perfil.idperfil,
      acceso: perfil.acceso,
    );
    try {
      var mutation = MutationOptions(
        document: gql(empleadoPerfil.query()),
        variables: empleadoPerfil.data(),
        onCompleted: (data) {
          if (data == null) return;
          if(data['createEmpleadoPerfil'] != null) {
            var newEmpleadoPerfil = EmpleadoPerfil.fromJson(data['createEmpleadoPerfil']);
            context.read<PerfilesBloc>().add(UpdatePerfilAcceso(perfil.idperfil, perfil.acceso, newEmpleadoPerfil.idempleadoPerfil));
            print('EmpleadoPerfil creado: $newEmpleadoPerfil');
            _guardarPerfil(index + 1, perfiles, onComplete: onComplete);
          } else if(data['updateEmpleadoPerfil'] != null) {
            print('EmpleadoPerfil actualizado: $empleadoPerfil');
            _guardarPerfil(index + 1, perfiles,onComplete: onComplete);
          }
        },
        onError: (error) {
          print('Error al guardar empleado perfil: $error');
          throw Exception('Error al guardar empleado perfil');
        },
      );
      
      await widget.client.mutate(mutation);
  
    } catch (e) {
      throw Exception('Error al guardar empleado perfil');
    }

  }

  void _onEliminar(runMutation) { 
    DialogAsk.confirm(
      context: context, 
      title: 'Eliminar trabajador', 
      content: Text('¿Está seguro de eliminar este trabajador?'), 
      onYes: () {
        runMutation({
          'idempleado': widget.empleado.idempleado,
        });
      },
      onNo: (){}
    );
  }
}        

class PerfilesComponent extends StatefulWidget {
  const PerfilesComponent({super.key, required this.perfiles, required this.onChanged});

  final List<Perfil> perfiles;
  final void Function(Perfil perfil) onChanged;

  @override
  State<PerfilesComponent> createState() => _PerfilesComponentState();
}

class _PerfilesComponentState extends State<PerfilesComponent> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for(var index = 0; index < widget.perfiles.length; index++) ...[
          Divider(
            thickness: 1,
            height: 1,
            color: theme.colorScheme.outline,
          ),
          CheckboxListTile(
            title: Text(widget.perfiles[index].nombre),
            value: widget.perfiles[index].acceso,
            onChanged: (val) {
              setState(() {
                widget.perfiles[index].acceso = val ?? false;
              });
              widget.onChanged(widget.perfiles[index]);
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ]
      ],
    );
  }
}