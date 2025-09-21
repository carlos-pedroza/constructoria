import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/cors/snak.dart';
import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:constructoria/domain/repositories/proyecto_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProyectoPage extends StatefulWidget {
  const ProyectoPage({
    super.key,
    required this.client,
    required this.proyecto,
    required this.onSave,
    required this.onBack,
    required this.onDelete,
  });

  final GraphQLClient client;
  final Proyecto proyecto;
  final void Function(Proyecto proyecto) onSave;
  final void Function() onBack;
  final void Function(Proyecto proyecto) onDelete;

  @override
  State<ProyectoPage> createState() => _ProyectoPageState();
}

class _ProyectoPageState extends State<ProyectoPage> {
  final List<Map<String, dynamic>> _estados = [
    {'id': 0, 'nombre': 'Seleccionar Estado'},
    {'id': 1, 'nombre': 'Planeación'},
    {'id': 2, 'nombre': 'En Progreso'},
    {'id': 3, 'nombre': 'Completado'},
    {'id': 4, 'nombre': 'En Espera'},
    {'id': 5, 'nombre': 'Cancelado'},
  ];

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
  bool _saving = false;
  String? _query;
  var _selectedResponsableId = 0;
  var _selectedEstadoId = 0;

  void initData() {
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
    setState(() {
      _selectedResponsableId = proyecto.responsableId;
      _selectedEstadoId = proyecto.idestado;
      _query = proyecto.query;
    });
  }
 
  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void didUpdateWidget(covariant ProyectoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    initData();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Container(
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
                        Mutation(
                          options: MutationOptions(
                            document: gql(_query!),
                            onCompleted: (dynamic resultData) {
                              if(resultData != null && (resultData['createProyecto'] != null || resultData['updateProyecto'] != null)) {
                                widget.onSave(widget.proyecto);
                                Snak.show(
                                  context: context, 
                                  message: 'Proyecto guardado exitosamente',
                                  backcolor: Colors.green[700],
                                  style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.surfaceContainerLowest),
                                );
                                setState(() {
                                    _saving = false;
                                });
                              }
                            },
                            onError: (OperationException? error) {
                              print('Error al guardar el proyecto: $error');
                              setState(() {
                                _saving = false;
                              });
                              Snak.show(
                                context: context, 
                                message: 'Error al guardar el proyecto',
                                backcolor: theme.colorScheme.error,
                                style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.surfaceContainerLowest),
                              );
                            },
                          ),
                          builder:(runMutation, result) {
                            return Column(
                              children: [
                                if (_saving)
                                  SizedBox(width: 100, child: WaitTool())
                                else
                                ElevatedButton.icon(
                                  onPressed: ()=>_onGuardar(runMutation),
                                  icon: Icon(Icons.save),
                                  label: Text('Guardar'),
                                ),
                              ],
                            );
                          }
                        ),
                        SizedBox(width: 30),
                        if(widget.proyecto.idproyecto != null)
                          Mutation(
                            options: MutationOptions(
                              document: gql(ProyectoQueries.deleteProyecto),
                              onCompleted: (dynamic resultData) {
                                if(resultData != null && resultData['deleteProyecto'] == true) {
                                  Snak.show(
                                    context: context, 
                                    message: 'Proyecto eliminado exitosamente',
                                    backcolor: Colors.green[700],
                                    style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.surfaceContainerLowest),
                                  );
                                  widget.onDelete(widget.proyecto);
                                }
                              },
                              onError: (OperationException? error) {
                                print('Error al eliminar el proyecto: $error');
                                Snak.show(
                                  context: context, 
                                  message: 'Error al eliminar el proyecto',
                                  backcolor: theme.colorScheme.error,
                                  style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.surfaceContainerLowest),
                                );
                              },
                            ),
                            builder:(runMutation, result) {
                              return TextButton.icon(
                                onPressed: ()=>_onEliminar(runMutation),
                                icon: Icon(Icons.delete),
                                label: Text('Eliminar'),
                                style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: DropdownButtonFormField<int>(
                              initialValue: _selectedEstadoId,
                              decoration: InputDecoration(
                                labelText: 'Estado',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              items: _estados.map((estado) => DropdownMenuItem<int>(
                                value: estado['id'],
                                child: Text(estado['nombre']),
                              )).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedEstadoId = val??0;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Query(
                            options: QueryOptions(
                              document: gql(EmpleadoQueries.getAllEmpleados),
                            ),
                            builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                              if (result.isLoading) {
                                return Center(child: SizedBox(width: 100, child: WaitTool()));
                              }
      
                              if (result.hasException) {
                                return Center(child: Text('Error cargando información'));
                              }
      
                              final empleados = Empleado.fromJsonList(result.data?['empleados'] ?? []);
                              empleados.insert(0, Empleado.empty(idempleado: 0, nombre: 'Seleccionar Empleado'));

                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: DropdownButtonFormField<int>(
                                  initialValue: _selectedResponsableId,
                                  decoration: InputDecoration(
                                    labelText: 'Responsable',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  items: empleados.map((resp) => DropdownMenuItem<int>(
                                    value: resp.idempleado,
                                    child: Text(resp.nombreCompleto),
                                  )).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedResponsableId = val??0;
                                    });
                                  },
                                ),
                              );
                            }
                          ),
                        ),
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

  void _onGuardar(runMutation) {
    setState(() {
      _saving = true;
    });
    if(_selectedResponsableId == 0 || _selectedEstadoId == 0) {
      Snak.show(
        context: context, 
        message: 'Por favor verificar datos seleccionandos',
        backcolor: Theme.of(context).colorScheme.error,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.surfaceContainerLowest),
      );
      setState(() {
        _saving = false;
      });
      return;
    } 
    final proyecto = Proyecto(
      idproyecto: widget.proyecto.idproyecto,
      claveProyecto: _claveController.text,
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      fechaInicio: DateTime.tryParse(_fechaInicioController.text) ?? DateTime.now(),
      fechaFin: DateTime.tryParse(_fechaFinController.text) ?? DateTime.now(),
      idestado: _selectedEstadoId,
      presupuesto: double.tryParse(_presupuestoController.text) ?? 0.0,
      ubicacion: _ubicacionController.text,
      clienteNombre: _clienteNombreController.text,
      clienteContacto: _clienteContactoController.text,
      clienteEmail: _clienteEmailController.text,
      clienteTelefono: _clienteTelefonoController.text,
      clienteDireccion: _clienteDireccionController.text,
      responsableId: _selectedResponsableId,
      createdAt: widget.proyecto.createdAt,
      updatedAt: DateTime.now(),
    );
    runMutation(proyecto.data());
  }

  void _onEliminar(runMutation) {
    DialogAsk.confirm(
      context: context,
      title: 'Confirmar Eliminación',
      content: Text('¿Estás seguro de que deseas eliminar este proyecto?'),
      onYes: ( ) {
        runMutation({
          'idproyecto': widget.proyecto.idproyecto,
        });
      },
      onNo: () {},
    );
  }

}
