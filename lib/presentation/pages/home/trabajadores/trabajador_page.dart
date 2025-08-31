import 'package:constructoria/domain/entities/empleado.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TrabajadorPage extends StatefulWidget {
  const TrabajadorPage({
    super.key,
    required this.client,
    required this.empleado,
    required this.onBack,
  });

  final GraphQLClient client;
  final Empleado empleado;
  final void Function() onBack;

  @override
  State<TrabajadorPage> createState() => _TrabajadorPageState();
}

class _TrabajadorPageState extends State<TrabajadorPage> {
  // Perfiles de acceso
  bool _perfilAccesoApp = false;
  bool _perfilModuloTrabajadores = false;
  bool _perfilModuloProyectos = false;
  bool _perfilModuloPagos = false;
  bool _perfilAppMobilTrabajador = false;
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

  @override
  void initState() {
    super.initState();
    final empleado = widget.empleado;
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
    _fechaIngresoController.text = empleado.fechaIngreso
        .toIso8601String()
        .substring(0, 10);
    _puestoController.text = empleado.puesto;
    _departamentoController.text = empleado.departamento;
    _salarioController.text = empleado.salario.toString();
    _estadoCivilController.text = empleado.estadoCivil;
    _sexoController.text = empleado.sexo;
    _nacionalidadController.text = empleado.nacionalidad;
    _tipoContratoController.text = empleado.tipoContrato;
    _jornadaLaboralController.text = empleado.jornadaLaboral;
    _bancoController.text = empleado.banco;
    _cuentaBancariaController.text = empleado.cuentaBancaria;
    _costoPorHoraController.text = empleado.costoPorHora.toString();
    _activo = empleado.activo;
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
                  IconButton(
                    onPressed: widget.onBack,
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Trabajador',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _onGuardar,
                    label: Text('Guardar'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                        child: _textField(
                          _fechaNacimientoController,
                          'Fecha de Nacimiento',
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
                        child: _textField(_passwordController, 'Password'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _sectionTitle(context, 'Datos Laborales'),
                  Row(
                    children: [
                      Expanded(
                        child: _textField(
                          _fechaIngresoController,
                          'Fecha de Ingreso',
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
                        child: _textField(
                          _estadoCivilController,
                          'Estado Civil',
                        ),
                      ),
                      Expanded(child: _textField(_sexoController, 'Sexo')),
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
                  _sectionTitle(context, 'Perfiles de acceso'),
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
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: theme.colorScheme.outline,
                        ),
                        CheckboxListTile(
                          title: const Text('Acceso aplicación'),
                          value: _perfilAccesoApp,
                          onChanged: (val) {
                            setState(() {
                              _perfilAccesoApp = val ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: theme.colorScheme.outline,
                        ),
                        CheckboxListTile(
                          title: const Text('Modulo trabajadores'),
                          value: _perfilModuloTrabajadores,
                          onChanged: (val) {
                            setState(() {
                              _perfilModuloTrabajadores = val ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: theme.colorScheme.outline,
                        ),
                        CheckboxListTile(
                          title: const Text('Modulo Proyectos y tareas'),
                          value: _perfilModuloProyectos,
                          onChanged: (val) {
                            setState(() {
                              _perfilModuloProyectos = val ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: theme.colorScheme.outline,
                        ),
                        CheckboxListTile(
                          title: const Text('Modulo Pagos'),
                          value: _perfilModuloPagos,
                          onChanged: (val) {
                            setState(() {
                              _perfilModuloPagos = val ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: theme.colorScheme.outline,
                        ),
                        CheckboxListTile(
                          title: const Text('Aplicación mobil trabajador'),
                          value: _perfilAppMobilTrabajador,
                          onChanged: (val) {
                            setState(() {
                              _perfilAppMobilTrabajador = val ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
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

  void _onGuardar() {}
}
