import 'package:constructoria/domain/entities/v_tarea.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class TareaComentariosPage extends StatefulWidget {
  const TareaComentariosPage({super.key, required this.client, required this.tarea});

  final GraphQLClient client;
  final VTarea tarea;

  @override
  State<TareaComentariosPage> createState() => _TareaComentariosPageState();
}

class _TareaComentariosPageState extends State<TareaComentariosPage> {
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comentarios de la Tarea'),
        ),
        body: Column(
          children: [
            TitlePageComponent(onClose: _onClose),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceBright,
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  '${widget.tarea.code} ${widget.tarea.tareaDescripcion}',
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${_dateFormat.format(widget.tarea.fechaInicio)} - ${_dateFormat.format(widget.tarea.fechaFin)}  Asignado: ${widget.tarea.responsable}',
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClose() {
    Navigator.of(context).pop();
  }
}