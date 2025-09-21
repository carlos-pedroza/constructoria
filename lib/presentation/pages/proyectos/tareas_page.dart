import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:constructoria/domain/repositories/tarea_queries.dart';
import 'package:constructoria/presentation/global_components/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TareasPage extends StatefulWidget {
  const TareasPage({super.key, required this.client, required this.proyecto, required this.onBack});

  final GraphQLClient client;
  final Proyecto proyecto;
  final Function() onBack;


  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  var _tareas = <Tarea>[];
  var _empleados = <Empleado>[];
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTareas();
  }

  Future<void> _fetchTareas() async {
    setState(() {
      _isLoading = true;
    });
    // Fetch tareas
    final tareasOptions = QueryOptions(
      document: gql(TareaQueries.getAllTareas),
      variables: {'idproyecto': widget.proyecto.idproyecto},
      fetchPolicy: FetchPolicy.noCache,
    );
    final tareasResult = await widget.client.query(tareasOptions);
    List<Tarea> tareas = [];
    if (!tareasResult.hasException && tareasResult.data != null) {
      tareas = Tarea.fromJsonList(tareasResult.data?['tareas'] ?? []);
      tareas.addAll(([1,2,3,4,5]).map((e) => Tarea.newItem(idproyecto: widget.proyecto.idproyecto!)).toList());
    }

    // Fetch empleados
    final empleadosOptions = QueryOptions(
      document: gql(EmpleadoQueries.getAllEmpleados),
      fetchPolicy: FetchPolicy.noCache,
    );
    final empleadosResult = await widget.client.query(empleadosOptions);
    List<Empleado> empleados = [];
    if (!empleadosResult.hasException && empleadosResult.data != null) {
      empleados = Empleado.fromJsonList(empleadosResult.data?['empleados'] ?? []);
    }
    empleados.add(Empleado.empty(idempleado: 0, nombre: 'asignar...'));

    setState(() {
      _tareas = tareas;
      _empleados = empleados;
      _isLoading = false;
    });
  }

  @override
  void didUpdateWidget(covariant TareasPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.proyecto.idproyecto != widget.proyecto.idproyecto) {
      _fetchTareas();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: widget.onBack,
                          icon: Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.work_history,
                        color: theme.colorScheme.inverseSurface,
                        size: 40,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            widget.proyecto.nombre,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.inverseSurface,
                            ),
                          ),
                          subtitle: Text(
                            'Tareas',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _onSaveTareas,
                  child: Text('Guardar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _onAddTarea,
                  icon: Icon(Icons.add),
                  label: Text('Tarea'),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceBright,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.colorScheme.outline,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 40),
                        Expanded(
                          flex: 14,
                          child: Text('Código', style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          )),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 86,
                          child: Text('Tarea', style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          )),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 230,
                          child: Text('Fecha inicio', style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          )),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 230,
                          child: Text('Fecha fin', style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          )),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 210,
                          child: Text('Asignado a', style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          )),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  if(_isLoading)
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator(color: theme.colorScheme.surfaceContainerLowest)),
                    )
                  else
                  if(_tareas.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('No hay tareas disponibles.'),
                    )
                  else
                  for (var i = 0; i < _tareas.length; i++)
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        border: Border(
                          bottom: BorderSide(
                            color: theme.colorScheme.outline,
                            width: 1,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                      child: Row(
                        children: [
                          Text('${i + 1}:', style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.grey[400],
                          )),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 14,
                            child: TextFormField(
                              initialValue: _tareas[i].code,
                              style: theme.textTheme.bodySmall,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                fillColor: theme.colorScheme.surfaceContainerLowest,
                                hintText: 'código...',
                                hintStyle: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[400],
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _tareas[i] = Tarea(
                                    idtarea: _tareas[i].idtarea,
                                    idproyecto: _tareas[i].idproyecto,
                                    code: val,
                                    descripcion: _tareas[i].descripcion,
                                    fechaInicio: _tareas[i].fechaInicio,
                                    fechaFin: _tareas[i].fechaFin,
                                    idempleado: _tareas[i].idempleado,
                                    empleado: _tareas[i].empleado,
                                    idestadoTarea: _tareas[i].idestadoTarea,
                                    avance: _tareas[i].avance,
                                    estadoTarea: _tareas[i].estadoTarea,
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 86,
                            child: TextFormField(
                              initialValue: _tareas[i].descripcion,
                              style: theme.textTheme.bodySmall,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                fillColor: theme.colorScheme.surfaceContainerLowest,
                                hintText: 'tarea...',
                                hintStyle: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[400],
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _tareas[i] = Tarea(
                                    idtarea: _tareas[i].idtarea,
                                    idproyecto: _tareas[i].idproyecto,
                                    code: _tareas[i].code,
                                    descripcion: val,
                                    fechaInicio: _tareas[i].fechaInicio,
                                    fechaFin: _tareas[i].fechaFin,
                                    idempleado: _tareas[i].idempleado,
                                    empleado: _tareas[i].empleado,
                                    idestadoTarea: _tareas[i].idestadoTarea,
                                    avance: _tareas[i].avance,
                                    estadoTarea: _tareas[i].estadoTarea,
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 230,
                            child: CustomDatePicker(
                              label: 'Fecha inicio',
                              initialDate: _tareas[i].fechaInicio,
                              onChanged: (date) {
                                setState(() {
                                  _tareas[i] = Tarea(
                                    idtarea: _tareas[i].idtarea,
                                    idproyecto: _tareas[i].idproyecto,
                                    code: _tareas[i].code,
                                    descripcion: _tareas[i].descripcion,
                                    fechaInicio: date,
                                    fechaFin: _tareas[i].fechaFin,
                                    idempleado: _tareas[i].idempleado,
                                    empleado: _tareas[i].empleado,
                                    idestadoTarea: _tareas[i].idestadoTarea,
                                    avance: _tareas[i].avance,
                                    estadoTarea: _tareas[i].estadoTarea,
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 230,
                            child: CustomDatePicker(
                              label: 'Fecha Fin',
                              initialDate: _tareas[i].fechaFin,
                              onChanged: (date) {
                                setState(() {
                                  _tareas[i] = Tarea(
                                    idtarea: _tareas[i].idtarea,
                                    idproyecto: _tareas[i].idproyecto,
                                    code: _tareas[i].code,
                                    descripcion: _tareas[i].descripcion,
                                    fechaInicio: _tareas[i].fechaInicio,
                                    fechaFin: date,
                                    idempleado: _tareas[i].idempleado,
                                    empleado: _tareas[i].empleado,
                                    idestadoTarea: _tareas[i].idestadoTarea,
                                    avance: _tareas[i].avance,
                                    estadoTarea: _tareas[i].estadoTarea,
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 210,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: _tareas[i].idempleado,
                                hint: Text('Empleado', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400])),
                                items: _empleados.map((e) => DropdownMenuItem<int>(
                                  value: e.idempleado,
                                  child: Text(e.nombreCompleto, style: theme.textTheme.bodySmall, overflow: TextOverflow.ellipsis,),
                                )).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _tareas[i] = Tarea(
                                      idtarea: _tareas[i].idtarea,
                                      idproyecto: _tareas[i].idproyecto,
                                      code: _tareas[i].code,
                                      descripcion: _tareas[i].descripcion,
                                      fechaInicio: _tareas[i].fechaInicio,
                                      fechaFin: _tareas[i].fechaFin,
                                      idempleado: val ?? 0,
                                      idestadoTarea: _tareas[i].idestadoTarea,
                                      avance: _tareas[i].avance,
                                      estadoTarea: _tareas[i].estadoTarea,
                                    );
                                  });
                                },
                                dropdownColor: theme.colorScheme.surfaceContainerLowest,
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onAddTarea() {
    setState(() {
      _tareas.addAll([1, 2, 3].map((e) => Tarea.newItem(idproyecto: widget.proyecto.idproyecto!)).toList());
    });
  }

  void _onSaveTareas() {
    DialogAsk.simple(
      context: context, 
      title: 'Guardar tareas', 
      content: Text('Funcionalidad en desarrollo.'), 
      onOk: (){}
    );
  }
}