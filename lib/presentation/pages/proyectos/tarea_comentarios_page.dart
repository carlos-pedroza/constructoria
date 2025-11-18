import 'package:constructoria/cors/snak.dart';
import 'package:constructoria/domain/entities/tarea_comentario.dart';
import 'package:constructoria/domain/entities/v_tarea.dart';
import 'package:constructoria/domain/repositories/tarea_comentario_queries.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class TareaComentariosPage extends StatefulWidget {
  const TareaComentariosPage({super.key, required this.client, required this.tarea, required this.refetchTareas});

  final GraphQLClient client;
  final VTarea tarea;
  final VoidCallback refetchTareas;

  @override
  State<TareaComentariosPage> createState() => _TareaComentariosPageState();
}

class _TareaComentariosPageState extends State<TareaComentariosPage> {
  final _dateFormat = DateFormat('dd/MM/yyyy HH:mm');


  // Simular el id del empleado actual (reemplazar por el real en producción)
  final int _currentUserId = 1;
  final TextEditingController _controller = TextEditingController();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Scaffold(
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
            Expanded(
              child: Query(
                options: QueryOptions(
                  document: gql(TareaComentarioQueries.getByTarea),
                  variables: {
                    'idtarea': widget.tarea.idtarea,
                  },
                  fetchPolicy: FetchPolicy.noCache,
                ),
                builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                  if (result.hasException) {
                    return Center(child: Text('Error al cargar los comentarios'));
                  }
                  if (result.isLoading) {
                    return Center(child: CircularProgressIndicator(color: theme.colorScheme.surfaceContainerLowest));
                  }
                  final comentarios = TareaComentario.fromJsonList(result.data?['tareaComentariosByTarea'] as List);

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          itemCount: comentarios.length,
                          itemBuilder: (context, index) {
                            final comentario = comentarios[comentarios.length - 1 - index];
                            final isOwn = comentario.idempleado == _currentUserId;
                            return Align(
                              alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                                decoration: BoxDecoration(
                                  color: isOwn ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.surfaceContainerLow,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomLeft: isOwn ? Radius.circular(16) : Radius.circular(4),
                                    bottomRight: isOwn ? Radius.circular(4) : Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comentario.comentarios,
                                      style: TextStyle(
                                        color: theme.colorScheme.inverseSurface,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (!isOwn)
                                          Text(
                                            comentario.empleadoNombre ?? '',
                                            style: TextStyle(
                                              color: theme.colorScheme.inverseSurface,
                                              fontSize: 12,
                                            ),
                                          ),
                                        if (!isOwn) SizedBox(width: 8),
                                        Text(
                                          _dateFormat.format(comentario.creado),
                                          style: TextStyle(
                                            color: theme.colorScheme.inverseSurface,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Divider(thickness: 1.0, height: 1.0, color: theme.colorScheme.outline),
                      Mutation(
                        options: MutationOptions(
                          document: gql(TareaComentarioQueries.create),
                          onCompleted: (dynamic resultData) {
                            setState(() { _sending = false; });
                            _controller.clear();
                            if (refetch != null) {
                              refetch();
                            }
                            widget.refetchTareas();
                          },
                          onError: (OperationException? error) {
                            setState(() { _sending = false; });
                            Snak.show(
                              context: context, 
                              message: 'Error al enviar el comentario',
                              backcolor: theme.colorScheme.error,
                            ); 
                          },
                        ),
                        builder: (RunMutation runMutation, QueryResult? mutationResult) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _controller,
                                    minLines: 1,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText: 'Escribe un comentario...',
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    onFieldSubmitted: (value) => _sendComentario(value, runMutation, refetch),
                                    enabled: !_sending,
                                  ),
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  icon: _sending
                                      ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                                      : Icon(Icons.send, color: theme.colorScheme.surfaceContainerLowest),
                                  onPressed: _sending
                                      ? null
                                      : () => _sendComentario(_controller.text, runMutation, refetch),
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendComentario(String value, runMutation, refetch) async {
    if (value.trim().isEmpty || _sending) return;
    setState(() { _sending = true; });
    runMutation({
      'idtarea': widget.tarea.idtarea,
      'comentarios': value.trim(),
      'idempleado': _currentUserId, // Reemplazar con el ID del empleado actual
      'creado': DateTime.now().toIso8601String(),
    });
  }

  void _onClose() {
    Navigator.of(context).pop();
  }
}