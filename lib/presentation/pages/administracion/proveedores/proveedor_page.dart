import 'package:constructoria/domain/entities/proveedor.dart';
import 'package:constructoria/domain/entities/tipo_persona.dart';
import 'package:constructoria/domain/entities/tipo_cuenta.dart';
import 'package:constructoria/domain/entities/moneda.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class ProveedorPage extends StatefulWidget {
  const ProveedorPage({
    super.key,
    required this.client,
    required this.proveedor,
    required this.refetch,
    required this.onSave,
    required this.onBack,
    required this.onDelete,
    this.tiposPersona = const [],
    this.tiposCuenta = const [],
    this.monedas = const [],
  });

  final GraphQLClient client;
  final Proveedor proveedor;
  final dynamic refetch;
  final void Function(dynamic refetch) onSave;
  final void Function() onBack;
  final void Function(dynamic refetch) onDelete;
  final List<TipoPersona> tiposPersona;
  final List<TipoCuenta> tiposCuenta;
  final List<Moneda> monedas;

  @override
  State<ProveedorPage> createState() => _ProveedorPageState();
}




class _ProveedorPageState extends State<ProveedorPage> {
  late TextEditingController _rfcController;
  late TextEditingController _razonSocialController;
  late TextEditingController _nombreComercialController;
  late TextEditingController _bancoController;
  late TextEditingController _telefonoController;
  bool _activo = true;
  bool _saving = false;

  TipoPersona? _tipoPersona;
  TipoCuenta? _tipoCuenta;
  Moneda? _moneda;

  @override
  void initState() {
    super.initState();
    final p = widget.proveedor;
    _rfcController = TextEditingController(text: p.rfc);
    _razonSocialController = TextEditingController(text: p.razonSocial);
    _nombreComercialController = TextEditingController(text: p.nombreComercial);
    _bancoController = TextEditingController(text: p.banco);
    _telefonoController = TextEditingController(text: p.telefono);
    _activo = p.activo;
    _tipoPersona = p.tipoPersona ?? (widget.tiposPersona.isNotEmpty ? widget.tiposPersona.first : null);
    _tipoCuenta = p.tipoCuenta ?? (widget.tiposCuenta.isNotEmpty ? widget.tiposCuenta.first : null);
    _moneda = p.moneda ?? (widget.monedas.isNotEmpty ? widget.monedas.first : null);
  }

  @override
  void dispose() {
    _rfcController.dispose();
    _razonSocialController.dispose();
    _nombreComercialController.dispose();
    _bancoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _guardarProveedor() async {
    setState(() { _saving = true; });
    // Aquí deberías construir el input y llamar a la mutación de create/update según corresponda
    widget.onSave(widget.refetch);
    setState(() { _saving = false; });
  }

  void _eliminarProveedor() async {
    widget.onDelete(widget.refetch);
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
                        if (_saving)
                          const SizedBox(width: 100, child: Center(child: CircularProgressIndicator()))
                        else
                          ElevatedButton.icon(
                            onPressed: _guardarProveedor,
                            icon: const Icon(Icons.save),
                            label: const Text('Guardar'),
                          ),
                        const SizedBox(width: 10),
                        TextButton.icon(
                          onPressed: _eliminarProveedor,
                          icon: const Icon(Icons.delete),
                          label: Text(
                            'Eliminar',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ),
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
                    Row(
                      children: [
                        Expanded(child: _textField(_rfcController, 'RFC')),
                        Expanded(child: _textField(_razonSocialController, 'Razón Social')),
                        Expanded(child: _textField(_nombreComercialController, 'Nombre Comercial')),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: DropdownButtonFormField<TipoPersona>(
                              value: _tipoPersona,
                              decoration: const InputDecoration(
                                labelText: 'Tipo de Persona',
                                border: OutlineInputBorder(),
                              ),
                              items: widget.tiposPersona.map((tp) => DropdownMenuItem(
                                value: tp,
                                child: Text(tp.descripcion),
                              )).toList(),
                              onChanged: (val) {
                                setState(() { _tipoPersona = val; });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: DropdownButtonFormField<TipoCuenta>(
                              value: _tipoCuenta,
                              decoration: const InputDecoration(
                                labelText: 'Tipo de Cuenta',
                                border: OutlineInputBorder(),
                              ),
                              items: widget.tiposCuenta.map((tc) => DropdownMenuItem(
                                value: tc,
                                child: Text(tc.descripcion),
                              )).toList(),
                              onChanged: (val) {
                                setState(() { _tipoCuenta = val; });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: DropdownButtonFormField<Moneda>(
                              value: _moneda,
                              decoration: const InputDecoration(
                                labelText: 'Moneda',
                                border: OutlineInputBorder(),
                              ),
                              items: widget.monedas.map((m) => DropdownMenuItem(
                                value: m,
                                child: Text(m.descripcion),
                              )).toList(),
                              onChanged: (val) {
                                setState(() { _moneda = val; });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _sectionTitle(context, 'Datos Bancarios'),
                    Row(
                      children: [
                        Expanded(child: _textField(_bancoController, 'Banco')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _sectionTitle(context, 'Contacto'),
                    Row(
                      children: [
                        Expanded(child: _textField(_telefonoController, 'Teléfono')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _sectionTitle(context, 'Estado'),
                    Row(
                      children: [
                        Expanded(
                          child: SwitchListTile(
                            title: const Text('Activo'),
                            value: _activo,
                            onChanged: (val) {
                              setState(() { _activo = val; });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
