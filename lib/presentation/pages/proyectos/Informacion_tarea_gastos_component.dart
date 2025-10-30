import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/entities/tarea_gasto.dart';
import 'package:constructoria/domain/entities/v_tarea_gasto.dart';
import 'package:constructoria/domain/repositories/tipo_gasto_queries.dart';
import 'package:constructoria/domain/repositories/v_tarea_gasto.queries.dart';
import 'package:constructoria/presentation/pages/proyectos/edicion_gasto_dialog.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';


class InformacionTareaGastosComponent extends StatefulWidget {
  const InformacionTareaGastosComponent({super.key, required this.client, required this.tarea, required this.getTotalGasto});

  final GraphQLClient client;
  final Tarea tarea;
  final void Function(double total) getTotalGasto;

  @override
  State<InformacionTareaGastosComponent> createState() => _InformacionTareaGastosComponentState();
}

class _InformacionTareaGastosComponentState extends State<InformacionTareaGastosComponent> {
  final _currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
  var _totalGastos = 0.0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
      ),
      child: Column(
        children: [
          Query(
            options: QueryOptions(
              document: gql(VTipoGastoQueries.getByTarea),
              variables: {
                'idtarea': widget.tarea.idtarea,
              },
              fetchPolicy: FetchPolicy.noCache,
              onComplete: (data) {
                refreshGastoTotal();
              }
            ),
            builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
              if (result.hasException) {
                return SizedBox(
                  height: 120,
                  child: Column(
                    children: [
                      _headerComponent(theme, refetch),
                       Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                      Expanded(child: Center(child: Text('Error al cargar la información'))),
                    ],
                  ),
                );
              }
              if (result.isLoading) {
                return SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final gastos =  VTareaGasto.fromJsonList(result.data?['VTareaGastosByTarea'] ?? []);
              
              _totalGastos = gastos.fold(0.0, (sum, gasto) => sum + gasto.costo);
            
              if(gastos.isEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _headerComponent(theme, refetch),
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
                  ],
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _headerComponent(theme, refetch),
                  Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                  for (var gasto in gastos) 
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: Mutation(
                          options: MutationOptions(
                            document: gql(TipoGastoQueries.delete),
                            onCompleted: (data) {
                              if(data == null) return;
                              refreshGastoTotal();
                            },
                          ),
                          builder: (RunMutation runMutation, QueryResult? mutationResult) {
                            return PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'editar') {
                                  _onEditarGasto(gasto.toTareaGasto(), refetch);
                                } else if (value == 'eliminar') {
                                  _onEliminarGasto(gasto.toTareaGasto(), runMutation, refetch);
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'editar',
                                  child: Text('Editar'),
                                ),
                                PopupMenuItem(
                                  value: 'eliminar',
                                  child: Text('Eliminar'),
                                ),
                              ],
                            );
                          }
                        ),
                        title: Text(
                          '${gasto.code} ${gasto.tipoGastoNombre}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          gasto.tipoGastoDescripcion,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        trailing: Text(
                          _currencyFormat.format(gasto.tipoGastoCosto),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,  
                          ),
                        ),
                      ),
                    ),
                    Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total Gastos: ',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            _currencyFormat.format(_totalGastos),
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                ]
              );
            }
          ),
          Divider(thickness: 1.0, height: 1, color: theme.colorScheme.outline),
        ],
      ),
    );
  }

  Widget _headerComponent(ThemeData theme, refetch) {
    return Container(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 26.0, right: 26.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Gastos',
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            SizedBox(width: 10.0),
            ElevatedButton.icon(
              onPressed: ()=>_onAgregarGasto(refetch),
              label: SizedBox(
                width: 70,
                child: Center(child: Text('Gasto'))
              ),
              icon: Icon(Icons.add),
            )
          ],
        ),
      );
  }

  void _onEditarGasto(TareaGasto gasto, refetch) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EdicionGastoDialog(
          client: widget.client,
          titulo: 'Editar Gasto',
          tarea: widget.tarea,
          gasto: gasto,
          onChanged: () {
            refetch!();
          },
        );
      },
    );
  }

  void _onEliminarGasto(TareaGasto gasto, runMutation, refetch) {
    DialogAsk.confirm(
      context: context,
      title: "Eliminar Gasto",
      content: Text('¿Deseas eliminar este gasto?'),
      onYes: () => _eliminarGasto(gasto, runMutation, refetch),
      onNo: () => {},
    );
  }

  void _eliminarGasto(TareaGasto gasto, runMutation, refetch) {
    runMutation({
      'id': gasto.idtareaGasto,
    });
    refetch!();
  }

  void _onAgregarGasto(refetch) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EdicionGastoDialog(
          client: widget.client,
          titulo: 'Agregar Gasto',
          tarea: widget.tarea,
          gasto: TareaGasto.empty(widget.tarea),
          onChanged: () {
            refetch!();
          },
        );
      },
    );
  }

  void refreshGastoTotal() async {
    await Future.delayed(Duration(seconds: 1));
    widget.getTotalGasto(_totalGastos);
  }

}