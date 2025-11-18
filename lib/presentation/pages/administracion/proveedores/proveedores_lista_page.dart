import 'package:constructoria/domain/entities/proveedor.dart';
import 'package:constructoria/domain/repositories/proveedor_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProveedoresListaPage extends StatefulWidget {
  const ProveedoresListaPage({super.key, required this.onAddProveedor, required this.onEditProveedor});

  final Function(dynamic refetch) onAddProveedor;
  final Function(Proveedor proveedor, dynamic refetch) onEditProveedor;

  @override
  State<ProveedoresListaPage> createState() => _ProveedoresListaPageState();
}

class _ProveedoresListaPageState extends State<ProveedoresListaPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Query(
      options: QueryOptions(
        document: gql(ProveedorQueries.proveedores),
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
        final proveedores = Proveedor.fromJsonList(result.data?['proveedores'] ?? []);
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
                        Icons.business,
                        color: theme.colorScheme.inverseSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Proveedores',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.inverseSurface,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () => widget.onAddProveedor(refetch),
                    icon: const Icon(Icons.add),
                    label: const Text('Proveedor'),
                  ),
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
                    flex: 200,
                    child: Text('Razón social', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 120,
                    child: Text('RFC', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 100,
                    child: Text('Tipo', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 100,
                    child: Text('Cuenta', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 80,
                    child: Text('Moneda', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 120,
                    child: Text('Contacto', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 100,
                    child: Text('Teléfono', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 130,
                    child: Text('Correo', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 100,
                    child: Text('Banco', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 60,
                    child: Text('Activo', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: proveedores.length,
                itemBuilder: (context, index) {
                  final proveedor = proveedores[index];
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
                      onTap: () => widget.onEditProveedor(proveedor, refetch),
                      title: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.outline,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            flex: 200,
                            child: Text(proveedor.razonSocial),
                          ),
                          Expanded(
                            flex: 120,
                            child: Text(proveedor.rfc),
                          ),
                          Expanded(
                            flex: 100,
                            child: Text(proveedor.tipoPersona?.descripcion ?? ''),
                          ),
                          Expanded(
                            flex: 100,
                            child: Text(proveedor.tipoCuenta?.descripcion ?? ''),
                          ),
                          Expanded(
                            flex: 80,
                            child: Text(proveedor.moneda?.clave ?? ''),
                          ),
                          Expanded(
                            flex: 120,
                            child: Text(proveedor.contactoNombre),
                          ),
                          Expanded(
                            flex: 100,
                            child: Text(proveedor.telefono),
                          ),
                          Expanded(
                            flex: 130,
                            child: Text(proveedor.correoElectronico),
                          ),
                          Expanded(
                            flex: 100,
                            child: Text(proveedor.banco),
                          ),
                          Expanded(
                            flex: 60,
                            child: Icon(
                              proveedor.activo ? Icons.check_circle : Icons.cancel,
                              color: proveedor.activo ? Colors.green : Colors.red,
                              size: 20,
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
      },
    );
  }
}
