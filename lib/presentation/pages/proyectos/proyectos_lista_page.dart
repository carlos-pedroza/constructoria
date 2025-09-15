import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProyectosListaPage extends StatefulWidget {
  const ProyectosListaPage({super.key, required this.onAvances, required this.onEditarTareas, required this.onEditProyecto});

  final Function(Proyecto proyecto) onAvances;
  final Function(Proyecto proyecto) onEditarTareas;
  final Function(Proyecto proyecto) onEditProyecto;

  @override
  State<ProyectosListaPage> createState() => _ProyectosListaPageState();
}

class _ProyectosListaPageState extends State<ProyectosListaPage> {
  final _formatDate = DateFormat('dd/MM/yyyy');
  final _formatCurrency = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

  // Simulación de datos, reemplaza por tu consulta real
  final List<Proyecto> proyectos = [
    Proyecto(
      claveProyecto: 'PRJ-001',
      nombre: 'Edificio Central',
      descripcion: 'Construcción de edificio de oficinas',
      fechaInicio: DateTime(2025, 9, 15),
      fechaFin: DateTime(2026, 3, 30),
      idestado: 1,
      estadoNombre: 'Por realizar',
      presupuesto: 1500000,
      ubicacion: 'Av. Principal 123',
      clienteNombre: 'Constructora XYZ',
      clienteContacto: 'Juan Pérez',
      clienteEmail: 'juan@xyz.com',
      clienteTelefono: '555-1234',
      clienteDireccion: 'Calle Falsa 456',
      responsableId: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Proyecto(
      claveProyecto: 'PRJ-002',
      nombre: 'Edificio Sur',
      descripcion: 'Construcción de edificio de oficinas',
      fechaInicio: DateTime(2025, 9, 15),
      fechaFin: DateTime(2026, 3, 30),
      idestado: 1,
      estadoNombre: 'Por realizar',
      presupuesto: 1500000,
      ubicacion: 'Av. Principal 123',
      clienteNombre: 'Constructora XYZ',
      clienteContacto: 'Juan Pérez',
      clienteEmail: 'juan@xyz.com',
      clienteTelefono: '555-1234',
      clienteDireccion: 'Calle Falsa 456',
      responsableId: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                onPressed: () {
                  // Acción para agregar un nuevo proyecto
                },
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
                  onTap: () => widget.onEditProyecto(proyecto),
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
                          proyecto.estadoNombre,
                          textAlign: TextAlign.right,
                        ),
                      ),
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
                        onPressed: () => widget.onEditarTareas(proyecto),
                        icon: Icon(Icons.task),
                        label: Text('Editar tareas'),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.chevron_right),
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
}
