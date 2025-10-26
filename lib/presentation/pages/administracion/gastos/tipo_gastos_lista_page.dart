import 'package:constructoria/domain/entities/tipo_gasto.dart';
import 'package:constructoria/domain/repositories/tipo_gasto_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class TipoGastosListaPage extends StatefulWidget {
  const TipoGastosListaPage({super.key, required this.onAdd, required this.onEdit});

  final Function(dynamic refetch) onAdd;
  final Function(TipoGasto gasto, dynamic refetch) onEdit;

  @override
  State<TipoGastosListaPage> createState() => _TipoGastosListaPageState();
}

class _TipoGastosListaPageState extends State<TipoGastosListaPage> {
  final _numberFormatter = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Query(
      options: QueryOptions(
        document: gql(TipoGastoQueries.getAll),
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
        final gastos = TipoGasto.fromJsonList(result.data?['tipoGastos'] ?? []);
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
                        Icons.monetization_on,
                        color: theme.colorScheme.inverseSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tipos de Gasto',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.inverseSurface,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () => widget.onAdd(refetch),
                    label: Text('Agregar Tipo de Gasto'),
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
                      'Costo',
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
                itemCount: gastos.length,
                itemBuilder: (context, index) {
                  final gasto = gastos[index];
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
                      onTap: () => widget.onEdit(gasto, refetch),
                      title: Row(
                        children: [
                          Icon(Icons.monetization_on, color: theme.colorScheme.primary, size: 12),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 100,
                            child: Text(
                              gasto.codigo,
                            ),
                          ),
                          Expanded(
                            flex: 250,
                            child: Text(
                              gasto.nombre,
                            ),
                          ),
                          Expanded(
                            flex: 300,
                            child: Text(gasto.descripcion),
                          ),
                          Expanded(
                            flex: 150,
                            child: Text(_numberFormatter.format(gasto.costo)),
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