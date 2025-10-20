import 'package:constructoria/presentation/pages/administracion/gastos/tipo_gastos_page.dart';
import 'package:constructoria/presentation/pages/administracion/trabajadores/trabajadores_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AdministracionPage extends StatefulWidget {
  const AdministracionPage({super.key, required this.client});

  final GraphQLClient client;

  @override
  State<AdministracionPage> createState() => _AdministracionPageState();
}

class _AdministracionPageState extends State<AdministracionPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLow),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceBright,
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
                        Icons.admin_panel_settings,
                        color: theme.colorScheme.inverseSurface,
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Text(
                          'Administración',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.people,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Gestión de Trabajadores',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Agregar, editar o eliminar trabajadores',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: _onTapTrabajadores,
                    ),
                  ),
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.paid,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Información de Gastos',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Información y gestión de gastos',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: _onTapTipoGastos,
                    ),
                  ),
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.request_page_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Gestión deMateriales',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Gestión de materiales y suministros',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/administracion/trabajadores');
                      },
                    ),
                  ),
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.inventory,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Gestión de Proveedores',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Gestión de proveedores y contratistas',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/administracion/trabajadores');
                      },
                    ),
                  ),
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _onTapTrabajadores() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrabajadoresPage(client: widget.client),
      ),
    );
  }

  void _onTapTipoGastos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TipoGastosPage(client: widget.client),
      ),
    );
  }
}