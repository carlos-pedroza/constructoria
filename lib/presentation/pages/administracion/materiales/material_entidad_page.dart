import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/cors/snak.dart';
import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/repositories/material_queries.dart';
import 'package:flutter/material.dart';


import 'package:constructoria/domain/entities/material_entidad.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MaterialEntidadPage extends StatefulWidget {
  const MaterialEntidadPage({
    super.key,
    required this.client,
    required this.material,
    required this.onSave,
    required this.onDelete,
    required this.onBack,
  });

  final GraphQLClient client;
  final MaterialEntidad material;
  final void Function(MaterialEntidad material) onSave;
  final void Function(MaterialEntidad material) onDelete;
  final void Function() onBack;

  @override
  State<MaterialEntidadPage> createState() => _MaterialEntidadPageState();
}

class _MaterialEntidadPageState extends State<MaterialEntidadPage> {
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _unidadController = TextEditingController();
  final _codigoController = TextEditingController();
  final _costoController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.material.nombre;
    _descripcionController.text = widget.material.descripcion;
    _unidadController.text = widget.material.unidad;
    _codigoController.text = widget.material.codigo;
    _costoController.text = widget.material.costo.toString();
  }

  @override
  void didUpdateWidget(covariant MaterialEntidadPage oldWidget) {
    _nombreController.text = widget.material.nombre;
    _descripcionController.text = widget.material.descripcion;
    _unidadController.text = widget.material.unidad;
    _codigoController.text = widget.material.codigo;
    _costoController.text = widget.material.costo.toString();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _unidadController.dispose();
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
                          'Material',
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
                            document: gql(widget.material.query),
                            onCompleted: (dynamic resultData) {
                              if(resultData != null && (resultData['createMaterial'] != null || resultData['updateMaterial'] != null)) {
                                widget.onSave(widget.material);
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
                        if(widget.material.idMaterial != null)
                          Mutation(
                            options: MutationOptions(
                              document: gql(MaterialQueries.delete),
                              onCompleted: (dynamic resultData) {
                                if(resultData != null && resultData['removeMaterial'] == true) {
                                  Snak.show(
                                    context: context, 
                                    message: 'Proyecto eliminado exitosamente',
                                    backcolor: Colors.green[700],
                                    style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.surfaceContainerLowest),
                                  );
                                  widget.onDelete(widget.material);
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
                        Expanded(flex: 50, child: _textField(_descripcionController, 'Descripción')),
                        Expanded(flex: 30, child: _textField(_unidadController, 'Unidad')),
                        Expanded(flex: 20, child: _textField(_costoController, 'Costo sugerido', keyboardType: TextInputType.number)),
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

  // Widget _sectionTitle(BuildContext context, String title) {
  //   return Container(
  //     width: double.infinity,
  //     margin: const EdgeInsets.only(bottom: 8, top: 24),
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //     decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
  //     child: Text(
  //       title,
  //       style: Theme.of(context).textTheme.titleSmall!.copyWith(
  //         color: Theme.of(context).colorScheme.surface,
  //       ),
  //     ),
  //   );
  // }

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
    if (_nombreController.text.isEmpty || _unidadController.text.isEmpty || _codigoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos obligatorios')),
      );
      setState(() {
        _saving = false;
      });
      return;
    }
    final costo = double.tryParse(_costoController.text) ?? 0.0;
    final material = MaterialEntidad(
      idMaterial: widget.material.idMaterial,
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      unidad: _unidadController.text,
      codigo: _codigoController.text,
      costo: costo,
    );
    runMutation(material.data());
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
      "id": widget.material.idMaterial,
    });
  }
}