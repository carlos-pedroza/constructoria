import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/entities/tarea_gasto.dart';
import 'package:constructoria/domain/entities/tipo_gasto.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _costoController = TextEditingController();
  late double _totalWidth;
  late double _totalHeight;
  late double _dialogWidth;
  late double _dialogHeight;

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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        widget.titulo,
        style: theme.textTheme.titleMedium,
      ),
      content: GraphQLProvider(
        client: ValueNotifier(widget.client),
        child: SizedBox(
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
                        return SizedBox(
                          width: 100,
                          child: WaitTool(),
                        );
                      }
                      final tiposGasto =  TipoGasto.fromJsonList(result.data?['tipoGastos'] ?? []);

                      if(tiposGasto.isEmpty) {
                        return Text('No hay tipos de gasto disponibles');
                      }
                      if(widget.gasto.idTipoGasto == null) {
                        widget.gasto.idTipoGasto = tiposGasto.first.idTipoGasto!;
                        widget.gasto.costo = tiposGasto.first.costo;
                         _costoController.text = widget.gasto.costo.toString();
                      }

                      return DropdownButtonFormField<int>(
                        initialValue: widget.gasto.idTipoGasto,
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
                            widget.gasto.idTipoGasto = newValue!;
                            _costoController.text = tiposGasto.firstWhere((tipo) => tipo.idTipoGasto == newValue).costo.toString();
                            widget.gasto.costo = double.tryParse(_costoController.text) ?? 0;
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
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Guardar'),
          onPressed: () {
            // Lógica para guardar el gasto editado
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}