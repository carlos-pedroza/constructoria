import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/tipo_beneficiario.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:constructoria/domain/entities/pago.dart';
import 'package:constructoria/domain/entities/estatus_pago.dart';
import 'package:constructoria/domain/repositories/pago_queries.dart';
import 'package:constructoria/domain/repositories/tipo_beneficiario_queries.dart';
import 'package:constructoria/domain/repositories/proveedor_queries.dart';
import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:constructoria/domain/repositories/metodo_pago_queries.dart';
import 'package:constructoria/domain/repositories/forma_pago_sat_queries.dart';
import 'package:constructoria/domain/repositories/proyecto_queries.dart';

class PagoPage extends StatefulWidget {
  final GraphQLClient client;
  final Pago pago;
  final void Function(Pago pago) onSave;
  final void Function(Pago pago) onBack;
  final void Function(Pago pago) onDelete;

  const PagoPage({
    super.key,
    required this.client,
    required this.pago,
    required this.onSave,
    required this.onBack,
    required this.onDelete,
  });

  @override
  State<PagoPage> createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  final _formKey = GlobalKey<FormState>();
  // Controladores de texto
  final _montoController = TextEditingController();
  final _referenciaBancariaController = TextEditingController();
  final _cuentaOrigenController = TextEditingController();
  final _cuentaDestinoController = TextEditingController();
  final _documentoUrlController = TextEditingController();
  final _comprobantePagoUrlController = TextEditingController();
  final _conceptoController = TextEditingController();
  final _notasController = TextEditingController();

  Pago? _pago;

  DateTime? _fechaProgramada;
  DateTime? _fechaPago;

  var _tipoBeneficiario = 0;
  var _beneficiarioId = 0;
  var _moneda = 0;
  var _metodoPago = 0;
  var _estatusPago = 0;
  var _formaPagoSat = 0;
  var _proyecto = 0;
  var _aprobadoPor = 0;

  bool _saving = false;

  void initData() {
    _pago = widget.pago;
    _montoController.text = _pago!.monto.toString();
    _referenciaBancariaController.text = _pago!.referenciaBancaria;
    _cuentaOrigenController.text = _pago!.cuentaOrigen;
    _cuentaDestinoController.text = _pago!.cuentaDestino;
    _documentoUrlController.text = _pago!.documentoUrl;
    _comprobantePagoUrlController.text = _pago!.comprobantePagoUrl;
    _conceptoController.text = _pago!.concepto;
    _notasController.text = _pago!.notas;
    _fechaProgramada = _pago!.fechaProgramada;
    _fechaPago = _pago!.fechaPago;
    _tipoBeneficiario = _pago!.idTipoBeneficiario;
    _beneficiarioId = _pago!.beneficiarioId;
    _moneda = _pago!.idMoneda;
    _metodoPago = _pago!.idMetodoPago;
    _estatusPago = _pago!.idEstatusPago;
    _formaPagoSat = _pago!.idFormaPagoSat;
    _proyecto = _pago!.idProyecto ?? 0;
    _aprobadoPor = _pago!.aprobadoPor ?? 0;
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void didUpdateWidget(covariant PagoPage oldWidget) {
    if (oldWidget.pago != widget.pago) {
      initData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _montoController.dispose();
    _referenciaBancariaController.dispose();
    _cuentaOrigenController.dispose();
    _cuentaDestinoController.dispose();
    _documentoUrlController.dispose();
    _comprobantePagoUrlController.dispose();
    _conceptoController.dispose();
    _notasController.dispose();
    super.dispose();
  }

  void _guardarPago(runMutation) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos obligatorios correctamente.')),
      );
      return;
    }

    // Validación de dropdowns requeridos
    if (_tipoBeneficiario == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seleccione un tipo de beneficiario.')),
      );
      return;
    }
    if (_beneficiarioId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seleccione un beneficiario.')),
      );
      return;
    }
    if (_moneda == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seleccione una moneda.')),
      );
      return;
    }
    if (_metodoPago == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seleccione un método de pago.')),
      );
      return;
    }
    if (_estatusPago == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seleccione un estatus de pago.')),
      );
      return;
    }
    if (_formaPagoSat == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seleccione una forma de pago SAT.')),
      );
      return;
    }
    if (_aprobadoPor == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seleccione quién aprueba el pago.')),
      );
      return;
    }

    setState(() { _saving = true; });
    _pago = Pago(
      idpago: widget.pago.idpago,
      idTipoBeneficiario: _tipoBeneficiario,
      beneficiarioId: _beneficiarioId,
      monto: double.tryParse(_montoController.text) ?? 0.0,
      idMoneda: _moneda,
      idMetodoPago: _metodoPago,
      idEstatusPago: _estatusPago,
      fechaProgramada: _fechaProgramada ?? DateTime.now(),
      fechaPago: _fechaPago ?? DateTime.now(),
      idFormaPagoSat: _formaPagoSat,
      referenciaBancaria: _referenciaBancariaController.text,
      cuentaOrigen: _cuentaOrigenController.text,
      cuentaDestino: _cuentaDestinoController.text,
      documentoUrl: _documentoUrlController.text,
      comprobantePagoUrl: _comprobantePagoUrlController.text,
      idProyecto: _proyecto == 0 ? null : _proyecto,
      concepto: _conceptoController.text,
      notas: _notasController.text,
      creadoEn: DateTime.now(),
      actualizadoEn: DateTime.now(),
      aprobadoPor: _aprobadoPor,
    );
    runMutation({'input': _pago});
  }

  void _onCambiarEstatus(runMutation) {
    DialogAsk.confirm(
      context: context, 
      title: 'Cambiar Estatus de Pago', 
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '¿Desea cambiar el estatus de este pago?',
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ],
      ),
      onYes: ()=>_cambiarEstatus(runMutation), 
      onNo: () {}
    );
  }

  void _cambiarEstatus(runMutation) {
    setState(() { _saving = true; });
    widget.pago.idEstatusPago = EstatusPago.nextId( widget.pago.idEstatusPago);
    runMutation({'input': widget.pago});
  }

  // Widget _sectionTitle(BuildContext context, String title) {
  //   return Container(
  //     width: double.infinity,
  //     margin: const EdgeInsets.only(bottom: 8, top: 24),
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //     decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
  //     child: Text(
  //       title,
  //       style: Theme.of(context).textTheme.titleSmall!.copyWith(
  //         color: Theme.of(context).colorScheme.surface,
  //       ),
  //     ),
  //   );
  // }

  Widget _textField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es obligatorio';
          }
          if (keyboardType == TextInputType.number) {
            final number = double.tryParse(value.replaceAll(',', '.'));
            if (number == null) {
              return 'Ingrese un número válido';
            }
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier<GraphQLClient>(widget.client),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: theme.colorScheme.secondaryContainer,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TitlePageComponent(onClose: _onClose),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 20),
                            Icon(Icons.monetization_on_rounded, size: 40),
                            SizedBox(width: 10),
                            Text(
                              'Pago',
                              style: theme.textTheme.headlineSmall!.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(width: 10),
                            Chip(
                              label: Text(EstatusPago.displayName(_estatusPago), style: TextStyle(fontWeight: FontWeight.bold)),
                              backgroundColor: EstatusPago.getColor(_estatusPago),
                              labelStyle: theme.textTheme.titleMedium!.copyWith(
                                color: theme.colorScheme.surfaceContainerLowest,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        if(widget.pago.idEstatusPago != EstatusPago.cancelado)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if(widget.pago.idpago != null)
                            Mutation(
                              options: MutationOptions(
                                document: gql(PagoQueries.createPago), // Cambia por la mutation de eliminar si existe
                                onCompleted: (data) {
                                  if(data == null) return;
                                  setState(() { _saving = false; });
                                  widget.onSave(_pago!);
                                  Navigator.of(context).pop();
                                },
                                onError: (error) {
                                  setState(() { _saving = false; });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error al cambiar estatus del pago')),
                                  );
                                },
                              ),
                              builder: (runMutation, result) {
                                return Container(
                                  margin: EdgeInsets.only(left: 40, right: 20), 
                                  width: MediaQuery.of( context).size.width * 0.25,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: EstatusPago.getColor(EstatusPago.nextId(_estatusPago)),
                                    ),
                                    onPressed: ()=> _onCambiarEstatus(runMutation),
                                    child: Text(EstatusPago.nextEstatus(_estatusPago), style: theme.textTheme.titleMedium!.copyWith(
                                      color: theme.colorScheme.surfaceContainerLowest
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }
                            ),
                            Mutation(
                              options: MutationOptions(
                                document: gql(PagoQueries.createPago),
                                onCompleted: (data) {
                                  if(data == null) return;
                                  setState(() { _saving = false; });
                                  widget.onSave(_pago!);
                                  if(widget.pago.idpago == null) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                onError: (error) {
                                  setState(() { _saving = false; });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error al guardar el pago')),
                                  );
                                },
                              ),
                              builder: (runMutation, result) {
                                return Column(
                                  children: [
                                    if (_saving)
                                      const SizedBox(width: 120, child: Center(child: WaitTool()))
                                    else
                                      ElevatedButton.icon(
                                        onPressed: ()=>_guardarPago(runMutation),
                                        icon: const Icon(Icons.save),
                                        label: const Text('Guardar'),
                                      ),
                                  ],
                                );
                              }
                            ),
                            const SizedBox(width: 10),
                            if(widget.pago.idpago != null)
                            Mutation(
                              options: MutationOptions(
                                document: gql(PagoQueries.createPago), // Cambia por la mutation de eliminar si existe
                                onCompleted: (data) {
                                  if(data == null) return;
                                  setState(() { _saving = false; });
                                  widget.onDelete(_pago!);
                                  Navigator.of(context).pop();
                                },
                                onError: (error) {
                                  setState(() { _saving = false; });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error al cancelar el pago')),
                                  );
                                },
                              ),
                              builder: (runMutation, result) {
                                return Column(
                                  children: [
                                    if (_saving)
                                      SizedBox(width: 120)
                                    else
                                    TextButton.icon(
                                      onPressed: ()=>_onCancelarPago(runMutation),
                                      icon: const Icon(Icons.block_flipped, color: Colors.red),
                                      label: Text(
                                        'Cancelar pago',
                                        style: theme.textTheme.bodyMedium!.copyWith(
                                          color: theme.colorScheme.error,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            )
                            else
                            SizedBox(width: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(flex: 300, child: _textField(_conceptoController, 'Concepto')),
                            Expanded(flex: 300, child: _textField(_cuentaDestinoController, 'Cuenta Destino')),
                            Expanded(flex: 300, child: _textField(_cuentaOrigenController, 'Cuenta Origen')),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(children: [
                          Expanded(flex: 300, child: _textField(_referenciaBancariaController, 'Referencia Bancaria')),
                          Expanded(
                            flex: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Query(
                                options: QueryOptions(document: gql(ProveedorQueries.monedas)),
                                builder: (result, {fetchMore, refetch}) {
                                  if (result.isLoading) {
                                    return SizedBox(width: 100, child: Center(child: WaitTool()));
                                  }
                                  if (result.hasException) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text('Error Moneda'),
                                    );
                                  }
                                  var monedas = result.data?['monedas'] ?? [];
                                  monedas.removeWhere((p) => p['id_moneda'] == 0);
                                  monedas.insert(0, {'id_moneda': 0, 'descripcion': 'Seleccione Moneda'});
                                            
                                  return DropdownButtonFormField<int>(
                                    initialValue: _moneda,
                                    decoration: const InputDecoration(
                                      labelText: 'Moneda',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: [for (var m in monedas) DropdownMenuItem(value: m['id_moneda'], child: Text(m['descripcion']))],
                                    onChanged: (val) { setState(() { _moneda = val!; }); },
                                  );
                                }
                              ),
                            ),
                          ),
                          Expanded(flex: 300, child: _textField(_montoController, 'Monto', keyboardType: TextInputType.number)),
                        ]),
                        SizedBox(height: 16),
                        Row(children: [
                          SizedBox(width: 8),
                          Expanded(
                            flex: 295,
                            child: Query(
                              options: QueryOptions(document: gql(TipoBeneficiarioQueries.getAllTipoBeneficiarios)),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {
                                  return SizedBox(width: 100, child: Center(child: WaitTool()));
                                }
                                if (result.hasException) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text('Error TB'),
                                  );
                                }
              
                                var tipos = result.data?['tipoBeneficiarios'] ?? [];
                                tipos.removeWhere((t) => t['id_tipo_beneficiario'] == 0);
                                tipos.insert(0, {'id_tipo_beneficiario': 0, 'descripcion': 'Seleccione Tipo'});
              
                                return DropdownButtonFormField<int>(
                                  initialValue: _tipoBeneficiario,
                                  decoration: const InputDecoration(
                                    labelText: 'Tipo de Beneficiario',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [for (var t in tipos) DropdownMenuItem(value: t['id_tipo_beneficiario'], child: Text(t['descripcion']))],
                                  onChanged: (val) {
                                    setState(() { _tipoBeneficiario = val!; _beneficiarioId = 0; });
                                  },
                                );
                              }
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 600,
                            child: Column(
                              children: [
                                if(_tipoBeneficiario == TipoBeneficiario.proveedor)
                                Query(
                                  options: QueryOptions(document: gql(ProveedorQueries.proveedores)),
                                  builder: (result, {fetchMore, refetch}) {
                                    if (result.isLoading) {
                                      return SizedBox(width: 100, child: Center(child: WaitTool()));
                                    }
                                    if (result.hasException) {
                                      return Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text('Error Proveedor'),
                                      );
                                    }
                                    var proveedores = result.data?['proveedores'] ?? [];
                                    proveedores.removeWhere((p) => p['id_proveedor'] == 0);
                                    proveedores.insert(0, {'id_proveedor': 0, 'razon_social': 'Seleccione Proveedor'});
              
                                    return DropdownButtonFormField<int>(
                                      initialValue: _beneficiarioId,
                                      decoration: const InputDecoration(
                                        labelText: 'Proveedor',
                                        border: OutlineInputBorder(),
                                      ),
                                      items: [for (var p in proveedores) DropdownMenuItem(value: p['id_proveedor'], child: Text(p['razon_social'] ?? ''))],
                                      onChanged: (val) { setState(() { _beneficiarioId = val!; }); },
                                    );
                                  }
                                )
                              else if(_tipoBeneficiario == TipoBeneficiario.empleado)
                              Query(
                                options: QueryOptions(document: gql(EmpleadoQueries.getAllEmpleados)),
                                builder: (result, {fetchMore, refetch}) {
                                  if (result.isLoading) {
                                    return SizedBox(width: 100, child: Center(child: WaitTool()));
                                  }
                                  if (result.hasException) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text('Error Empleado'),
                                    );
                                  }
                                  var empleados = result.data?['empleados'] ?? [];
                                  empleados.removeWhere((e) => e['idempleado'] == 0);
                                  empleados.insert(0, {'idempleado': 0, 'nombre': 'Seleccione Empleado', 'apellido_paterno': ''});
              
                                  return DropdownButtonFormField<int>(
                                    initialValue: _beneficiarioId,
                                    decoration: const InputDecoration(
                                      labelText: 'Empleado',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: [for (var e in empleados) DropdownMenuItem(value: e['idempleado'], child: Text('${e['nombre']} ${e['apellido_paterno']} ${e['apellido_materno'] ?? ''}'))],
                                    onChanged: (val) { setState(() { _beneficiarioId = val!; }); },
                                  );
                                })
                                else 
                                Container(
                                  height: 46,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                )
                              ]
                            ), 
                          ),
                          SizedBox(width: 8),
                        ]),
                        SizedBox(height: 16),
                        Row(children: [
                          SizedBox(width: 8),
                          Expanded(
                            flex: 300,
                            child: Query(
                              options: QueryOptions(document: gql(MetodoPagoQueries.getAllMetodoPagos)),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {
                                  return SizedBox(width: 100, child: Center(child: WaitTool()));
                                }
                                if (result.hasException) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text('Error MP'),
                                  );
                                }
                                var metodos = result.data?['metodoPagos'] ?? [];
                                metodos.removeWhere((m) => m['id_metodo_pago'] == 0);
                                metodos.insert(0, {'id_metodo_pago': 0, 'descripcion': 'Seleccione Método de Pago'});
              
                                return DropdownButtonFormField<int>(
                                  initialValue: _metodoPago,
                                  decoration: const InputDecoration(
                                    labelText: 'Método de Pago',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [for (var m in metodos) DropdownMenuItem(value: m['id_metodo_pago'], child: Text(m['descripcion']))],
                                  onChanged: (val) { setState(() { _metodoPago = val!; }); },
                                );
                              }
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 300,
                            child: Query(
                              options: QueryOptions(document: gql(FormaPagoSatQueries.getAllFormaPagoSats)),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {
                                  return SizedBox(width: 100, child: Center(child: WaitTool()));
                                }
                                if (result.hasException) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text('Error FPSAT'),
                                  );
                                }
                                var formas = result.data?['formaPagoSats'] ?? [];
                                formas.removeWhere((f) => f['id_forma_pago_sat'] == 0);
                                formas.insert(0, {'id_forma_pago_sat': 0, 'descripcion': 'Seleccione Forma de Pago SAT'});
              
                                return DropdownButtonFormField<int>(
                                  initialValue: _formaPagoSat,
                                  decoration: const InputDecoration(
                                    labelText: 'Forma de Pago SAT',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [for (var f in formas) DropdownMenuItem(value: f['id_forma_pago_sat'], child: Text(f['descripcion']))],
                                  onChanged: (val) { setState(() { _formaPagoSat = val!; }); },
                                );
                              }
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 300,
                            child: Query(
                              options: QueryOptions(document: gql(ProyectoQueries.getAllProyectos)),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {
                                  return SizedBox(width: 100, child: Center(child: WaitTool()));
                                }
                                if (result.hasException) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text('Error Proyecto'),
                                  );
                                }
                                var proyectos = result.data?['getAllProyectos'] ?? [];
                                proyectos.removeWhere((p) => p['idproyecto'] == 0);
                                proyectos.insert(0, {'idproyecto': 0, 'nombre': 'No relacionado a un proyecto'});
              
                                return DropdownButtonFormField<int>(
                                  initialValue: _proyecto,
                                  decoration: const InputDecoration(
                                    labelText: 'Proyecto',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [for (var p in proyectos) DropdownMenuItem(value: p['idproyecto'], child: Text(p['nombre']))],
                                  onChanged: (val) { setState(() { _proyecto = val!; }); },
                                );
                              }
                            ),
                          ),
                          SizedBox(width: 8),
                        ]),
                        SizedBox(height: 16),
                        Row(children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: _fechaProgramada ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) setState(() { _fechaProgramada = picked; });
                                },
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Fecha Programada',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  child: Text(
                                    _fechaProgramada != null
                                        ? _fechaProgramada!.toLocal().toString().split(' ')[0]
                                        : '',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: _fechaPago ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) setState(() { _fechaPago = picked; });
                                },
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Fecha Pago',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  child: Text(
                                    _fechaPago != null
                                        ? _fechaPago!.toLocal().toString().split(' ')[0]
                                        : '',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Query(
                              options: QueryOptions(document: gql(EmpleadoQueries.getAllEmpleados)),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {
                                  return SizedBox(width: 100, child: Center(child: WaitTool()));
                                }
                                if (result.hasException) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text('Error AprobadoPor'),
                                  );
                                }
                                var empleados = result.data?['empleados'] ?? [];
                                empleados.removeWhere((e) => e['idempleado'] == 0); 
                                empleados.insert(0, {'idempleado': 0, 'nombre': 'Seleccione Empleado', 'apellido_paterno': ''});
              
                                return DropdownButtonFormField<int>(
                                  initialValue: _aprobadoPor,
                                  decoration: const InputDecoration(
                                    labelText: 'Aprobado Por',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [for (var e in empleados) DropdownMenuItem(value: e['idempleado'], child: Text('${e['nombre']} ${e['apellido_paterno']} ${e['apellido_materno'] ?? ''}'))],
                                  onChanged: (val) { setState(() { _aprobadoPor = val!; }); },
                                );
                              }
                            ),
                          ),
                        ]),
                        SizedBox(height: 16),
                        Row(children: [
                          Expanded(child: _textField(_notasController, 'Notas')),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onClose() {
    Navigator.of(context).pop();
  }

  void _onCancelarPago(runMutation) {
    DialogAsk.confirm(
      context: context, 
      title: 'Cancelar Pago', 
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text(
            '¿Está seguro que desea cancelar este pago? Esta acción no se puede deshacer.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
      onYes: ()=>_cancelPago(runMutation), 
      onNo: () {}
    );
  }

  void _cancelPago(runMutation) {
    setState(() { _saving = true; });
    widget.pago.idEstatusPago = EstatusPago.cancelado;
    runMutation({'input': widget.pago});
  }
}