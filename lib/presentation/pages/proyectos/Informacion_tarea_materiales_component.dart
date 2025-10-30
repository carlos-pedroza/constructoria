import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:constructoria/domain/entities/tarea.dart';
import 'package:constructoria/domain/entities/tarea_material.dart';
import 'package:constructoria/domain/entities/v_tarea_material.dart';
import 'package:constructoria/domain/repositories/tarea_material_queries.dart';
import 'package:constructoria/domain/repositories/tipo_gasto_queries.dart';
import 'package:constructoria/presentation/pages/proyectos/edicion_material_dialog.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';


class InformacionTareaMaterialesComponent extends StatefulWidget {
  const InformacionTareaMaterialesComponent({super.key, required this.client, required this.tarea, required this.changeTotalMateriales});

  final GraphQLClient client;
  final Tarea tarea;
  final void Function(double total) changeTotalMateriales;

  @override
  State<InformacionTareaMaterialesComponent> createState() => _InformacionTareaMaterialesComponentState();
}

class _InformacionTareaMaterialesComponentState extends State<InformacionTareaMaterialesComponent> {
  final _currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
  var _totalMateriales = 0.0;

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
              document: gql(TareaMaterialQueries.getByTarea),
              variables: {
                'idtarea': widget.tarea.idtarea,
              },
              fetchPolicy: FetchPolicy.noCache,
              onComplete: (data) {
                refresh();
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
              final materiales =  VTareaMaterial.fromJsonList(result.data?['vTareaMaterialByTarea'] ?? []);
              
              _totalMateriales = materiales.fold(0.0, (sum, gasto) => sum + gasto.costo);
            
              if(materiales.isEmpty) {
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
                  for (var material in materiales) 
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
                              refresh();
                            },
                          ),
                          builder: (RunMutation runMutation, QueryResult? mutationResult) {
                            return PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'editar') {
                                  _onEditar(material.toTareaMaterial(), refetch);
                                } else if (value == 'eliminar') {
                                  _onEliminar(material.toTareaMaterial(), runMutation, refetch);
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
                          '${material.codigo} ${material.nombre}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          material.descripcion,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        trailing: Text(
                          _currencyFormat.format(material.costo),
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
                            'Total Materiales: ',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            _currencyFormat.format(_totalMateriales),
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
              'Materiales',
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            SizedBox(width: 10.0),
            ElevatedButton.icon(
              onPressed: ()=>_onAgregar(refetch),
              label: SizedBox(
                width: 70,
                child: Center(child: Text('Material'))
              ),
              icon: Icon(Icons.add),
            )
          ],
        ),
      );
  }

  void _onEditar(TareaMaterial material, refetch) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EdicionMaterialDialog(
          client: widget.client,
          titulo: 'Editar Material',
          tarea: widget.tarea,
          material: material,
          onChanged: () {
            refetch!();
          },
        );
      },
    );
  }

  void _onEliminar(TareaMaterial material, runMutation, refetch) {
    DialogAsk.confirm(
      context: context,
      title: "Eliminar Material",
      content: Text('¿Deseas eliminar este material?'),
      onYes: () => _eliminar(material, runMutation, refetch),
      onNo: () => {},
    );
  }

  void _eliminar(TareaMaterial material, runMutation, refetch) {
    runMutation({
      'id': material.idtareaMaterial,
    });
    refetch!();
  }

  void _onAgregar(refetch) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EdicionMaterialDialog(
          client: widget.client,
          titulo: 'Agregar Material',
          tarea: widget.tarea,
          material: TareaMaterial.empty(widget.tarea),
          onChanged: () {
            refetch!();
          },
        );
      },
    );
  }

  void refresh() async {
    await Future.delayed(Duration(seconds: 1));
    widget.changeTotalMateriales(_totalMateriales);
  }

}