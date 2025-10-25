import 'package:constructoria/domain/entities/material_entidad.dart';
import 'package:constructoria/domain/repositories/material_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class MaterialesListaPage extends StatefulWidget {
  const MaterialesListaPage({super.key, required this.onAdd, required this.onEdit});

  final Function(dynamic refetch) onAdd;
  final Function(MaterialEntidad material, dynamic refetch) onEdit;

  @override
  State<MaterialesListaPage> createState() => _MaterialesListaPageState();
}

class _MaterialesListaPageState extends State<MaterialesListaPage> {
  final _numberFormatter = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Query(
      options: QueryOptions(
        document: gql(MaterialQueries.getAll),
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
        final materiales = MaterialEntidad.fromJsonList(result.data?['materials'] ?? []);
        
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
                        Icons.inventory,
                        color: theme.colorScheme.inverseSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Materiales',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.inverseSurface,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () => widget.onAdd(refetch),
                    label: Text('Agregar Material'),
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
                    flex: 100,
                    child: Text(
                      'Código',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 250,
                    child: Text(
                      'Nombre',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 300,
                    child: Text(
                      'descripcion',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 150,
                    child: Text(
                      'Costo sugerido',
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
                itemCount: materiales.length,
                itemBuilder: (context, index) {
                  final material = materiales[index];
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
                      onTap: () => widget.onEdit(material, refetch),
                      title: Row(
                        children: [
                          Icon(Icons.circle, size: 12, color: theme.colorScheme.primary),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 100,
                            child: Text(
                              material.codigo,
                            ),
                          ),
                          Expanded(
                            flex: 250,
                            child: Text(
                              material.nombre,
                            ),
                          ),
                          Expanded(
                            flex: 300,
                            child: Text(material.descripcion),
                          ),
                          Expanded(
                            flex: 150,
                            child: Text(_numberFormatter.format(material.costo)),
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