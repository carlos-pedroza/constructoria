import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/cors/snak.dart';
import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:constructoria/domain/repositories/tarea_queries.dart';
import 'package:constructoria/presentation/global_components/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/services.dart';

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
  var _tareasDeleted = <Tarea>[];
  var _empleados = <Empleado>[];
  var _isLoading = true;
  var _saving = false;

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
      _tareasDeleted = [];
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
                if(_saving)
                  SizedBox(
                    width: 100,
                    child: WaitTool()
                  )
                else
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
                        SizedBox(width: 140),
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
                    TareaItemComponent(
                      key: ValueKey(i),
                      index: i,
                      tarea: _tareas[i],
                      empleados: _empleados,
                      onChanged: (tarea) {
                        _tareas[i] = tarea;
                      },
                      onInsertAbove: (tarea) {
                        setState(() {
                          _tareas.insert(i, tarea);
                        });
                      },
                      onInsertBelow: (tarea) {
                        setState(() {
                          _tareas.insert(i + 1, tarea);
                        });
                      },
                      onDelete: _onDeleteTarea,
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

  bool _validateTareas(List<Tarea> tareas) {
    for (var index = 0; index < tareas.length; index++) {
      var tarea = tareas[index];
      if (tarea.descripcion.trim().isNotEmpty) {
        if (tarea.fechaFin.isBefore(tarea.fechaInicio)) {
          Snak.show(
            context: context, message: 'La fecha fin no puede ser anterior a la fecha inicio, en la tarea ${index + 1}', 
            backcolor: Colors.red,
            style: TextStyle(color: Colors.white),
          );
          return false;
        }
        if (tarea.idempleado == 0) {
          Snak.show(
            context: context, message: 'Debe asignar un empleado en la tarea ${index + 1}', 
            backcolor: Colors.red,
            style: TextStyle(color: Colors.white),
          );
          return false;
        }
      }
    }
    return true;
  }

  void _onSaveTareas() {
    setState(() {
      _saving = true;
    });
    var tareas = _tareas.where((t) => t.descripcion.trim().isNotEmpty).toList();
    if(_validateTareas(tareas)) {
      _saveTarea(0, tareas, widget.client);
    } else {
      setState(() {
        _saving = false;
      });
    }
  }

  void _saveTarea(int index, List<Tarea> tareas, GraphQLClient client) async {
    if(index >= tareas.length) {
      _deleteTarea(0, _tareasDeleted, client);
      return;
    }
    await client.mutate(
      MutationOptions(
        document: gql(tareas[index].query),
        variables: tareas[index].data(index + 1),
        onCompleted: (data) {
          if (data != null) {
            if(data['createTarea'] != null || data['updateTarea'] != null) {
              _saveTarea(index + 1, tareas, client);
            }
          } 
        },
        onError: (error) {
          print('Error saving tarea: ${error.toString()}');
          setState(() {
            _saving = false;
          });
          _fetchTareas();
          Snak.show(
            context: context, message: 'Error al guardar las tareas', 
            backcolor: Colors.red,
            style: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  void _deleteTarea(int index, List<Tarea> tareas, GraphQLClient client) async {
    if(index >= tareas.length) {
      setState(() {
        _saving = false;
      });
      _fetchTareas();
      Snak.show(
        context: context, message: 'Tareas guardadas correctamente', 
        backcolor: Colors.green,
        style: TextStyle(color: Colors.white),
      );
      return;
    }
    await client.mutate(
      MutationOptions(
        document: gql(TareaQueries.deleteTarea),
        variables: {'id': tareas[index].idtarea},
        onCompleted: (data) {
          if (data != null) {
            if(data['removeTarea'] != null && data['removeTarea'] == true) {
              _deleteTarea(index + 1, tareas, client);
            }
          } 
        },
        onError: (error) {
          print('Error deleting tarea: ${error.toString()}');
          setState(() {
            _saving = false;
          });
          _fetchTareas();
          Snak.show(
            context: context, message: 'Error al eliminar las tareas', 
            backcolor: Colors.red,
            style: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  void _onDeleteTarea(Tarea tarea) {
    DialogAsk.confirm(
      context: context, 
      title: 'Eliminar tarea', 
      content:Text('¿Está seguro de que desea eliminar esta tarea?'), 
      onYes: () {
        setState(() {
          _tareas.remove(tarea);
          if(tarea.idtarea != null) {
            _tareasDeleted.add(tarea);
          }
        });
      }, 
      onNo: () {}
    );
  }
}



class TareaItemComponent extends StatefulWidget {
  const TareaItemComponent({super.key, required this.index, required this.tarea, required this.empleados, required this.onChanged, required this.onInsertAbove, required this.onInsertBelow, required this.onDelete});

  final int index;
  final Tarea tarea;
  final List<Empleado> empleados;
  final void Function(Tarea tarea) onChanged;
  final void Function(Tarea tarea) onInsertAbove;
  final void Function(Tarea tarea) onInsertBelow;
  final void Function(Tarea tarea) onDelete;

  @override
  State<TareaItemComponent> createState() => _TareaItemComponentState();
}

class _TareaItemComponentState extends State<TareaItemComponent> {
  late Tarea _tarea;
  final _codeTextController = TextEditingController();
  final _descTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tarea = widget.tarea;
    _codeTextController.text = _tarea.code;
    _descTextController.text = _tarea.descripcion;
    _codeTextController.addListener(() {
      setState(() {
        _tarea.code = _codeTextController.text;
      });
      widget.onChanged(_tarea);
    });
    _descTextController.addListener(() {
      setState(() {
        _tarea.descripcion = _descTextController.text;
      });
      widget.onChanged(_tarea);
    });
  }

  @override
  void didUpdateWidget(covariant TareaItemComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _tarea = widget.tarea;
    });
    _codeTextController.text = _tarea.code;
    _descTextController.text = _tarea.descripcion;
  }

  @override
  void dispose() {
    _codeTextController.dispose();
    _descTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'insertar_arriba') {
                _onInsertAbove();
              } else if (value == 'insertar_abajo') {
                _onInsertBelow();
              } else if (value == 'eliminar') {
                _onDelete();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'insertar_arriba',
                child: Text('Insertar arriba'),
              ),
              PopupMenuItem(
                value: 'insertar_abajo',
                child: Text('Insertar abajo'),
              ),
              PopupMenuItem(
                value: 'eliminar',
                child: Text('Eliminar'),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.copy, color: Colors.grey[600], size: 16),
            onPressed: () => _onCopy(_tarea),
          ),
          IconButton(
            icon: Icon(Icons.paste, color: Colors.grey[600], size: 16),
            onPressed: () => _onPaste(),
          ),
          Text('${widget.index + 1}:', style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.primary,
          )),
          const SizedBox(width: 8),
          Expanded(
            flex: 14,
            child: TextFormField(
              controller: _codeTextController,
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
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 86,
            child: TextFormField(
              controller: _descTextController,
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
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 230,
            child: CustomDatePicker(
              label: 'Fecha inicio',
              initialDate: _tarea.fechaInicio,
              onChanged: (date) {
                setState(() {
                  _tarea.fechaInicio = date;
                });
                widget.onChanged(_tarea);
              },
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 230,
            child: CustomDatePicker(
              label: 'Fecha Fin',
              initialDate: _tarea.fechaFin,
              onChanged: (date) {
                setState(() {
                  _tarea.fechaFin = date;
                });
                widget.onChanged(_tarea);
              },
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 210,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isExpanded: true,
                value: _tarea.idempleado,
                hint: Text('Empleado', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400])),
                items: widget.empleados.map((e) => DropdownMenuItem<int>(
                  value: e.idempleado,
                  child: Text(e.nombreCompleto, style: theme.textTheme.bodySmall, overflow: TextOverflow.ellipsis,),
                )).toList(),
                onChanged: (val) {
                  setState(() {
                    _tarea.idempleado = val ?? 0;
                  });
                  widget.onChanged(_tarea);
                },
                dropdownColor: theme.colorScheme.surfaceContainerLowest,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _onCopy(Tarea tarea) {
    Clipboard.setData(ClipboardData(text: tarea.toString()));
  }

  void _onPaste() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      if (value != null) {
        final data = value.text?.split('\t');
        if(data == null && data!.isEmpty) return;
        if (data.length >= 4) {
          var dateInicio = DateTime.tryParse(data[2]);
          var dateFin = DateTime.tryParse(data[3]);
          setState(() {
            _tarea.code = data[0];
            _tarea.descripcion = data[1];
            if(dateInicio != null) _tarea.fechaInicio = dateInicio;
            if(dateFin != null) _tarea.fechaFin = dateFin;
          });
          _codeTextController.text = _tarea.code;
          _descTextController.text = _tarea.descripcion;
          widget.onChanged(_tarea);
        }
      }
    });
  }
  
  void _onInsertAbove() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      if (value != null) {
        final data = value.text?.split('\t');
        if(data == null && data!.isEmpty) return;
        if (data.length >= 4) {
          var dateInicio = DateTime.tryParse(data[2]);
          var dateFin = DateTime.tryParse(data[3]);
          var tarea = Tarea.newItem(
            idproyecto: _tarea.idproyecto,
            code: data[0],
            descripcion: data[1],
            fechaInicio: dateInicio ?? DateTime.now(),
            fechaFin: dateFin ?? DateTime.now(),
          );
          widget.onInsertAbove(tarea);
        }
      }
    });
  }
  
  void _onInsertBelow() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      if (value != null) {
        final data = value.text?.split('\t');
        if(data == null && data!.isEmpty) return;
        if (data.length >= 4) {
          var dateInicio = DateTime.tryParse(data[2]);
          var dateFin = DateTime.tryParse(data[3]);
          var tarea = Tarea.newItem(
            idproyecto: _tarea.idproyecto,
            code: data[0],
            descripcion: data[1],
            fechaInicio: dateInicio ?? DateTime.now(),
            fechaFin: dateFin ?? DateTime.now(),
          );
          widget.onInsertBelow(tarea);
        }
      }
    });
  }
  
  void _onDelete() {
    widget.onDelete(widget.tarea);
  }
}