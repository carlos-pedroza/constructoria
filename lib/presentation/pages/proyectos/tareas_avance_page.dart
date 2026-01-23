import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:constructoria/domain/entities/proyecto_mano_obra.dart';
import 'package:constructoria/domain/entities/resumen_proyecto.dart';
import 'package:constructoria/domain/entities/v_tarea.dart';
import 'package:constructoria/domain/entities/v_tarea_gasto.dart';
import 'package:constructoria/domain/entities/v_tarea_material.dart';
import 'package:constructoria/domain/repositories/proyecto_queries.dart';
import 'package:constructoria/domain/repositories/tarea_comentario_queries.dart';
import 'package:constructoria/domain/repositories/tarea_material_queries.dart';
import 'package:constructoria/domain/repositories/tarea_queries.dart';
import 'package:constructoria/domain/repositories/v_tarea_gasto.queries.dart';
import 'package:constructoria/presentation/pages/proyectos/informacion_tarea_page.dart';
import 'package:constructoria/presentation/pages/proyectos/tarea_comentarios_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class TareasAvancePage extends StatefulWidget {
  const TareasAvancePage({super.key, required this.client, required this.proyecto, required this.onBack});

  final GraphQLClient client;
  final Proyecto proyecto;
  final Function() onBack;

  @override
  State<TareasAvancePage> createState() => _TareasAvancePageState();
}

class _TareasAvancePageState extends State<TareasAvancePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: widget.onBack,
                    icon: Icon(Icons.list_alt_rounded, size: 30),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.work_history,
                  color: theme.colorScheme.inverseSurface,
                  size: 40,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ListTile(
                    title: Text(
                      widget.proyecto.nombre,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.inverseSurface,
                      ),
                    ),
                    subtitle: Text(
                      'Avance de Tareas',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(width: 20),
                IconButton(
                  onPressed: widget.onBack, 
                  icon: Icon(Icons.close),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Expanded(
            child: Query(
              options: QueryOptions(
                document: gql(TareaQueries.vTareas),
                variables: {
                  'idproyecto': widget.proyecto.idproyecto,
                },
                fetchPolicy: FetchPolicy.networkOnly,
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (result.hasException) {
                  return Center(child: Text('Error al cargar las tareas'));
                }
                final tareas = VTarea.fromJsonList(result.data?['vTareas'] as List);
               
                return Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                        ),
                        child: ProyectoResumenAvanceComponent(proyecto: widget.proyecto),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            border: Border(
                              top: BorderSide(
                                color: theme.colorScheme.inverseSurface,
                                width: 1,
                              ),
                            ),
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: tareas.length,
                            itemBuilder: (context, index) {
                              final tarea = tareas[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                child: _TareaCard(
                                  client: widget.client,
                                  tarea: tarea,
                                  gastos: {'Transporte material': 500, 'Comida personal': 300},
                                  materiales: {'Cemento (5 sacos)': 1200, 'Varilla (20 pzas)': 2000},
                                  refetch: refetch,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

class _TareaCard extends StatefulWidget {
  const _TareaCard({
    required this.client,
    required this.tarea,
    required this.gastos,
    required this.materiales,
    required this.refetch,
  });

  final GraphQLClient client;
  final VTarea tarea;
  final Map<String, int> gastos;
  final Map<String, int> materiales;
  final refetch;

  @override
  State<_TareaCard> createState() => _TareaCardState();
}

class _TareaCardState extends State<_TareaCard> {
  final _currencyFormatter = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text('${widget.tarea.orden}:', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                    SizedBox(width: 8),
                    Text(widget.tarea.tareaDescripcion, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                )),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(widget.tarea.estadoTareaNombre, style: TextStyle(fontSize: 12)),
              ),
              Query(
                options: QueryOptions(
                  document: gql(TareaComentarioQueries.tieneComentarios),
                  variables: {
                    'idtarea': widget.tarea.idtarea,
                  },
                  fetchPolicy: FetchPolicy.noCache,
                ),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return SizedBox();
                  }
                  if (result.hasException) {
                    return SizedBox();
                  }
                  final tieneComentarios = result.data?['existeTareaComentarioPorTarea'] as bool;

                  return IconButton(
                    onPressed: _onTareaComment, 
                    icon: Icon(Icons.comment, size: 20, color: tieneComentarios ? Colors.blue : theme.colorScheme.onSurfaceVariant),
                  );
                }
              )
            ],
          ),
          Row(
            children: [
              Expanded(child: Text('Responsable: ${widget.tarea.empleadoNombre} ${widget.tarea.apellidoPaterno} ${widget.tarea.apellidoMaterno}', style: Theme.of(context).textTheme.bodyMedium)),
              SizedBox(width: 8),
              IconButton(
                onPressed: _onEditProgress,
                icon: Icon(Icons.visibility, size: 20, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: widget.tarea.avance,
            backgroundColor: Colors.blue[50],
            color: Colors.blue,
            minHeight: 6,
          ),
          const SizedBox(height: 4),
          Text('Avance: ${(widget.tarea.avance * 100).toInt()}%', style: Theme.of(context).textTheme.bodySmall),
          const Divider(height: 20),
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
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator())
                );
              }
              if (result.hasException) {
                return SizedBox(
                  height: 100,
                  child: Center(child: Text('Error al cargar los gastos'))
                );
              }
              final gastos = VTareaGasto.fromJsonList(result.data?['VTareaGastosByTarea'] as List);

              final totalGastos = gastos.fold(0.0, (sum, gasto) => sum + gasto.tipoGastoCosto);

              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                      child: Text('Gastos', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Divider(thickness: 3, height: 16, color: theme.colorScheme.surfaceContainerLowest),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 4.0, bottom: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var gasto in gastos) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${gasto.tipoGastoCodigo}  ${gasto.tipoGastoNombre}'),
                                Text(_currencyFormatter.format(gasto.tipoGastoCosto)),
                              ],
                            ),
                            SizedBox(height: 4),
                            Divider(thickness: 1, height: 1, color: theme.colorScheme.outlineVariant),
                          ],
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(_currencyFormatter.format(totalGastos), style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
          const SizedBox(height: 8),
          Query(
            options: QueryOptions(
              document: gql(TareaMaterialQueries.getByTarea),
              variables: {
                'idtarea': widget.tarea.idtarea,
              },
              fetchPolicy: FetchPolicy.noCache,
            ),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator())
                );
              }
              if (result.hasException) {
                return SizedBox(
                  height: 100,
                  child: Center(child: Text('Error al cargar los materiales'))
                );
              }
              final materiales = VTareaMaterial.fromJsonList(result.data?['vTareaMaterialByTarea'] as List);

              final totalMateriales = materiales.fold(0.0, (sum, material) => sum + material.costo);

              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                      child: Text('Materiales', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Divider(thickness: 3, height: 16, color: theme.colorScheme.surfaceContainerLowest),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 4.0, bottom: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var material in materiales) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${material.codigo} ${material.descripcion}  Cantidad: ${material.cantidad}'),
                                Text(_currencyFormatter.format(material.costo)),
                              ],
                            ),
                            SizedBox(height: 4),
                            Divider(thickness: 1, height: 1, color: theme.colorScheme.outlineVariant),
                          ],
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(_currencyFormatter.format(totalMateriales), style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ]
                ),
              );
            }
          ),
          SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Mano de obra:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_currencyFormatter.format(widget.tarea.totalManoObraAvance), style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _onEditProgress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InformacionTareaPage(
          client: widget.client,
          tarea: widget.tarea,
          refetch: widget.refetch,
        ),
      ),
    );
  }

  void _onTareaComment() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TareaComentariosPage(
          client: widget.client,
          tarea: widget.tarea,
          refetchTareas: widget.refetch,
        ),
      ),
    );
  }
  
  void refreshGastoTotal() {}
}

class ProyectoResumenAvanceComponent extends StatefulWidget {
  const ProyectoResumenAvanceComponent({super.key, required this.proyecto});

  final Proyecto proyecto;

  @override
  State<ProyectoResumenAvanceComponent> createState() => _ProyectoResumenAvanceComponentState();
}

class _ProyectoResumenAvanceComponentState extends State<ProyectoResumenAvanceComponent> {
  final _currencyFormatter = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
  final _percentFormatter = NumberFormat.percentPattern('es_MX');


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Query(
      options: QueryOptions(
        document: gql(ProyectoQueries.getResumenProyecto),
        variables: {
          'idproyecto': widget.proyecto.idproyecto,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
      builder:(result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 100, child: WaitTool()),
            ],
          );  
        }
        if (result.hasException) {
          return Center(child: Text('Error al cargar el resumen del proyecto'));
        }
        final resumen = ResumenProyecto.fromJson(result.data?['getResumenProyecto']);
        final _subTotal = resumen.totalGasto + resumen.totalMaterial;

        return Column(
          children: [
            Row(
              children: [
                Text(
                  _percentFormatter.format(resumen.porcentajeAvance),  
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.inverseSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text('Gastos: ${_currencyFormatter.format(resumen.totalGasto)}', style: theme.textTheme.titleMedium),
                const SizedBox(width: 30),
                Text('Materiales: ${_currencyFormatter.format(resumen.totalMaterial)}', style: theme.textTheme.titleMedium),
                const SizedBox(width: 30),
                TotalManoObraComponent(
                  idproyecto: widget.proyecto.idproyecto!,
                  subTotal: _subTotal,
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: resumen.porcentajeAvance, // Cambia por el avance global
              backgroundColor: Colors.blue[50],
              color: Colors.blue,
              minHeight: 10,
            ),
          ],
        );
      }
    );
  }
}

class TotalManoObraComponent extends StatelessWidget {
  TotalManoObraComponent({super.key, required this.idproyecto, required this.subTotal});

  final int idproyecto;
  final double subTotal;

  final _currencyFormatter = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Query(
      options: QueryOptions(
        document: gql(ProyectoQueries.proyectoManoObraSum),
        variables: {
          'idproyecto': idproyecto,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
      builder:(result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Container();
        }
        if (result.hasException) {
          return Center(child: Text('Error al cargar el total de mano de obra'));
        }

        final proyectoManoObra = ProyectoManoObra.fromJsonList(result.data?['proyectoManoObraSum'] as List);
        final total = subTotal + (proyectoManoObra?.totalManoObraAvance ?? 0.0);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
              Text('Mano de obra: ${_currencyFormatter.format(proyectoManoObra?.totalManoObraAvance ?? 0.0)}', style: theme.textTheme.titleMedium),
              const SizedBox(width: 30),
              Text('Total: ${_currencyFormatter.format(total)}', style: theme.textTheme.titleMedium),
          ],
        );
      }
    );
  }
}