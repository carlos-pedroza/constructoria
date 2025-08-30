import 'package:constructoria/domain/repositories/empleado_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TrabajadoresPage extends StatefulWidget {
  const TrabajadoresPage({super.key});

  @override
  State<TrabajadoresPage> createState() => _TrabajadoresPageState();
}

class _TrabajadoresPageState extends State<TrabajadoresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(document: gql(EmpleadoQueries.getAllEmpleados)),
        builder:
            (
              QueryResult result, {
              VoidCallback? refetch,
              FetchMore? fetchMore,
            }) {
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (result.hasException) {
                return Center(child: Text(result.exception.toString()));
              }
              final trabajadores = result.data?['trabajadores'] ?? [];
              return ListView.builder(
                itemCount: trabajadores.length,
                itemBuilder: (context, index) {
                  final trabajador = trabajadores[index];
                  return ListTile(
                    title: Text(trabajador['nombre']),
                    subtitle: Text('ID: ${trabajador['id']}'),
                  );
                },
              );
            },
      ),
    );
  }
}
