import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:constructoria/presentation/pages/home/trabajadores/trabajador_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TrabajadoresPage extends StatefulWidget {
  const TrabajadoresPage({super.key, required this.client});

  final GraphQLClient client;

  @override
  State<TrabajadoresPage> createState() => _TrabajadoresPageState();
}

class _TrabajadoresPageState extends State<TrabajadoresPage> {
  final _pageController = PageController(initialPage: 0);
  Future<List<Empleado>>? _futureEmpleados;
  late Empleado _empleado;

  @override
  void initState() {
    super.initState();
    _futureEmpleados = _fetchEmpleados();
    _empleado = Empleado.empty();
  }

  Future<List<Empleado>> _fetchEmpleados() async {
    final result = await widget.client.query(
      QueryOptions(document: gql(EmpleadoQueries.getAllEmpleados)),
    );
    if (result.hasException) {
      throw result.exception!;
    }
    return Empleado.fromJsonList(result.data?['empleados'] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: FutureBuilder<List<Empleado>>(
        future: _futureEmpleados,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.surfaceBright,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final trabajadores = snapshot.data ?? [];
          return PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Column(
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
                          onPressed: _onAddEmpleado,
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
                          child: Text(
                            'Nombre',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Puesto',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Teléfono',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Correo',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'CURP',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
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
                            onTap: () => _editEmpleado(trabajador),
                            title: Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    '${trabajador.nombre} ${trabajador.apellidoPaterno} ${trabajador.apellidoMaterno}',
                                  ),
                                ),
                                Expanded(child: Text(trabajador.puesto)),
                                Expanded(child: Text(trabajador.telefono)),
                                Expanded(child: Text(trabajador.correo)),
                                Expanded(child: Text(trabajador.curp)),
                                Expanded(
                                  child: Text(
                                    trabajador.costoPorHora.toString(),
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
              ),
              TrabajadorPage(
                client: widget.client,
                empleado: _empleado,
                onBack: _onBack,
              ),
            ],
          );
        },
      ),
    );
  }

  void _editEmpleado(Empleado empleado) {
    setState(() {
      _empleado = empleado;
    });
    _pageController.jumpToPage(1);
  }

  void _onAddEmpleado() {
    _pageController.jumpToPage(1);
  }

  void _onBack() {
    _pageController.jumpToPage(0);
  }
}
