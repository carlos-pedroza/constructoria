import 'package:constructoria/cors/snak.dart';
import 'package:constructoria/domain/entities/estado_tarea.dart';
import 'package:constructoria/domain/entities/v_tarea.dart';
import 'package:constructoria/domain/repositories/tarea_queries.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
import 'package:constructoria/presentation/pages/proyectos/Informacion_tarea_gastos_component.dart';
import 'package:constructoria/presentation/pages/proyectos/Informacion_tarea_materiales_component.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class InformacionTareaPage extends StatefulWidget {
  const InformacionTareaPage({super.key, required this.client, required this.tarea, required this.refetch});

  final GraphQLClient client;
  final VTarea tarea;
  final refetch;

  @override
  State<InformacionTareaPage> createState() => _InformacionTareaPageState();
}

class _InformacionTareaPageState extends State<InformacionTareaPage> {
  final _dateFormat = DateFormat('dd/MM/yyyy HH:mm');
  final _porcetajeFormat = NumberFormat.percentPattern();
  final _currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
  var _totalGastos = 0.0;
  var _totalMateriales = 0.0;
  late VTarea _tarea;
  var _changeEstado = false;

  @override
  void initState() {
    super.initState();
    _tarea = widget.tarea;
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Scaffold(
        body: Column(
          children: [
            TitlePageComponent(onClose: _onClose),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceBright,
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        '${_tarea.code} ${_tarea.tareaDescripcion}',
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${_dateFormat.format(_tarea.fechaInicio)} - ${_dateFormat.format(_tarea.fechaFin)}  Asignado: ${_tarea.responsable}',
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _onChangeEstado,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _tarea.estadoTareaNombre,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if(_changeEstado)
            Mutation(
              options: MutationOptions(
                document: gql(TareaQueries.updateTarea),
                onCompleted: (data) {
                  if(data == null) return;
                  setState(() {
                    _changeEstado = false;
                  });
                  widget.refetch();
                },
                onError: (error) {
                  Snak.show(
                    context: context, 
                    message: 'Error al actualizar el estado de la tarea.',
                    backcolor: theme.colorScheme.error,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.surfaceContainerLowest
                    ),
                  );
                },
              ),
              builder: (RunMutation runMutation, QueryResult? mutationResult) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  color: theme.colorScheme.secondary,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => changeTareaEstado(EstadoTarea.getEstadoTarea(EstadoTarea.pendiente), runMutation),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    EstadoTarea.estadoToString(EstadoTarea.pendiente),
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onPrimaryContainer,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: () => changeTareaEstado(EstadoTarea.getEstadoTarea(EstadoTarea.enProgreso), runMutation),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    EstadoTarea.estadoToString(EstadoTarea.enProgreso),
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onPrimaryContainer,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: () => changeTareaEstado(EstadoTarea.getEstadoTarea(EstadoTarea.enRevision), runMutation),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    EstadoTarea.estadoToString(EstadoTarea.enRevision),
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onPrimaryContainer,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: () => changeTareaEstado(EstadoTarea.getEstadoTarea(EstadoTarea.completada), runMutation),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    EstadoTarea.estadoToString(EstadoTarea.completada),
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onPrimaryContainer,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: () => changeTareaEstado(EstadoTarea.getEstadoTarea(EstadoTarea.bloqueada), runMutation),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    EstadoTarea.estadoToString(EstadoTarea.bloqueada),
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onPrimaryContainer,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: () => changeTareaEstado(EstadoTarea.getEstadoTarea(EstadoTarea.cancelada), runMutation),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    EstadoTarea.estadoToString(EstadoTarea.cancelada),
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,      
                                      color: theme.colorScheme.onPrimaryContainer,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _changeEstado = false;
                          });
                        },
                        icon: Icon(Icons.close, color: theme.colorScheme.surfaceContainerLowest),
                      ),
                    ],
                  ),
                );
              }
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                            child: Text(
                              'Información detallada de la tarea.',
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Avance ${_porcetajeFormat.format(_tarea.avance)}',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                SizedBox(width: 10.0),
                                Text(
                                  'Costo por hora: ${_currencyFormat.format(_tarea.costoPorHora)},',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 14.0),
                                Text(
                                  'Horas: ${widget.tarea.horasTrabajadas}',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 14.0),
                                Text(
                                  'Total MO: ${_currencyFormat.format(_tarea.totalManoObraAvance)}',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 14.0),
                                if(_totalGastos > 0.0)
                                Padding(
                                  padding: const EdgeInsets.only(right: 14.0),
                                  child: Text(
                                    'Total Gasto: ${_currencyFormat.format(_totalGastos)}',
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14.0),
                                if(_totalMateriales > 0.0)
                                Padding(
                                  padding: const EdgeInsets.only(right: 14.0),
                                  child: Text(
                                    'Total Materiales: ${_currencyFormat.format(_totalMateriales)}',
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                            child: LinearProgressIndicator(
                              value: _tarea.avance, // Cambia por el avance global
                              backgroundColor: Colors.blue[50],
                              color: Colors.blue,
                              minHeight: 10,
                            ),
                          ),
                          Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                          SizedBox(height: 10.0),
                          Mutation(
                            options: MutationOptions(
                              document: gql(TareaQueries.updateTarea),
                              onCompleted: (data) {
                              },
                              onError: (error) {
                                Snak.show(
                                  context: context, 
                                  message: 'Error al actualizar el estado de la tarea.',
                                  backcolor: theme.colorScheme.error,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.surfaceContainerLowest
                                  ),
                                );
                              },
                            ),
                            builder: (RunMutation runMutation, QueryResult? mutationResult) {
                              return Row(
                                children: [
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 5,
                                    child: ElevatedButton(
                                      onPressed: ()=>_onCambiaAvance(0.0, runMutation),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _tarea.avance == 0.0 ? Colors.grey[600]: Colors.blue[900] ,
                                        foregroundColor: theme.colorScheme.surfaceContainerLowest,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                      ),
                                      child: Text(_tarea.avance == 0.0 ? '0' : '', style: TextStyle(color: theme.colorScheme.surfaceContainerLowest)),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    flex: 25,
                                    child: ElevatedButton(
                                      onPressed: ()=>_onCambiaAvance(0.2, runMutation),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _tarea.avance >= 0.2 && _tarea.avance > 0 ? Colors.blue[900] : Colors.blue[700] ,
                                        foregroundColor: theme.colorScheme.surfaceContainerLowest,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                      ),
                                      child: Text('20%', style: TextStyle(color: theme.colorScheme.surfaceContainerLowest)),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    flex: 25,
                                    child: ElevatedButton(
                                      onPressed: ()=>_onCambiaAvance(0.4, runMutation),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _tarea.avance >= 0.4 ? Colors.blue[900] : Colors.blue[700],
                                        foregroundColor: theme.colorScheme.surfaceContainerLowest,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                      ),
                                      child: Text('40%', style: TextStyle(color: theme.colorScheme.surfaceContainerLowest)),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    flex: 25,
                                    child: ElevatedButton(
                                      onPressed: ()=>_onCambiaAvance(0.6, runMutation),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _tarea.avance >= 0.6 ? Colors.blue[900] : Colors.blue[700],
                                        foregroundColor: theme.colorScheme.surfaceContainerLowest,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                      ),
                                      child: Text('60%', style: TextStyle(color: theme.colorScheme.surfaceContainerLowest)),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    flex: 25,
                                    child: ElevatedButton(
                                      onPressed: ()=>_onCambiaAvance(0.8, runMutation),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _tarea.avance >= 0.8 ? Colors.blue[900] : Colors.blue[700],
                                        foregroundColor: theme.colorScheme.surfaceContainerLowest,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                      ),
                                      child: Text('80%', style: TextStyle(color: theme.colorScheme.surfaceContainerLowest)),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    flex: 25,
                                    child: ElevatedButton(
                                      onPressed: ()=>_onCambiaAvance(1.0, runMutation),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _tarea.avance >= 1 ? Colors.blue[900] : Colors.blue[700],
                                        foregroundColor: theme.colorScheme.surfaceContainerLowest,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                      ),
                                      child: Text('100%', style: TextStyle(color: theme.colorScheme.surfaceContainerLowest)),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                ],
                              );
                            }
                          ),
                          SizedBox(height: 10),
                          Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10),
                              InformacionTareaGastosComponent(
                                client: widget.client,
                                tarea: _tarea.toTarea(),
                                getTotalGasto: (double total) {
                                  setState(() {
                                    _totalGastos = total;
                                  });
                                  widget.refetch();
                                },
                              ),
                              SizedBox(height: 20.0),
                              InformacionTareaMaterialesComponent(
                                client: widget.client, 
                                tarea: _tarea.toTarea(), 
                                changeTotalMateriales: (double total){
                                  setState(() {
                                    _totalMateriales = total;
                                  });
                                  widget.refetch();
                                },
                              ),
                              SizedBox(height: 100.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClose() {
    Navigator.of(context).pop();
  }

  void _onCambiaAvance(double nuevoAvance, runMutation) {
    setState(() {
      _tarea.avance = nuevoAvance;
    });
    runMutation(_tarea.toTarea().update());
    widget.refetch();
  }

  void _onChangeEstado() {
    setState(() {
      _changeEstado = true;
    });
    widget.refetch();
  }

  void changeTareaEstado(EstadoTarea nuevoEstado, RunMutation runMutation) {
    var tarea = _tarea.toTarea();
    tarea.estadoTarea = EstadoTarea(
      idestadoTarea: nuevoEstado.idestadoTarea,
      nombre: nuevoEstado.nombre,
      descripcion: nuevoEstado.descripcion,
    );
    tarea.idestadoTarea = nuevoEstado.idestadoTarea!;
    setState(() {
      _tarea.estadoTareaNombre = nuevoEstado.nombre;
      _tarea.idestadoTarea = nuevoEstado.idestadoTarea!;
    });
    runMutation(tarea.update());
  }
}

