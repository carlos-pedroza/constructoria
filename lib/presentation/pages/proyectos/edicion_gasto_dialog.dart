import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/entities/tarea_gasto.dart';
import 'package:constructoria/domain/entities/tipo_gasto.dart';
import 'package:constructoria/domain/repositories/tarea_gasto_queries.dart';
import 'package:constructoria/domain/repositories/tipo_gasto_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EdicionGastoDialog extends StatefulWidget {
  const EdicionGastoDialog({super.key, required this.client, required this.titulo, required this.tarea, required this.gasto});

  final GraphQLClient client;
  final String titulo;
  final Tarea tarea;
  final TareaGasto gasto;

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
        ),
        actions: <Widget>[],
      ),
    );
  }
}

class AgregarGastoComponent extends StatefulWidget {
  const AgregarGastoComponent({super.key, required this.client, required this.titulo, required this.tarea, required this.gasto});

  final GraphQLClient client;
  final String titulo;
  final Tarea tarea;
  final TareaGasto gasto;

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
  int? _idTipoGasto;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _totalWidth = MediaQuery.of(context).size.width;
    _totalHeight = MediaQuery.of(context).size.height;
    if(_totalWidth > 700) {
      _dialogWidth = _totalWidth * 0.6;
      _dialogHeight = _totalHeight * 0.3;
    } else {
      _dialogWidth = _totalWidth * 0.9;
      _dialogHeight = _totalHeight * 0.3;
    }
  }

  @override
  void initState() {
    super.initState();
    _costoController.text = widget.gasto.costo.toString();
    _idTipoGasto = widget.gasto.idTipoGasto;
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
    
                  if(tiposGasto.isEmpty) {
                    return Text('No hay tipos de gasto disponibles');
                  }
                  if(widget.gasto.idTipoGasto == null) {
                    widget.gasto.idTipoGasto = tiposGasto.first.idTipoGasto!;
                    widget.gasto.costo = tiposGasto.first.costo;
                    _costoController.text = tiposGasto.first.costo.toString();
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
                      if (value == null) {
                        return 'Por favor seleccione un tipo de gasto';
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
                keyboardType: TextInputType.number,
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
                      document: gql(TareaGastoQueries.create),
                      onCompleted: (dynamic resultData) {
                        if(resultData != null) {
                          setState(() {
                            _isSaving = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    builder: (RunMutation runMutation, QueryResult? result) {
                      return !_isSaving 
                      ? TextButton(
                          child: Text('Guardar'),
                          onPressed: () {
                            // Lógica para guardar el gasto editado
                            setState(() {
                              _isSaving = true;
                            });
                            widget.gasto.idTipoGasto = _idTipoGasto;
                            widget.gasto.costo = double.tryParse(_costoController.text) ?? 0;
                            runMutation(widget.gasto.create());
                          },
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
}