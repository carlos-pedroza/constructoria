import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:flutter/material.dart';

class ProyectoPage extends StatefulWidget {
  const ProyectoPage({
    super.key,
    required this.proyecto,
    required this.onSave,
    required this.onBack,
    required this.onDelete,
  });

  final Proyecto proyecto;
  final void Function(Proyecto proyecto) onSave;
  final void Function() onBack;
  final void Function(Proyecto proyecto) onDelete;

  @override
  State<ProyectoPage> createState() => _ProyectoPageState();
}

class _ProyectoPageState extends State<ProyectoPage> {
  // Controladores para los campos
  final _claveController = TextEditingController();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fechaInicioController = TextEditingController();
  final _fechaFinController = TextEditingController();
  final _presupuestoController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _clienteNombreController = TextEditingController();
  final _clienteContactoController = TextEditingController();
  final _clienteEmailController = TextEditingController();
  final _clienteTelefonoController = TextEditingController();
  final _clienteDireccionController = TextEditingController();
  final _responsableIdController = TextEditingController();
  final _idestadoController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final proyecto = widget.proyecto;
    _claveController.text = proyecto.claveProyecto;
    _nombreController.text = proyecto.nombre;
    _descripcionController.text = proyecto.descripcion;
    _fechaInicioController.text = proyecto.fechaInicio.toIso8601String().substring(0, 10);
    _fechaFinController.text = proyecto.fechaFin.toIso8601String().substring(0, 10);
    _presupuestoController.text = proyecto.presupuesto.toString();
    _ubicacionController.text = proyecto.ubicacion;
    _clienteNombreController.text = proyecto.clienteNombre;
    _clienteContactoController.text = proyecto.clienteContacto;
    _clienteEmailController.text = proyecto.clienteEmail;
    _clienteTelefonoController.text = proyecto.clienteTelefono;
    _clienteDireccionController.text = proyecto.clienteDireccion;
    _responsableIdController.text = proyecto.responsableId.toString();
    _idestadoController.text = proyecto.idestado.toString();
  }

  @override
  void dispose() {
    _claveController.dispose();
    _nombreController.dispose();
    _descripcionController.dispose();
    _fechaInicioController.dispose();
    _fechaFinController.dispose();
    _presupuestoController.dispose();
    _ubicacionController.dispose();
    _clienteNombreController.dispose();
    _clienteContactoController.dispose();
    _clienteEmailController.dispose();
    _clienteTelefonoController.dispose();
    _clienteDireccionController.dispose();
    _responsableIdController.dispose();
    _idestadoController.dispose();
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: widget.onBack,
                        icon: Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.work, size: 40),
                      SizedBox(width: 10),
                      Text(
                        'Proyecto',
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
                        SizedBox(width: 100, child: CircularProgressIndicator())
                      else
                        ElevatedButton.icon(
                          onPressed: _onGuardar,
                          icon: Icon(Icons.save),
                          label: Text('Guardar'),
                        ),
                      SizedBox(width: 10),
                      if(widget.proyecto.idproyecto != null)
                        TextButton.icon(
                          onPressed: _onEliminar,
                          icon: Icon(Icons.delete),
                          label: Text('Eliminar'),
                          style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
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
                  _sectionTitle(context, 'Datos Generales'),
                  Row(
                    children: [
                      Expanded(child: _textField(_claveController, 'Clave Proyecto')),
                      Expanded(child: _textField(_nombreController, 'Nombre')),
                      Expanded(child: _textField(_descripcionController, 'Descripción')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextFormField(
                            controller: _fechaInicioController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Fecha de Inicio',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _fechaInicioController.text.isNotEmpty
                                    ? DateTime.tryParse(_fechaInicioController.text) ?? DateTime.now()
                                    : DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _fechaInicioController.text = pickedDate.toIso8601String().substring(0, 10);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextFormField(
                            controller: _fechaFinController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Fecha de Fin',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _fechaFinController.text.isNotEmpty
                                    ? DateTime.tryParse(_fechaFinController.text) ?? DateTime.now()
                                    : DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _fechaFinController.text = pickedDate.toIso8601String().substring(0, 10);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(child: _textField(_presupuestoController, 'Presupuesto', keyboardType: TextInputType.number)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _textField(_ubicacionController, 'Ubicación')),
                      Expanded(child: _textField(_idestadoController, 'ID Estado', keyboardType: TextInputType.number)),
                      Expanded(child: _textField(_responsableIdController, 'ID Responsable', keyboardType: TextInputType.number)),
                    ],
                  ),
                  _sectionTitle(context, 'Datos del Cliente'),
                  Row(
                    children: [
                      Expanded(child: _textField(_clienteNombreController, 'Nombre Cliente')),
                      Expanded(child: _textField(_clienteContactoController, 'Contacto Cliente')),
                      Expanded(child: _textField(_clienteEmailController, 'Email Cliente')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _textField(_clienteTelefonoController, 'Teléfono Cliente')),
                      Expanded(child: _textField(_clienteDireccionController, 'Dirección Cliente')),
                      const Spacer(),
                    ],
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

  void _onGuardar() {
    setState(() {
      _saving = true;
    });
    final proyecto = Proyecto(
      idproyecto: widget.proyecto.idproyecto,
      claveProyecto: _claveController.text,
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      fechaInicio: DateTime.tryParse(_fechaInicioController.text) ?? DateTime.now(),
      fechaFin: DateTime.tryParse(_fechaFinController.text) ?? DateTime.now(),
      idestado: int.tryParse(_idestadoController.text) ?? 0,
      presupuesto: double.tryParse(_presupuestoController.text) ?? 0.0,
      ubicacion: _ubicacionController.text,
      clienteNombre: _clienteNombreController.text,
      clienteContacto: _clienteContactoController.text,
      clienteEmail: _clienteEmailController.text,
      clienteTelefono: _clienteTelefonoController.text,
      clienteDireccion: _clienteDireccionController.text,
      responsableId: int.tryParse(_responsableIdController.text) ?? 0,
      createdAt: widget.proyecto.createdAt,
      updatedAt: DateTime.now(),
    );
    widget.onSave(proyecto);
    setState(() {
      _saving = false;
    });
  }

  void _onEliminar() {
    widget.onDelete(widget.proyecto);
  }
}
