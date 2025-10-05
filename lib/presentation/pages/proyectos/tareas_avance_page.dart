import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
              children: [
                IconButton(
                    onPressed: widget.onBack,
                    icon: Icon(Icons.arrow_back),
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
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '75%',  
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.inverseSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text('Gastos: \$12,500', style: theme.textTheme.titleMedium),
                            const SizedBox(width: 30),
                            Text('Materiales: \$32,000', style: theme.textTheme.titleMedium),
                            const SizedBox(width: 30),
                            Text('Mano de obra: \$12,000', style: theme.textTheme.titleMedium),
                            const SizedBox(width: 30),
                            Text('Total: \$44,500', style: theme.textTheme.titleMedium),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: 0.75, // Cambia por el avance global
                          backgroundColor: Colors.blue[50],
                          color: Colors.blue,
                          minHeight: 10,
                        ),
                      ],
                    ),
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
                      child: ListView(
                        children: [
                          SizedBox(height: 20),
                          _TareaCard(
                            numero: 1,
                            responsable: 'Juan Pérez',
                            avance: 0.4,
                            gastos: {'Transporte material': 500, 'Comida personal': 300},
                            materiales: {'Cemento (5 sacos)': 1200, 'Varilla (20 pzas)': 2000},
                          ),
                          const SizedBox(height: 20),
                          _TareaCard(
                            numero: 2,
                            responsable: 'Juan Pérez',
                            avance: 0.0,
                            gastos: {'Transporte material': 500, 'Comida personal': 300},
                            materiales: {'Cemento (5 sacos)': 1200, 'Varilla (20 pzas)': 2000},
                          ),
                          const SizedBox(height: 20),
                          _TareaCard(
                            numero: 3,
                            responsable: 'No iniciado',
                            avance: 0.0,
                            gastos: {'Cemento (5 sacos)': 1200, 'Varilla (20 pzas)': 2000},
                            materiales: {'Cemento (5 sacos)': 1200, 'Varilla (20 pzas)': 2000},
                            estado: 'No iniciado',
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TareaCard extends StatelessWidget {
  const _TareaCard({
    required this.numero,
    required this.responsable,
    required this.avance,
    required this.gastos,
    required this.materiales,
    this.estado,
  });

  final int numero;
  final String responsable;
  final double avance;
  final Map<String, int> gastos;
  final Map<String, int> materiales;
  final String? estado;

  @override
  Widget build(BuildContext context) {
    final totalGastos = gastos.values.fold(0, (a, b) => a + b);
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
              Expanded(child: Text('Tarea #$numero', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
              if (estado != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(estado!, style: TextStyle(fontSize: 12)),
                ),
              ],
              IconButton(
                onPressed: _onTareaComment, 
                icon: Icon(Icons.comment, size: 16),
              )
            ],
          ),
          Row(
            children: [
              Expanded(child: Text('Responsable: $responsable', style: Theme.of(context).textTheme.bodyMedium)),
              SizedBox(width: 8),
              IconButton(
                onPressed: _onEditProgress,
                icon: Icon(Icons.percent_rounded, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: avance,
            backgroundColor: Colors.blue[50],
            color: Colors.blue,
            minHeight: 6,
          ),
          const SizedBox(height: 4),
          Text('Avance: ${(avance * 100).toInt()}%', style: Theme.of(context).textTheme.bodySmall),
          const Divider(height: 20),
          Text('Gastos', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          ...gastos.entries.map((e) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e.key),
              Text('\$${e.value}'),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('\$${totalGastos}', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: Text('Agregar gasto'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(120, 32),
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          const Divider(height: 20),
          Text('Materiales', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          ...materiales.entries.map((e) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e.key),
              Text('\$${e.value}'),
            ],
          )),
          ElevatedButton(
            onPressed: () {},
            child: Text('Agregar material'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(120, 32),
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Mano de obra:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('\$${totalGastos}', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('\$${totalGastos}', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  void _onEditProgress() {
  }

  void _onTareaComment() {
  }
}