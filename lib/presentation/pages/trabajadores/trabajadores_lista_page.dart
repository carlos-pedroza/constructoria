import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TrabajadoresListaPage extends StatefulWidget {
  const TrabajadoresListaPage({super.key, required this.onAddEmpleado, required this.onEditEmpleado});

  final Function(dynamic refetch) onAddEmpleado;
  final Function(Empleado empleado,dynamic refetch) onEditEmpleado;

  @override
  State<TrabajadoresListaPage> createState() => _TrabajadoresListaPageState();
}

class _TrabajadoresListaPageState extends State<TrabajadoresListaPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Query(
      options: QueryOptions(
        document: gql(EmpleadoQueries.getAllEmpleados),
        fetchPolicy: FetchPolicy.noCache,
      ),
      builder: (QueryResult result, {Refetch? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Center(child: Text('Error: ${result.exception.toString()}'));
        }
        if (result.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.surfaceBright,
            ),
          );
        }
        final trabajadores = Empleado.fromJsonList(result.data?['empleados'] ?? []);
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
                        Icons.people,
                        color: theme.colorScheme.inverseSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Trabajadores',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.inverseSurface,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () => widget.onAddEmpleado(refetch),
                    label: Text('Trabajador'),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
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
                    flex: 200,
                    child: Text(
                      'Nombre',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 150,
                    child: Text(
                      'Puesto',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 80,
                    child: Text(
                      'Teléfono',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 130,
                    child: Text(
                      'Correo',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 140,
                    child: Text(
                      'CURP',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 80,
                    child: Text(
                      'Costo por hora',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trabajadores.length,
                itemBuilder: (context, index) {
                  final trabajador = trabajadores[index];
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
                      onTap: () => widget.onEditEmpleado(trabajador, refetch),
                      title: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 200,
                            child: Text(
                              '${trabajador.nombre} ${trabajador.apellidoPaterno} ${trabajador.apellidoMaterno}',
                            ),
                          ),
                          Expanded(
                            flex: 150,
                            child: Text(trabajador.puesto),
                          ),
                          Expanded(
                            flex: 80,
                            child: Text(trabajador.telefono),
                          ),
                          Expanded(
                            flex: 130,
                            child: Text(trabajador.correo),
                          ),
                          Expanded(
                            flex: 150,
                            child: Text(trabajador.curp),
                          ),
                          Expanded(
                            flex: 80,
                            child: Text(
                              trabajador.costoPorHora.toString(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    );
  }
}