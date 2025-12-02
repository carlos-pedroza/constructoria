import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:constructoria/domain/entities/pago.dart';
import 'package:constructoria/domain/entities/estatus_pago.dart';
import 'package:constructoria/domain/repositories/pago_queries.dart';
import 'package:constructoria/domain/repositories/tipo_beneficiario_queries.dart';
import 'package:constructoria/domain/repositories/proveedor_queries.dart';
import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:constructoria/domain/repositories/metodo_pago_queries.dart';
import 'package:constructoria/domain/repositories/estatus_pago_queries.dart';
import 'package:constructoria/domain/repositories/forma_pago_sat_queries.dart';
import 'package:constructoria/domain/repositories/proyecto_queries.dart';

class PagoPage extends StatefulWidget {
  final GraphQLClient client;
  final Pago pago;
  final void Function()? onSave;
  final void Function()? onBack;
  final void Function()? onDelete;

  const PagoPage({
    super.key,
    required this.client,
    required this.pago,
    this.onSave,
    this.onBack,
    this.onDelete,
  });

  @override
  State<PagoPage> createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  // Controladores de texto
  late TextEditingController _montoController;
  late TextEditingController _referenciaBancariaController;
  late TextEditingController _cuentaOrigenController;
  late TextEditingController _cuentaDestinoController;
  late TextEditingController _documentoUrlController;
  late TextEditingController _comprobantePagoUrlController;
  late TextEditingController _conceptoController;
  late TextEditingController _notasController;

  DateTime? _fechaProgramada;
  DateTime? _fechaPago;

  int? _tipoBeneficiario;
  int? _beneficiarioId;
  int? _moneda;
  int? _metodoPago;
  int? _estatusPago;
  int? _formaPagoSat;
  int? _proyecto;
  int? _aprobadoPor;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final p = widget.pago;
    _montoController = TextEditingController(text: p.monto.toString());
    _referenciaBancariaController = TextEditingController(text: p.referenciaBancaria);
    _cuentaOrigenController = TextEditingController(text: p.cuentaOrigen);
    _cuentaDestinoController = TextEditingController(text: p.cuentaDestino);
    _documentoUrlController = TextEditingController(text: p.documentoUrl);
    _comprobantePagoUrlController = TextEditingController(text: p.comprobantePagoUrl);
    _conceptoController = TextEditingController(text: p.concepto);
    _notasController = TextEditingController(text: p.notas);
    _fechaProgramada = p.fechaProgramada;
    _fechaPago = p.fechaPago;
    _tipoBeneficiario = p.idTipoBeneficiario;
    _beneficiarioId = p.beneficiarioId;
    _moneda = p.idMoneda;
    _metodoPago = p.idMetodoPago;
    _estatusPago = p.idEstatusPago;
    _formaPagoSat = p.idFormaPagoSat;
    _proyecto = p.idProyecto;
    _aprobadoPor = p.aprobadoPor;
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
    setState(() { _saving = true; });
    final pago = Pago(
      idpago: widget.pago.idpago,
      idTipoBeneficiario: _tipoBeneficiario ?? 0,
      beneficiarioId: _beneficiarioId ?? 0,
      monto: double.tryParse(_montoController.text) ?? 0.0,
      idMoneda: _moneda ?? 0,
      idMetodoPago: _metodoPago ?? 0,
      idEstatusPago: _estatusPago ?? EstatusPago.ingresdo,
      fechaProgramada: _fechaProgramada ?? DateTime.now(),
      fechaPago: _fechaPago ?? DateTime.now(),
      idFormaPagoSat: _formaPagoSat ?? 0,
      referenciaBancaria: _referenciaBancariaController.text,
      cuentaOrigen: _cuentaOrigenController.text,
      cuentaDestino: _cuentaDestinoController.text,
      documentoUrl: _documentoUrlController.text,
      comprobantePagoUrl: _comprobantePagoUrlController.text,
      idProyecto: _proyecto,
      concepto: _conceptoController.text,
      notas: _notasController.text,
      creadoEn: DateTime.now(),
      actualizadoEn: DateTime.now(),
      aprobadoPor: _aprobadoPor,
    );
    runMutation({'input': pago});
  }

  void _cambiarEstatus() {
    setState(() {
      // Ciclo de estatus
      switch (_estatusPago) {
        case EstatusPago.ingresdo:
          _estatusPago = EstatusPago.pendiente;
          break;
        case EstatusPago.pendiente:
          _estatusPago = EstatusPago.aprobado;
          break;
        case EstatusPago.aprobado:
          _estatusPago = EstatusPago.pagado;
          break;
        case EstatusPago.pagado:
          _estatusPago = EstatusPago.conciliado;
          break;
        case EstatusPago.conciliado:
          _estatusPago = EstatusPago.cancelado;
          break;
        case EstatusPago.cancelado:
        default:
          _estatusPago = EstatusPago.ingresdo;
      }
    });
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.colorScheme.secondaryContainer,
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
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.payment, size: 40),
                        const SizedBox(width: 10),
                        Text(
                          'Pago',
                          style: theme.textTheme.headlineSmall!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Mutation(
                          options: MutationOptions(
                            document: gql(PagoQueries.createPago),
                            onCompleted: (data) {
                              setState(() { _saving = false; });
                              if (widget.onSave != null) widget.onSave!();
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
                                  const SizedBox(width: 100, child: Center(child: CircularProgressIndicator()))
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
                          ),
                          builder: (runMutation, result) {
                            return TextButton.icon(
                              onPressed:()=>widget.onDelete?.call(),
                              icon: const Icon(Icons.delete),
                              label: Text(
                                'Eliminar',
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
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
                    _sectionTitle(context, 'Datos Generales'),
                    Row(children: [
                      Expanded(child: _textField(_montoController, 'Monto', keyboardType: TextInputType.number)),
                      Expanded(child: _textField(_referenciaBancariaController, 'Referencia Bancaria')),
                      Expanded(child: _textField(_cuentaOrigenController, 'Cuenta Origen')),
                      Expanded(child: _textField(_cuentaDestinoController, 'Cuenta Destino')),
                    ]),
                    Row(children: [
                      Expanded(child: _textField(_documentoUrlController, 'Documento URL')),
                      Expanded(child: _textField(_comprobantePagoUrlController, 'Comprobante Pago URL')),
                      Expanded(child: _textField(_conceptoController, 'Concepto')),
                      Expanded(child: _textField(_notasController, 'Notas')),
                    ]),
                    Row(children: [
                      Expanded(
                        child: Query(
                          options: QueryOptions(document: gql(TipoBeneficiarioQueries.getAllTipoBeneficiarios)),
                          builder: (result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                            }
                            if (result.hasException) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error TB'),
                              );
                            }
                            var tipos = result.data?['tipoBeneficiarios'] ?? [];
                            return DropdownButtonFormField<int>(
                              value: _tipoBeneficiario,
                              decoration: const InputDecoration(
                                labelText: 'Tipo de Beneficiario',
                                border: OutlineInputBorder(),
                              ),
                              items: [for (var t in tipos) DropdownMenuItem(value: t['id_tipo_beneficiario'], child: Text(t['descripcion']))],
                              onChanged: (val) {
                                setState(() { _tipoBeneficiario = val; _beneficiarioId = null; });
                              },
                            );
                          }
                        ),
                      ),
                      Expanded(
                        child: _tipoBeneficiario == 1 // proveedor
                          ? Query(
                              options: QueryOptions(document: gql(ProveedorQueries.proveedores)),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {
                                  return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                                }
                                if (result.hasException) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text('Error Proveedor'),
                                  );
                                }
                                var proveedores = result.data?['proveedores'] ?? [];
                                return DropdownButtonFormField<int>(
                                  value: _beneficiarioId,
                                  decoration: const InputDecoration(
                                    labelText: 'Proveedor',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [for (var p in proveedores) DropdownMenuItem(value: p['id_proveedor'], child: Text(p['razon_social'] ?? ''))],
                                  onChanged: (val) { setState(() { _beneficiarioId = val; }); },
                                );
                              }
                            )
                          : Query(
                              options: QueryOptions(document: gql(EmpleadoQueries.getAllEmpleados)),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {
                                  return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                                }
                                if (result.hasException) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text('Error Empleado'),
                                  );
                                }
                                var empleados = result.data?['empleados'] ?? [];
                                return DropdownButtonFormField<int>(
                                  value: _beneficiarioId,
                                  decoration: const InputDecoration(
                                    labelText: 'Empleado',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [for (var e in empleados) DropdownMenuItem(value: e['idempleado'], child: Text('${e['nombre']} ${e['apellido_paterno']}'))],
                                  onChanged: (val) { setState(() { _beneficiarioId = val; }); },
                                );
                              }
                            ),
                      ),
                    ]),
                    Row(children: [
                      Expanded(
                        child: Query(
                          options: QueryOptions(document: gql(MetodoPagoQueries.getAllMetodoPagos)),
                          builder: (result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                            }
                            if (result.hasException) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error MP'),
                              );
                            }
                            var metodos = result.data?['metodoPagos'] ?? [];
                            return DropdownButtonFormField<int>(
                              value: _metodoPago,
                              decoration: const InputDecoration(
                                labelText: 'Método de Pago',
                                border: OutlineInputBorder(),
                              ),
                              items: [for (var m in metodos) DropdownMenuItem(value: m['id_metodo_pago'], child: Text(m['descripcion']))],
                              onChanged: (val) { setState(() { _metodoPago = val; }); },
                            );
                          }
                        ),
                      ),
                      Expanded(
                        child: Query(
                          options: QueryOptions(document: gql(EstatusPagoQueries.getAllEstatusPagos)),
                          builder: (result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                            }
                            if (result.hasException) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error Estatus'),
                              );
                            }
                            // Botón de cambio de estatus
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: EstatusPago.getColor(_estatusPago ?? EstatusPago.ingresdo),
                              ),
                              onPressed: _cambiarEstatus,
                              child: Text('Cambiar estatus'),
                            );
                          }
                        ),
                      ),
                      Expanded(
                        child: Query(
                          options: QueryOptions(document: gql(FormaPagoSatQueries.getAllFormaPagoSats)),
                          builder: (result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                            }
                            if (result.hasException) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error FPSAT'),
                              );
                            }
                            var formas = result.data?['formaPagoSats'] ?? [];
                            return DropdownButtonFormField<int>(
                              value: _formaPagoSat,
                              decoration: const InputDecoration(
                                labelText: 'Forma Pago SAT',
                                border: OutlineInputBorder(),
                              ),
                              items: [for (var f in formas) DropdownMenuItem(value: f['id_forma_pago_sat'], child: Text(f['descripcion']))],
                              onChanged: (val) { setState(() { _formaPagoSat = val; }); },
                            );
                          }
                        ),
                      ),
                    ]),
                    Row(children: [
                      Expanded(
                        child: Query(
                          options: QueryOptions(document: gql(ProyectoQueries.getAllProyectos)),
                          builder: (result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                            }
                            if (result.hasException) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error Proyecto'),
                              );
                            }
                            var proyectos = result.data?['getAllProyectos'] ?? [];
                            return DropdownButtonFormField<int>(
                              value: _proyecto,
                              decoration: const InputDecoration(
                                labelText: 'Proyecto',
                                border: OutlineInputBorder(),
                              ),
                              items: [for (var p in proyectos) DropdownMenuItem(value: p['idproyecto'], child: Text(p['nombre']))],
                              onChanged: (val) { setState(() { _proyecto = val; }); },
                            );
                          }
                        ),
                      ),
                      Expanded(
                        child: Query(
                          options: QueryOptions(document: gql(EmpleadoQueries.getAllEmpleados)),
                          builder: (result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                            }
                            if (result.hasException) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error AprobadoPor'),
                              );
                            }
                            var empleados = result.data?['empleados'] ?? [];
                            return DropdownButtonFormField<int>(
                              value: _aprobadoPor,
                              decoration: const InputDecoration(
                                labelText: 'Aprobado Por',
                                border: OutlineInputBorder(),
                              ),
                              items: [for (var e in empleados) DropdownMenuItem(value: e['idempleado'], child: Text('${e['nombre']} ${e['apellido_paterno']}'))],
                              onChanged: (val) { setState(() { _aprobadoPor = val; }); },
                            );
                          }
                        ),
                      ),
                    ]),
                    Row(children: [
                      Expanded(
                        child: ListTile(
                          title: Text('Fecha Programada'),
                          subtitle: Text(_fechaProgramada != null ? _fechaProgramada!.toLocal().toString().split(' ')[0] : ''),
                          trailing: Icon(Icons.calendar_today),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _fechaProgramada ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) setState(() { _fechaProgramada = picked; });
                          },
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('Fecha Pago'),
                          subtitle: Text(_fechaPago != null ? _fechaPago!.toLocal().toString().split(' ')[0] : ''),
                          trailing: Icon(Icons.calendar_today),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _fechaPago ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) setState(() { _fechaPago = picked; });
                          },
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}