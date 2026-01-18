import 'package:constructoria/cors/constants.dart';
import 'package:constructoria/cors/dialog_Ask.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:constructoria/domain/repositories/proyecto_queries.dart';
import 'package:url_launcher/url_launcher.dart';

class InformesPage extends StatefulWidget {
  const InformesPage({super.key, required this.client});

  final GraphQLClient client;

  @override
  State<InformesPage> createState() => _InformesPageState();
}

class _InformesPageState extends State<InformesPage> {
  final _puestoController = TextEditingController();
  final _filtroExtraController = TextEditingController();
  final _filtroProveedorController = TextEditingController();
  var _proyectoSeleccionado = 0;
  var _showWorkers = false;
  var _showProviders = false;
  var _showProjectsProgress = false;
  var _showProjectsExpenses = false;
  var _showProjectsMaterials = false;
  var _showPayments = false;
  var _showPaymentsHistory = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Container(
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
                        Icons.receipt_long,
                        color: theme.colorScheme.inverseSurface,
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Text(
                          'Informes',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Spacer()
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [    
                  TitleBarComponent(icon: Icons.admin_panel_settings,title: 'Administración'),     
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.people,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Trabajadores por puesto y habilidad',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Listado de trabajadores filtrados por puesto o habilidad',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        !_showWorkers ? Icons.expand_more_rounded : Icons.expand_less_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 40,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () {
                        setState(() {
                          _showWorkers = !_showWorkers;
                        });
                      },
                    ),
                  ),
                  if(_showWorkers) ...[
                    Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Buscar trabajador', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _puestoController,
                            decoration: InputDecoration(
                              labelText: 'Puesto',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _puestoController.clear();
                                }, 
                                icon: Icon(Icons.clear),
                              )
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _filtroExtraController,
                            decoration: InputDecoration(
                              labelText: 'Otra información del trabajador',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _filtroExtraController.clear();
                                }, 
                                icon: Icon(Icons.clear),
                              )
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: _onTapTrabajadores,
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Abrir'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.paid,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Proveedores por tipo de servicio',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Listado de proveedores filtrados por tipo de servicio',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        _showProviders ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 40,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () {
                        setState(() {
                          _showProviders = !_showProviders;
                        });
                      },
                    ),
                  ),
                  if(_showProviders) ...[
                    Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Buscar proveedor', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _filtroProveedorController,
                            decoration: InputDecoration(
                              labelText: 'Filtro',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _filtroProveedorController.clear();
                                }, 
                                icon: Icon(Icons.clear),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: _onTapProveedores,
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Abrir'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  TitleBarComponent(icon: Icons.work, title: 'Proyectos'),     
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.percent_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Avance en proyectos',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Informe del avance de los proyectos en curso',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        _showProjectsProgress ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 40,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: _onTapAvanceProyectos,
                    ),
                  ),
                  if(_showProjectsProgress) ...[
                    Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Proyecto', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 16),
                          Query(
                            options: QueryOptions(document: gql(ProyectoQueries.getAllProyectos)),
                            builder: (result, {fetchMore, refetch}) {
                              if (result.isLoading) {
                                return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                              }
                              if (result.hasException) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text('Error al cargar proyectos'),
                                );
                              }
                              var proyectos = result.data?['getAllProyectos'] ?? [];
                              proyectos.removeWhere((p) => p['idproyecto'] == 0);
                              proyectos.insert(0, {'idproyecto': 0, 'nombre': 'Todos los proyectos'});
                              return DropdownButtonFormField<int>(
                                initialValue: _proyectoSeleccionado,
                                decoration: const InputDecoration(
                                  labelText: 'Proyecto',
                                  border: OutlineInputBorder(),
                                ),
                                items: [for (var p in proyectos) DropdownMenuItem(value: p['idproyecto'], child: Text(p['nombre']))],
                                onChanged: (val) {
                                  setState(() {
                                    _proyectoSeleccionado = val!;
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: _onTapAvanceProyectosOpen,
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Abrir'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.paid,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Gastos por proyecto',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Informe de gastos asociados a cada proyecto',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        _showProjectsExpenses ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 40,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: _onTapGastosProyectos,
                    ),
                  ),
                  if(_showProjectsExpenses) ...[
                    Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Proyecto', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 16),
                          Query(
                            options: QueryOptions(document: gql(ProyectoQueries.getAllProyectos)),
                            builder: (result, {fetchMore, refetch}) {
                              if (result.isLoading) {
                                return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                              }
                              if (result.hasException) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text('Error al cargar proyectos'),
                                );
                              }
                              var proyectos = result.data?['getAllProyectos'] ?? [];
                              proyectos.removeWhere((p) => p['idproyecto'] == 0);
                              proyectos.insert(0, {'idproyecto': 0, 'nombre': 'Todos los proyectos'});
                              return DropdownButtonFormField<int>(
                                initialValue: _proyectoSeleccionado,
                                decoration: const InputDecoration(
                                  labelText: 'Proyecto',
                                  border: OutlineInputBorder(),
                                ),
                                items: [for (var p in proyectos) DropdownMenuItem(value: p['idproyecto'], child: Text(p['nombre']))],
                                onChanged: (val) {
                                  setState(() {
                                    _proyectoSeleccionado = val!;
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: _onTapGastosProyectosOpen,
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Abrir'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.request_page_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Materiales por proyecto',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Informe de materiales utilizados en cada proyectoß',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        _showProjectsMaterials ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 40,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: _onTapMaterialesProyectos,
                    ),
                  ),
                  if(_showProjectsMaterials) ...[
                    Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Proyecto', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 16),
                          Query(
                            options: QueryOptions(document: gql(ProyectoQueries.getAllProyectos)),
                            builder: (result, {fetchMore, refetch}) {
                              if (result.isLoading) {
                                return SizedBox(width: 100, child: Center(child: CircularProgressIndicator()));
                              }
                              if (result.hasException) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text('Error al cargar proyectos'),
                                );
                              }
                              var proyectos = result.data?['getAllProyectos'] ?? [];
                              proyectos.removeWhere((p) => p['idproyecto'] == 0);
                              proyectos.insert(0, {'idproyecto': 0, 'nombre': 'Todos los proyectos'});
                              return DropdownButtonFormField<int>(
                                initialValue: _proyectoSeleccionado,
                                decoration: const InputDecoration(
                                  labelText: 'Proyecto',
                                  border: OutlineInputBorder(),
                                ),
                                items: [for (var p in proyectos) DropdownMenuItem(value: p['idproyecto'], child: Text(p['nombre']))],
                                onChanged: (val) {
                                  setState(() {
                                    _proyectoSeleccionado = val!;
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: _onTapMaterialesProyectosOpen,
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Abrir'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  TitleBarComponent(icon: Icons.work, title: 'Pagos'),   
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.paid,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Pagos por procesar',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Informe de los pagos pendientes por procesar',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        _showPayments ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 40,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: _onConstruction,
                    ),
                  ),
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.history,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                      title: Text(
                        'Historial de pagos a proveedores y empleados',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Informe de los pagos realizados a proveedores y empleados',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        _showPaymentsHistory ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 40,
                      ),
                      tileColor: theme.colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: _onConstruction,
                    ),
                  ),
                  Divider(thickness: 1, height: 1, color: theme.colorScheme.outline),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapTrabajadores() async {
    final urlInforme = await Constants.informeTrabajadoresUrl(
      puesto: _puestoController.text,
      filtroExtra: _filtroExtraController.text,
    );
    final uri = Uri.parse(urlInforme);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      // Maneja el error
    }
  }

  void _onTapProveedores() async {
    final urlInforme = await Constants.informeProveedoresUrl(
      filtro: _filtroProveedorController.text,
    );
    final uri = Uri.parse(urlInforme);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      // Maneja el error
    }
  }

  void _onTapAvanceProyectos() {
    setState(() {
      _showProjectsProgress = !_showProjectsProgress;
    });
  }

  void _onTapAvanceProyectosOpen() async {
    final urlInforme = await Constants.informeProyectosAvanceUrl(
      idproyecto: _proyectoSeleccionado,
    );
    final uri = Uri.parse(urlInforme);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      // Maneja el error
    }
  }

  void _onTapGastosProyectos() {
    setState(() {
      _showProjectsExpenses = !_showProjectsExpenses;
    });
  }

  void _onTapGastosProyectosOpen() async {
    final urlInforme = await Constants.informeProyectosGastosUrl(
      idproyecto: _proyectoSeleccionado,
    );
    final uri = Uri.parse(urlInforme);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      // Maneja el error
    }
  }

  void _onTapMaterialesProyectos() {
    setState(() {
      _showProjectsMaterials = !_showProjectsMaterials;
    });
  }

  void _onTapMaterialesProyectosOpen() async {
    final urlInforme = await Constants.informeProyectosMaterialesUrl(
      idproyecto: _proyectoSeleccionado,
    );
    final uri = Uri.parse(urlInforme);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      // Maneja el error
    }
  }

  void _onConstruction() {
    DialogAsk.simple(
      context: context,
      title: 'En construcción',
      content: Text('Esta funcionalidad está en construcción.'),
      onOk: () {},
    );
  }
}

class TitleBarComponent extends StatelessWidget {
  const TitleBarComponent({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.7),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.onPrimary, size: 26),
          const SizedBox(width: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}