import 'package:constructoria/cors/snak.dart';
import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/proveedor.dart';
import 'package:constructoria/domain/entities/security_auth.dart';
import 'package:constructoria/domain/entities/tipo_persona.dart';
import 'package:constructoria/domain/entities/tipo_cuenta.dart';
import 'package:constructoria/domain/entities/moneda.dart';
import 'package:constructoria/domain/repositories/proveedor_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class ProveedorPage extends StatefulWidget {
  const ProveedorPage({
    super.key,
    required this.client,
    required this.proveedor,
    required this.onSave,
    required this.onBack,
    required this.onDelete,
  });

  final GraphQLClient client;
  final Proveedor proveedor;
  final void Function() onSave;
  final void Function() onBack;
  final void Function() onDelete;

  @override
  State<ProveedorPage> createState() => _ProveedorPageState();
}

class _ProveedorPageState extends State<ProveedorPage> {
  late TextEditingController _rfcController;
  late TextEditingController _razonSocialController;
  late TextEditingController _nombreComercialController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoElectronicoController;
  late TextEditingController _paginaWebController;
  late TextEditingController _contactoNombreController;
  late TextEditingController _contactoPuestoController;
  late TextEditingController _calleController;
  late TextEditingController _numeroExteriorController;
  late TextEditingController _numeroInteriorController;
  late TextEditingController _coloniaController;
  late TextEditingController _municipioController;
  late TextEditingController _estadoController;
  late TextEditingController _paisController;
  late TextEditingController _codigoPostalController;
  late TextEditingController _bancoController;
  late TextEditingController _cuentaBancariaController;
  late TextEditingController _clabeController;
  late TextEditingController _usoCfdiController;
  late TextEditingController _metodoPagoController;
  late TextEditingController _formaPagoController;
  late TextEditingController _diasCreditoController;
  late TextEditingController _limiteCreditoController;
  late TextEditingController _notasController;
  late TextEditingController _responsableLegalNombreController;
  late TextEditingController _responsableLegalPuestoController;
  late TextEditingController _responsableLegalTelefonoController;
  late TextEditingController _responsableLegalCorreoController;
  late TextEditingController _responsableLegalIdentificacionController;
  late TextEditingController _responsableLegalRfcController;
  bool _activo = true;
  bool _retencionIva = false;
  bool _retencionIsr = false;
  bool _saving = false;

  int? _tipoPersona;
  int? _tipoCuenta;
  int? _moneda;

  @override
  void initState() {
    super.initState();
    final p = widget.proveedor;
    _rfcController = TextEditingController(text: p.rfc);
    _razonSocialController = TextEditingController(text: p.razonSocial);
    _nombreComercialController = TextEditingController(text: p.nombreComercial);
    _telefonoController = TextEditingController(text: p.telefono);
    _correoElectronicoController = TextEditingController(text: p.correoElectronico);
    _paginaWebController = TextEditingController(text: p.paginaWeb);
    _contactoNombreController = TextEditingController(text: p.contactoNombre);
    _contactoPuestoController = TextEditingController(text: p.contactoPuesto);
    _calleController = TextEditingController(text: p.calle);
    _numeroExteriorController = TextEditingController(text: p.numeroExterior);
    _numeroInteriorController = TextEditingController(text: p.numeroInterior);
    _coloniaController = TextEditingController(text: p.colonia);
    _municipioController = TextEditingController(text: p.municipio);
    _estadoController = TextEditingController(text: p.estado);
    _paisController = TextEditingController(text: p.pais);
    _codigoPostalController = TextEditingController(text: p.codigoPostal);
    _bancoController = TextEditingController(text: p.banco);
    _cuentaBancariaController = TextEditingController(text: p.cuentaBancaria);
    _clabeController = TextEditingController(text: p.clabe);
    _usoCfdiController = TextEditingController(text: p.usoCfdi);
    _metodoPagoController = TextEditingController(text: p.metodoPago);
    _formaPagoController = TextEditingController(text: p.formaPago);
    _diasCreditoController = TextEditingController(text: p.diasCredito.toString());
    _limiteCreditoController = TextEditingController(text: p.limiteCredito.toString());
    _notasController = TextEditingController(text: p.notas);
    _responsableLegalNombreController = TextEditingController(text: p.responsableLegalNombre);
    _responsableLegalPuestoController = TextEditingController(text: p.responsableLegalPuesto);
    _responsableLegalTelefonoController = TextEditingController(text: p.responsableLegalTelefono);
    _responsableLegalCorreoController = TextEditingController(text: p.responsableLegalCorreo);
    _responsableLegalIdentificacionController = TextEditingController(text: p.responsableLegalIdentificacion);
    _responsableLegalRfcController = TextEditingController(text: p.responsableLegalRfc);
    _activo = p.activo;
    _retencionIva = p.retencionIva;
    _retencionIsr = p.retencionIsr;
    // Asegura que los dropdowns siempre tengan un valor válido
    _tipoPersona = p.tipoPersona?.idTipoPersona;
    _tipoCuenta = p.tipoCuenta?.idTipoCuenta;
    _moneda = p.moneda?.idMoneda;
  }

  @override
  void dispose() {
    _rfcController.dispose();
    _razonSocialController.dispose();
    _nombreComercialController.dispose();
    _telefonoController.dispose();
    _correoElectronicoController.dispose();
    _paginaWebController.dispose();
    _contactoNombreController.dispose();
    _contactoPuestoController.dispose();
    _calleController.dispose();
    _numeroExteriorController.dispose();
    _numeroInteriorController.dispose();
    _coloniaController.dispose();
    _municipioController.dispose();
    _estadoController.dispose();
    _paisController.dispose();
    _codigoPostalController.dispose();
    _bancoController.dispose();
    _cuentaBancariaController.dispose();
    _clabeController.dispose();
    _usoCfdiController.dispose();
    _metodoPagoController.dispose();
    _formaPagoController.dispose();
    _diasCreditoController.dispose();
    _limiteCreditoController.dispose();
    _notasController.dispose();
    _responsableLegalNombreController.dispose();
    _responsableLegalPuestoController.dispose();
    _responsableLegalTelefonoController.dispose();
    _responsableLegalCorreoController.dispose();
    _responsableLegalIdentificacionController.dispose();
    _responsableLegalRfcController.dispose();
    super.dispose();
  }

  void _guardarProveedor(runMutation) async {
    setState(() { _saving = true; });
    final auth = await SecurityAuth.get();
    var proveedor = Proveedor(
      idProveedor: widget.proveedor.idProveedor,
      rfc: _rfcController.text,
      razonSocial: _razonSocialController.text,
      nombreComercial: _nombreComercialController.text,
      idTipoPersona: _tipoPersona??0,
      telefono: _telefonoController.text,
      correoElectronico: _correoElectronicoController.text,
      paginaWeb: _paginaWebController.text,
      contactoNombre: _contactoNombreController.text,
      contactoPuesto: _contactoPuestoController.text,
      calle: _calleController.text,
      numeroExterior: _numeroExteriorController.text,
      numeroInterior: _numeroInteriorController.text,
      colonia: _coloniaController.text,
      municipio: _municipioController.text,
      estado: _estadoController.text,
      pais: _paisController.text,
      codigoPostal: _codigoPostalController.text,
      banco: _bancoController.text,
      cuentaBancaria: _cuentaBancariaController.text,
      clabe: _clabeController.text,
      idTipoCuenta: _tipoCuenta??0,
      idMoneda: _moneda??0,
      usoCfdi: _usoCfdiController.text,
      metodoPago: _metodoPagoController.text,
      formaPago: _formaPagoController.text,
      diasCredito: int.tryParse(_diasCreditoController.text) ?? 0,
      limiteCredito: double.tryParse(_limiteCreditoController.text) ?? 0.0,
      retencionIva: _retencionIva,
      retencionIsr: _retencionIsr,
      activo: _activo,
      notas: _notasController.text,
      responsableLegalNombre: _responsableLegalNombreController.text,
      responsableLegalPuesto: _responsableLegalPuestoController.text,
      responsableLegalTelefono: _responsableLegalTelefonoController.text,
      responsableLegalCorreo: _responsableLegalCorreoController.text,
      responsableLegalIdentificacion: _responsableLegalIdentificacionController.text,
      responsableLegalRfc: _responsableLegalRfcController.text,
      creadoPor:  widget.proveedor.idProveedor ?? auth!.userEmpleado.idUserEmpleado!,
      actualizadoPor: auth!.userEmpleado.idUserEmpleado!,
    );
    runMutation(proveedor.data());
  }

  void _eliminarProveedor(runMutation) async {
    if(widget.proveedor.idProveedor == null) return;
    widget.onDelete();
    runMutation({'id_proveedor': widget.proveedor.idProveedor});
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
              // ...existing code for AppBar...
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
                        const Icon(Icons.business, size: 40),
                        const SizedBox(width: 10),
                        Text(
                          'Proveedor',
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
                            document: gql(widget.proveedor.query),
                            onCompleted: (data) {
                              setState(() { _saving = false; });
                              widget.onSave();
                            },
                            onError: (error) {
                              setState(() { _saving = false; });
                              Snak.show(
                                context: context,
                                message: 'Error al guardar el proveedor',
                                backcolor: theme.colorScheme.error,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.colorScheme.surfaceContainerLowest,
                                ),
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
                                    onPressed: ()=>_guardarProveedor(runMutation),
                                    icon: const Icon(Icons.save),
                                    label: const Text('Guardar'),
                                  ),
                              ],
                            );
                          }
                        ),
                        const SizedBox(width: 10),
                        if(widget.proveedor.idProveedor != null)
                        Mutation(
                          options: MutationOptions(
                            document: gql(ProveedorQueries.removeProveedor),
                            onCompleted: (data) {
                              widget.onDelete();
                            },
                            onError: (error) {
                              Snak.show(
                                context: context,
                                message: 'Error al eliminar el proveedor',
                                backcolor: theme.colorScheme.error,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.colorScheme.surfaceContainerLowest,
                                ),
                              );
                            },
                          ),
                          builder: (runMutation, result) {
                            return TextButton.icon(
                              onPressed:()=>_eliminarProveedor(runMutation),
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
                      Expanded(child: _textField(_rfcController, 'RFC')),
                      Expanded(child: _textField(_razonSocialController, 'Razón Social')),
                      Expanded(child: _textField(_nombreComercialController, 'Nombre Comercial')),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Expanded(
                        child: Query(
                          options: QueryOptions(
                            document: gql(ProveedorQueries.tipoPersonas),
                          ),
                          builder:(result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return SizedBox(width: 100, child: WaitTool());
                            }
                            if (result.hasException) {  
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error TP}'),
                              );
                            }

                            var tiposPersonaData = TipoPersona.fromJsonList(result.data?['tipoPersonas'] as List);
                            if((_tipoPersona ?? 0) == 0 && tiposPersonaData.isNotEmpty) {
                              _tipoPersona = tiposPersonaData.first.idTipoPersona;
                            }

                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: DropdownButtonFormField<int>(
                                initialValue: _tipoPersona,
                                decoration: const InputDecoration(
                                  labelText: 'Tipo de Persona',
                                  border: OutlineInputBorder(),
                                ),
                                items: tiposPersonaData.map((tp) => DropdownMenuItem(
                                  value: tp.idTipoPersona,
                                  child: Text(tp.descripcion),
                                )).toList(),
                                onChanged: (val) {
                                  _tipoPersona = val;
                                },
                              ),
                            );
                          }
                        ),
                      ),
                      Expanded(child: _textField(_telefonoController, 'Teléfono')),
                      Expanded(child: _textField(_correoElectronicoController, 'Correo Electrónico', keyboardType: TextInputType.emailAddress)),
                    ]),
                    Row(children: [
                      Expanded(child: _textField(_paginaWebController, 'Página Web')),
                      Expanded(child: _textField(_contactoNombreController, 'Nombre Contacto')),
                      Expanded(child: _textField(_contactoPuestoController, 'Puesto Contacto')),
                    ]),
                    Row(children: [
                      Expanded(child: _textField(_calleController, 'Calle')),
                      Expanded(child: _textField(_numeroExteriorController, 'Número Exterior')),
                      Expanded(child: _textField(_numeroInteriorController, 'Número Interior')),
                    ]),
                    Row(children: [
                      Expanded(child: _textField(_coloniaController, 'Colonia')),
                      Expanded(child: _textField(_municipioController, 'Municipio')),
                      Expanded(child: _textField(_estadoController, 'Estado')),
                    ]),
                    Row(children: [
                      Expanded(child: _textField(_paisController, 'País')),
                      Expanded(child: _textField(_codigoPostalController, 'Código Postal')),
                      const Spacer(),
                    ]),
                    const SizedBox(height: 10),
                    _sectionTitle(context, 'Datos Bancarios'),
                    Row(children: [
                      Expanded(child: _textField(_bancoController, 'Banco')),
                      Expanded(child: _textField(_cuentaBancariaController, 'Cuenta Bancaria')),
                      Expanded(child: _textField(_clabeController, 'CLABE')),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Expanded(
                        child: Query(
                          options: QueryOptions(
                            document: gql(ProveedorQueries.tipoCuentas),
                          ),
                          builder: (context, {fetchMore, refetch}) {
                            if (context.isLoading) {
                              return SizedBox(width: 100, child: WaitTool());
                            }
                            if (context.hasException) {  
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error TC}'),
                              );
                            }
                            var tiposCuentaData = TipoCuenta.fromJsonList(context.data?['tipoCuentas'] as List);
                            if((_tipoCuenta ?? 0) == 0 && tiposCuentaData.isNotEmpty) {
                              _tipoCuenta = tiposCuentaData.first.idTipoCuenta;
                            }

                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: DropdownButtonFormField<int>(
                                initialValue: _tipoCuenta,
                                decoration: const InputDecoration(
                                  labelText: 'Tipo de Cuenta',
                                  border: OutlineInputBorder(),
                                ),
                                items: tiposCuentaData.map((tc) => DropdownMenuItem(
                                  value: tc.idTipoCuenta,
                                  child: Text(tc.descripcion),
                                )).toList(),
                                onChanged: (val) {
                                  _tipoCuenta = val;
                                },
                              ),
                            );
                          }
                        ),
                      ),
                      Expanded(
                        child: Query(
                          options: QueryOptions(
                            document: gql(ProveedorQueries.monedas),
                          ),
                          builder:(context, {fetchMore, refetch}) {
                            if (context.isLoading) {
                              return SizedBox(width: 100, child: WaitTool());
                            }
                            if (context.hasException) { 
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Error M}'),
                              );
                            }

                            var monedasData = Moneda.fromJsonList(context.data?['monedas'] as List);
                            if((_moneda ?? 0) == 0 && monedasData.isNotEmpty) {
                              _moneda = monedasData.first.idMoneda;
                            }

                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: DropdownButtonFormField<int>(
                                initialValue: _moneda,
                                decoration: const InputDecoration(
                                  labelText: 'Moneda',
                                  border: OutlineInputBorder(),
                                ),
                                items: monedasData.map((m) => DropdownMenuItem(
                                  value: m.idMoneda,
                                  child: Text(m.descripcion),
                                )).toList(),
                                onChanged: (val) {
                                  _moneda = val;
                                },
                              ),
                            );
                          }
                        ),
                      ),
                    ]),
                    Row(children: [
                      Expanded(child: _textField(_usoCfdiController, 'Uso CFDI')),
                      Expanded(child: _textField(_metodoPagoController, 'Método de Pago')),
                      Expanded(child: _textField(_formaPagoController, 'Forma de Pago')),
                    ]),
                    Row(children: [
                      Expanded(child: _textField(_diasCreditoController, 'Días de Crédito', keyboardType: TextInputType.number)),
                      Expanded(child: _textField(_limiteCreditoController, 'Límite de Crédito', keyboardType: TextInputType.number)),
                      const Spacer(),
                    ]),
                    Row(children: [
                      Expanded(
                        child: SwitchListTile(
                          title: const Text('Retención IVA'),
                          value: _retencionIva,
                          onChanged: (val) {
                            setState(() { _retencionIva = val; });
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile(
                          title: const Text('Retención ISR'),
                          value: _retencionIsr,
                          onChanged: (val) {
                            setState(() { _retencionIsr = val; });
                          },
                        ),
                      ),
                      Expanded(
                        child: SwitchListTile(
                          title: const Text('Activo'),
                          value: _activo,
                          onChanged: (val) {
                            setState(() { _activo = val; });
                          },
                        ),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    _sectionTitle(context, 'Notas'),
                    _textField(_notasController, 'Notas'),
                    const SizedBox(height: 10),
                    _sectionTitle(context, 'Responsable Legal'),
                    Row(children: [
                      Expanded(child: _textField(_responsableLegalNombreController, 'Nombre')),
                      Expanded(child: _textField(_responsableLegalPuestoController, 'Puesto')),
                      Expanded(child: _textField(_responsableLegalTelefonoController, 'Teléfono')),
                    ]),
                    Row(children: [
                      Expanded(child: _textField(_responsableLegalCorreoController, 'Correo')),
                      Expanded(child: _textField(_responsableLegalIdentificacionController, 'Identificación')),
                      Expanded(child: _textField(_responsableLegalRfcController, 'RFC')),
                    ]),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
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
}
