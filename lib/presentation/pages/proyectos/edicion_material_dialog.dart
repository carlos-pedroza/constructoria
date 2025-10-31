import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/material_entidad.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/entities/tarea_material.dart';
import 'package:constructoria/domain/repositories/material_queries.dart';
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
  final _cantidadController = TextEditingController();
  final _costoController = TextEditingController();
  late double _totalWidth;
  late double _totalHeight;
  late double _dialogWidth;
  late double _dialogHeight;
  var _isSaving = false;
  int _idTipoMaterial = 0;
  var _initialized = false;
  late List<MaterialEntidad> _materiales;

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
    if(widget.tareaMaterial.idtareaMaterial == null) {
      _idTipoMaterial = 0;
      _cantidadController.text = '';
      _costoController.text = '';
    } else {
      _idTipoMaterial = widget.tareaMaterial.idMaterial;
      _cantidadController.text = widget.tareaMaterial.cantidad.toString();
      _costoController.text = widget.tareaMaterial.costo.toString();
    }
    _materiales = [];
  }

  @override
  void dispose() {
    _cantidadController.dispose();
    _costoController.dispose();
    super.dispose();
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
                  document: gql(MaterialQueries.getAll),
                ),
                builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                  
                  if(_initialized) {

                    if (result.hasException) {
                      return Text('Error al cargar los materiales');
                    }
                    if (result.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    _materiales =  MaterialEntidad.fromJsonList(result.data?['materials'] ?? []);
                    _materiales.insert(0, MaterialEntidad(idMaterial: 0,codigo: '', nombre: 'Seleccione un material', descripcion: '', unidad: '',  costo: 0.0));
      
                    if(_materiales.isEmpty) {
                      return Text('No hay materiales disponibles');
                    }
                    
                  }
                  _initialized = true;
                  return DropdownButtonFormField<int>(
                    initialValue: _idTipoMaterial,
                    decoration: InputDecoration(
                      labelText: 'Material',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: _materiales.map<DropdownMenuItem<int>>((tipo) {
                      return DropdownMenuItem<int>(
                        value: tipo.idMaterial,
                        child: Text('${tipo.nombre} (${tipo.unidad})'),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _idTipoMaterial = newValue!;
                        _costoController.text = _materiales.firstWhere((tipo) => tipo.idMaterial == newValue).costo.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor seleccione un material';
                      }
                      return null;
                    },
                  );
                }
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cantidadController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.confirmation_num),
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una cantidad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
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
                        print('Error al guardar el material: $error');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al guardar el material: Desconocido')),
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
    widget.tareaMaterial.cantidad = int.tryParse(_cantidadController.text) ?? 0;
    widget.tareaMaterial.costo = double.tryParse(_costoController.text) ?? 0;
    runMutation(widget.tareaMaterial.data());
  }
}