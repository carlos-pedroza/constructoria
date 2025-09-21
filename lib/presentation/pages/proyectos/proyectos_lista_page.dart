import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:constructoria/domain/repositories/proyecto_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class ProyectosListaPage extends StatefulWidget {
  const ProyectosListaPage({super.key, required this.client, required this.onAvances, required this.onEditarTareas, required this.onEditProyecto});

  final GraphQLClient client;
  final Function(Proyecto proyecto) onAvances;
  final Function(Proyecto proyecto) onEditarTareas;
  final Function(Proyecto proyecto) onEditProyecto;

  @override
  State<ProyectosListaPage> createState() => _ProyectosListaPageState();
}

class _ProyectosListaPageState extends State<ProyectosListaPage> {
  final _formatDate = DateFormat('dd/MM/yyyy');
  final _formatCurrency = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Query(
        options: QueryOptions(
          document: gql(ProyectoQueries.getAllProyectos),
          fetchPolicy: FetchPolicy.noCache,
        ),
        builder: (QueryResult result, {Refetch? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator(color: theme.colorScheme.surfaceContainerLowest),);
          }
      
          if (result.hasException) {
            return Center(child: Text('Error: ${result.exception.toString()}'));
          }
      
          final List<Proyecto> proyectos = (result.data?['getAllProyectos'] as List)
              .map((e) => Proyecto.fromJson(e))
              .toList();
      
          return Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.work,
                          color: theme.colorScheme.inverseSurface,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Proyectos',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: _onAddProyecto,
                      icon: Icon(Icons.add),
                      label: Text('Proyecto'),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  border: Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 40),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            flex: 95,
                            child: Text(
                              'Clave',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 150,
                            child: Text(
                              'Nombre',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            flex: 95,
                            child: Text(
                              'Fecha inicio',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 95,
                            child: Text(
                              'Presupuesto',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 95,
                            child: Text(
                              'Estado',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    SizedBox(width: 200),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: proyectos.length,
                  itemBuilder: (context, index) {
                    final proyecto = proyectos[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceBright,
                        border: Border(
                          bottom: BorderSide(
                            color: theme.colorScheme.outline,
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListTile(
                        onTap: () => _onEditProyecto(proyecto),
                        leading: Icon(Icons.work, color: theme.colorScheme.outline, size: 18),
                        title: Row(
                          children: [
                            SizedBox(width: 10),
                            Expanded(
                              flex: 120,
                              child: Text(proyecto.claveProyecto),
                            ),
                            Expanded(
                              flex: 200,
                              child: Text(proyecto.nombre),
                            ),
                            Expanded(
                              flex: 100,
                              child: Text(_formatDate.format(proyecto.fechaInicio)),
                            ),
                            Expanded(
                              flex: 100,
                              child: Text(
                                _formatCurrency.format(proyecto.presupuesto),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              flex: 100,
                              child: Text(
                                proyecto.estado??'-',
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton.icon(
                              onPressed: () => widget.onAvances(proyecto),
                              icon: Icon(Icons.timeline),
                              label: Text('Avances'),
                            ),
                            SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: ()=>_onEditarTareas(proyecto),
                              icon: Icon(Icons.task),
                              label: Text('Editar tareas'),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.edit, color: theme.colorScheme.primary, size: 18),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
  
  void _onAddProyecto() {
    widget.onEditProyecto(Proyecto.empty());
  }

  void _onEditarTareas(Proyecto proyecto) {
    widget.onEditarTareas(proyecto);
  }
  
  void _onEditProyecto(Proyecto proyecto) {
    widget.onEditProyecto(proyecto);
  }
}
