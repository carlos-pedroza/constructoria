import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/entities/tarea_material.dart';
import 'package:constructoria/domain/entities/v_tarea_material.dart';
import 'package:constructoria/domain/entities/tipo_gasto.dart';
import 'package:constructoria/domain/repositories/tipo_gasto_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EdicionMaterialDialog extends StatefulWidget {
  const EdicionMaterialDialog({super.key, required this.client, required this.titulo, required this.tarea, required this.material, required this.onChanged});

  final GraphQLClient client;
  final String titulo;
  final Tarea tarea;
  final TareaMaterial material;
  final void Function() onChanged;

  @override
  State<EdicionMaterialDialog> createState() => _EdicionMaterialDialogState();
}

class _EdicionMaterialDialogState extends State<EdicionMaterialDialog> {
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
        content: AgregarMaterialComponent(
          client: widget.client,
          titulo: widget.titulo,
          tarea: widget.tarea,
          tareaMaterial: widget.material,
          onChanged: widget.onChanged,
        ),
        actions: <Widget>[],
      ),
    );
  }
}

class AgregarMaterialComponent extends StatefulWidget {
  const AgregarMaterialComponent({super.key, required this.client, required this.titulo, required this.tarea, required this.tareaMaterial, required this.onChanged});

  final GraphQLClient client;
  final String titulo;
  final Tarea tarea;
  final TareaMaterial tareaMaterial;
  final void Function() onChanged;

  @override
  State<AgregarMaterialComponent> createState() => _AgregarMaterialComponentState();
}

class _AgregarMaterialComponentState extends State<AgregarMaterialComponent> {
  final _formKey = GlobalKey<FormState>();
  final _costoController = TextEditingController();
  late double _totalWidth;
  late double _totalHeight;
  late double _dialogWidth;
  late double _dialogHeight;
  var _isSaving = false;
  int _idTipoMaterial = 0;

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
    _idTipoMaterial = 0;
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
                    initialValue: _idTipoMaterial,
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
                        _idTipoMaterial = newValue!;
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
                      document: gql(widget.tareaMaterial.query),
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
    setState(() {
      _isSaving = true;
    });
    widget.tareaMaterial.idMaterial = _idTipoMaterial;
    widget.tareaMaterial.costo = double.tryParse(_costoController.text) ?? 0;
    runMutation(widget.tareaMaterial.data());
  }
}