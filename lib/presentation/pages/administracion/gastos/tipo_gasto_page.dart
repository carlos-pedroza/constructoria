import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/cors/snak.dart';
import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/tipo_gasto.dart';
import 'package:constructoria/domain/repositories/tipo_gasto_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TipoGastoPage extends StatefulWidget {
  const TipoGastoPage({super.key, required this.client, required this.gasto, required this.onSave, required this.onDelete, required this.onBack});

  final GraphQLClient client;
  final TipoGasto gasto;
  final void Function(TipoGasto gasto) onSave;
  final void Function(TipoGasto gasto) onDelete;
  final void Function() onBack;

  @override
  State<TipoGastoPage> createState() => _TipoGastoPageState();
}

class _TipoGastoPageState extends State<TipoGastoPage> {
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _codigoController = TextEditingController();
  final _costoController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.gasto.nombre;
    _descripcionController.text = widget.gasto.descripcion;
    _codigoController.text = widget.gasto.codigo;
    _costoController.text = widget.gasto.costo.toString();
  }

  @override
  void didUpdateWidget(covariant TipoGastoPage oldWidget) {
    _nombreController.text = widget.gasto.nombre;
    _descripcionController.text = widget.gasto.descripcion;
    _codigoController.text = widget.gasto.codigo;
    _costoController.text = widget.gasto.costo.toString();
        super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _codigoController.dispose();
    _costoController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          icon: Icon(Icons.list_alt_rounded, size: 30),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.work, size: 40),
                        SizedBox(width: 10),
                        Text(
                          'Gastos',
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
                            document: gql(widget.gasto.query),
                            onCompleted: (dynamic resultData) {
                              if(resultData != null && (resultData['createTipoGasto'] != null || resultData['updateTipoGasto'] != null)) {
                                widget.onSave(widget.gasto);
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
                        if(widget.gasto.idTipoGasto != null)
                          Mutation(
                            options: MutationOptions(
                              document: gql(TipoGastoQueries.delete),
                              onCompleted: (dynamic resultData) {
                                if(resultData != null && resultData['removeTipoGasto'] == true) {
                                  Snak.show(
                                    context: context, 
                                    message: 'Proyecto eliminado exitosamente',
                                    backcolor: Colors.green[700],
                                    style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.surfaceContainerLowest),
                                  );
                                  widget.onDelete(widget.gasto);
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 30, child: _textField(_codigoController, 'Código')),
                        Expanded(flex: 70, child: _textField(_nombreController, 'Nombre')),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 70, child: _textField(_descripcionController, 'Descripción')),
                        Expanded(flex: 30, child: _textField(_costoController, 'Costo sugerido', keyboardType: TextInputType.number)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
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
    // Validación básica
    if (_nombreController.text.isEmpty || _codigoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos obligatorios')),
      );
      setState(() {
        _saving = false;
      });
      return;
    }
    final costo = double.tryParse(_costoController.text) ?? 0.0;
    final gasto = TipoGasto(
      idTipoGasto: widget.gasto.idTipoGasto,
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      codigo: _codigoController.text,
      costo: costo,
    );
    runMutation(gasto.data());
    setState(() {
      _saving = false;
    });
  }

  void _onEliminar(runMutation) {
    DialogAsk.confirm(
      context: context, 
      title: 'Confirmar eliminación', 
      content: Text('¿Confirmas que deseas eliminar este material?'), 
      onYes: () {
        _eliminar(runMutation);
      }, 
      onNo: () {}
    );
  }

  void _eliminar(runMutation) {
    runMutation({
      "id": widget.gasto.idTipoGasto,
    });
  }
}