import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/periodo.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/entities/tarea_gasto.dart';
import 'package:constructoria/domain/entities/tipo_gasto.dart';
import 'package:constructoria/domain/entities/tipo_valor.dart';
import 'package:constructoria/domain/repositories/periodo_queries.dart';
import 'package:constructoria/domain/repositories/tipo_gasto_queries.dart';
import 'package:constructoria/domain/repositories/tipo_valor_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EdicionGastoDialog extends StatefulWidget {
  const EdicionGastoDialog({super.key, required this.client, required this.titulo, required this.tarea, required this.gasto, required this.onChanged});

  final GraphQLClient client;
  final String titulo;
  final Tarea tarea;
  final TareaGasto gasto;
  final void Function() onChanged;

  @override
  State<EdicionGastoDialog> createState() => _EdicionGastoDialogState();
}

class _EdicionGastoDialogState extends State<EdicionGastoDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: AlertDialog(
        title: Text(
          widget.titulo,
          style: theme.textTheme.titleMedium,
        ),
        content: AgregarGastoComponent(
          client: widget.client,
          titulo: widget.titulo,
          tarea: widget.tarea,
          gasto: widget.gasto,
          onChanged: widget.onChanged,
        ),
        actions: <Widget>[],
      ),
    );
  }
}

class AgregarGastoComponent extends StatefulWidget {
  const AgregarGastoComponent({super.key, required this.client, required this.titulo, required this.tarea, required this.gasto, required this.onChanged});

  final GraphQLClient client;
  final String titulo;
  final Tarea tarea;
  final TareaGasto gasto;
  final void Function() onChanged;

  @override
  State<AgregarGastoComponent> createState() => _AgregarGastoComponentState();
}

class _AgregarGastoComponentState extends State<AgregarGastoComponent> {
  final _formKey = GlobalKey<FormState>();
  final _costoController = TextEditingController();
  late double _totalWidth;
  late double _totalHeight;
  late double _dialogWidth;
  late double _dialogHeight;
  var _isSaving = false;
  int _idTipoGasto = 0;
  int _idPeriodo = 1;
  int _idTipoValor = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _totalWidth = MediaQuery.of(context).size.width;
    _totalHeight = MediaQuery.of(context).size.height;
    if(_totalWidth > 700) {
      _dialogWidth = _totalWidth * 0.6;
      _dialogHeight = _totalHeight * 0.5;
    } else {
      _dialogWidth = _totalWidth * 0.9;
      _dialogHeight = _totalHeight * 0.5;
    }
  }

  @override
  void initState() {
    super.initState();
    _idPeriodo = widget.gasto.idPeriodo;
    _idTipoValor = widget.gasto.idTipoValor;
    if(widget.gasto.idtareaGasto == null) {
      _idTipoGasto = 0;
      _costoController.text = '';
    } else {
      _idTipoGasto = widget.gasto.idTipoGasto!;
      _costoController.text = widget.gasto.costo.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _dialogWidth,
      height: _dialogHeight,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              Query(
                options: QueryOptions(
                  document: gql(TipoGastoQueries.getAll),
                ),
                builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                  if (result.hasException) {
                    return Text('Error al cargar los tipos de gasto');
                  }
                  if (result.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final tiposGasto =  TipoGasto.fromJsonList(result.data?['tipoGastos'] ?? []);
                  tiposGasto.insert(0, TipoGasto(idTipoGasto: 0,codigo: '', nombre: 'Seleccione un tipo de gasto', descripcion: '', costo: 0.0));
    
                  if(tiposGasto.isEmpty) {
                    return Text('No hay tipos de gasto disponibles');
                  }
    
                  return DropdownButtonFormField<int>(
                    initialValue: _idTipoGasto,
                    decoration: InputDecoration(
                      labelText: 'Tipo de Gasto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: tiposGasto.map<DropdownMenuItem<int>>((tipo) {
                      return DropdownMenuItem<int>(
                        value: tipo.idTipoGasto,
                        child: Text(tipo.nombre),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _idTipoGasto = newValue!;
                        _costoController.text = tiposGasto.firstWhere((tipo) => tipo.idTipoGasto == newValue).costo.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null || value == 0) {
                        return 'Por favor seleccione un tipo de gasto';
                      }
                      return null;
                    },
                  );
                }
              ),
              SizedBox(height: 16),
              Query(
                options: QueryOptions(
                  document: gql(PeriodoQueries.getAll),
                ),
                builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                  if (result.hasException) {
                    return Text('Error al cargar periodos');
                  }
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final periodos = Periodo.fromJsonList(result.data?['periodos'] ?? []);
                  if (periodos.isEmpty) {
                    return Text('No hay periodos disponibles');
                  }
                  periodos.insert(0, Periodo(idperiodo: 0, nombre: 'Seleccione un periodo'));

                  final initialPeriodo = periodos.any((p) => p.idperiodo == _idPeriodo) ? _idPeriodo : 0;

                  return DropdownButtonFormField<int>(
                    initialValue: initialPeriodo,
                    decoration: InputDecoration(
                      labelText: 'Periodo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: periodos.map<DropdownMenuItem<int>>((p) {
                      return DropdownMenuItem<int>(
                        value: p.idperiodo ?? 0,
                        child: Text(p.nombre),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _idPeriodo = newValue ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value == 0) {
                        return 'Por favor seleccione un periodo';
                      }
                      return null;
                    },
                  );
                }
              ),
              SizedBox(height: 16),
              Query(
                options: QueryOptions(
                  document: gql(TipoValorQueries.getAll),
                ),
                builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                  if (result.hasException) {
                    return Text('Error al cargar tipos de valor');
                  }
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final tiposValor = TipoValor.fromJsonList(result.data?['tipoValores'] ?? []);
                  if (tiposValor.isEmpty) {
                    return Text('No hay tipos de valor disponibles');
                  }
                  tiposValor.insert(0, TipoValor(idtipoValor: 0, nombre: 'Seleccione un tipo de valor'));

                  final initialTipoValor = tiposValor.any((t) => t.idtipoValor == _idTipoValor) ? _idTipoValor : 0;

                  return DropdownButtonFormField<int>(
                    initialValue: initialTipoValor,
                    decoration: InputDecoration(
                      labelText: 'Tipo de valor',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: tiposValor.map<DropdownMenuItem<int>>((t) {
                      return DropdownMenuItem<int>(
                        value: t.idtipoValor ?? 0,
                        child: Text(t.nombre),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _idTipoValor = newValue ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value == 0) {
                        return 'Por favor seleccione un tipo de valor';
                      }
                      return null;
                    },
                  );
                }
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _costoController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  labelText: 'Costo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un costo';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Mutation(
                    options: MutationOptions(
                      document: gql(widget.gasto.query),
                      onCompleted: (dynamic resultData) {
                        if(resultData != null) {
                          setState(() {
                            _isSaving = false;
                          });
                          widget.onChanged();
                          Navigator.of(context).pop();
                        }
                      },
                      onError: (error) {
                        setState(() {
                          _isSaving = false;
                        });
                        print('Error al guardar el gasto: $error');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al guardar el gasto:Desconocido')),
                        );
                      },
                    ),
                    builder: (RunMutation runMutation, QueryResult? result) {
                      return !_isSaving 
                      ? TextButton(
                          child: Text('Guardar'),
                          onPressed: ()=>_onSave(runMutation),
                        )
                      : SizedBox(
                          width: 100,
                          child: WaitTool(),
                        );
                    }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSave(runMutation) {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() {
      _isSaving = true;
    });
    widget.gasto.idTipoGasto = _idTipoGasto;
    widget.gasto.idPeriodo = _idPeriodo;
    widget.gasto.idTipoValor = _idTipoValor;
    widget.gasto.costo = double.tryParse(_costoController.text) ?? 0;
    runMutation(widget.gasto.data());
  }
}