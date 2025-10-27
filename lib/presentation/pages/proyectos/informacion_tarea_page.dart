import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/entities/tarea_gasto.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
import 'package:constructoria/presentation/pages/proyectos/edicion_gasto_dialog.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class InformacionTareaPage extends StatefulWidget {
  const InformacionTareaPage({super.key, required this.client, required this.tarea});

  final GraphQLClient client;
  final Tarea tarea;

  @override
  State<InformacionTareaPage> createState() => _InformacionTareaPageState();
}

class _InformacionTareaPageState extends State<InformacionTareaPage> {
  final _dateFormat = DateFormat('dd/MM/yyyy HH:mm');
  final _porcetajeFormat = NumberFormat.percentPattern();
  final _currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');


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
              child: ListTile(
                title: Text(
                  '${widget.tarea.code} ${widget.tarea.descripcion}',
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${_dateFormat.format(widget.tarea.fechaInicio)} - ${_dateFormat.format(widget.tarea.fechaFin)}      Asignado: ${widget.tarea.empleado ?? "No asignado"}',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 100.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Avance ${_porcetajeFormat.format(widget.tarea.avance)}',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            SizedBox(width: 10.0),
                            Text(
                              'Costo por hora: ${_currencyFormat.format(widget.tarea.costoPorHora)},',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 14.0),
                            Text(
                              'Horas: ${(widget.tarea.horasTrabajadas * widget.tarea.avance).toStringAsFixed(2)}, ',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 14.0),
                            Text(
                              'Total MO: ${_currencyFormat.format(widget.tarea.costoTotalManoObra)}',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                        child: LinearProgressIndicator(
                          value: widget.tarea.avance, // Cambia por el avance global
                          backgroundColor: Colors.blue[50],
                          color: Colors.blue,
                          minHeight: 10,
                        ),
                      ),
                      Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            flex: 5,
                            child: ElevatedButton(
                              onPressed: ()=>_onCambiaAvance(0.0),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.tarea.avance == 0.0 ? Colors.grey[600]: Colors.blue[900] ,
                                foregroundColor: theme.colorScheme.surfaceContainerLowest,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                              ),
                              child: Text(widget.tarea.avance == 0.0 ? '0' : '', style: TextStyle(color: theme.colorScheme.surfaceContainerLowest)),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            flex: 25,
                            child: ElevatedButton(
                              onPressed: ()=>_onCambiaAvance(0.2),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.tarea.avance >= 0.2 && widget.tarea.avance > 0 ? Colors.blue[900] : Colors.blue[700] ,
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
                              onPressed: ()=>_onCambiaAvance(0.4),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.tarea.avance >= 0.4 ? Colors.blue[900] : Colors.blue[700],
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
                              onPressed: ()=>_onCambiaAvance(0.6),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.tarea.avance >= 0.6 ? Colors.blue[900] : Colors.blue[700],
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
                              onPressed: ()=>_onCambiaAvance(0.8),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.tarea.avance >= 0.8 ? Colors.blue[900] : Colors.blue[700],
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
                              onPressed: ()=>_onCambiaAvance(1.0),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.tarea.avance >= 1 ? Colors.blue[900] : Colors.blue[700],
                                foregroundColor: theme.colorScheme.surfaceContainerLowest,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                              ),
                              child: Text('100%', style: TextStyle(color: theme.colorScheme.surfaceContainerLowest)),
                            ),
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceBright,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gastos',
                                      style: theme.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    SizedBox(width: 10.0),
                                    ElevatedButton.icon(
                                      onPressed: _onAgregarGasto,
                                      label: SizedBox(
                                        width: 70,
                                        child: Center(child: Text('Gasto'))
                                      ),
                                      icon: Icon(Icons.add),
                                    )
                                  ],
                                ),
                              ),
                              Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                              Container(
                                padding: EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text(
                                    'No hay gastos asociados a la tarea.',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceBright,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Materiales',
                                      style: theme.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    SizedBox(width: 10.0),
                                    ElevatedButton.icon(
                                      onPressed: _onAgregarMaterial,
                                      label: SizedBox(
                                        width: 70,
                                        child: Center(child: Text('Material')),
                                      ),
                                      icon: Icon(Icons.add),
                                    )
                                  ],
                                ),
                              ),
                              Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                              Container(
                                padding: EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text(
                                    'No hay materiales asociados a la tarea.',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
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
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void _onClose() {
    Navigator.of(context).pop();
  }

  void _onCambiaAvance(double nuevoAvance) {
    setState(() {
      widget.tarea.avance = nuevoAvance;
    });
  }

  void _onAgregarGasto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EdicionGastoDialog(
          client: widget.client,
          titulo: 'Agregar Gasto',
          tarea: widget.tarea,
          gasto: TareaGasto.empty(widget.tarea),
        );
      },
    );
  }

  void _onAgregarMaterial() {
  }
}