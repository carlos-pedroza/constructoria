import 'package:constructoria/cors/wait_tool.dart';
import 'package:constructoria/domain/entities/estatus_pago.dart';
import 'package:constructoria/domain/entities/pago_detalle.dart';
import 'package:constructoria/domain/repositories/estatus_pago_queries.dart';
import 'package:constructoria/domain/repositories/pago_queries.dart';
import 'package:constructoria/presentation/pages/pagos/pago_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class PagosPage extends StatefulWidget {
  const PagosPage({super.key, required this.client});

  final GraphQLClient client;

  @override
  State<PagosPage> createState() => _PagosPageState();
}

class _PagosPageState extends State<PagosPage> {
  final _formatDate = DateFormat('dd/MM/yyyy');
  final _formatCurrency = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
  late int _idEstatusPago;

  @override
  void initState() {
    super.initState();
    _idEstatusPago = EstatusPago.ingresado;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Query(
        options: QueryOptions(
          document: gql(PagoQueries.getPagoDetalleViewByFilter),
          variables: {
            'id_estatus_pago': _idEstatusPago,
          },
          fetchPolicy: FetchPolicy.noCache,
        ),
        builder: (QueryResult result, {Refetch? refetch, FetchMore? fetchMore}) {

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator(color: theme.colorScheme.surfaceContainerLowest),);
          }

          if (result.hasException) {
            return Center(child: Text('Error al cargar los pagos'));
          }

          final pagos = PagoDetalle.fromJsonList(result.data?['pagoDetalleViewByFilter'] as List);

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
                          Icons.money,
                          color: theme.colorScheme.inverseSurface,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Pagos',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.inverseSurface,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: ()=>_onAddProyecto(refetch),
                      icon: Icon(Icons.add),
                      label: Text('Ingresar Pago'),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  border: Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1,
                    ),
                  ),
                ),
                child: Query(
                  options: QueryOptions(
                    document: gql(EstatusPagoQueries.getAllEstatusPagos),
                    fetchPolicy: FetchPolicy.noCache,
                  ),
                  builder: (QueryResult result, {Refetch? refetch, FetchMore? fetchMore}) {
                    if (result.isLoading) {
                      return Center(child: SizedBox(width: 100, child: WaitTool()));
                    }

                    if (result.hasException) {
                      return Center(child: Text('Error al cargar los estatus de pago', style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.error)));
                    }

                    var estatusPagos = EstatusPago.fromJsonList(result.data?['estatusPagos'] as List);

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var estatus in estatusPagos)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(estatus.descripcion),
                              selected: _idEstatusPago == estatus.idEstatusPago,
                              onSelected: (selected) {
                                setState(() {
                                  _idEstatusPago = estatus.idEstatusPago!;
                                });
                              },
                              selectedColor: EstatusPago.getColor(estatus.idEstatusPago!),
                              backgroundColor: theme.colorScheme.surfaceContainer,
                              checkmarkColor: theme.colorScheme.surfaceContainerLowest,
                              labelStyle: TextStyle(
                                color: _idEstatusPago == estatus.idEstatusPago
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                ),
              ),
              Expanded(
                  child: Column(
                    children: [
                      if(pagos.isEmpty)
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: Center(
                            child: Text(
                              'No hay pagos con el estatus seleccionado.',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.colorScheme.surfaceContainerLowest,
                              ),
                            ),
                          ),
                        )
                      else
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: pagos.length,
                          itemBuilder: (context, index) {
                            final pago = pagos[index];
                            return InkWell(
                              onTap: () => _onOpenPago(pago, refetch),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(top: 2, left: 2, right: 2),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceContainerLowest,
                                  border: Border.all(
                                    color: EstatusPago.getColor(pago.idEstatusPago),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: EstatusPago.getColor(pago.idEstatusPago),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: Icon(Icons.paid, color: theme.colorScheme.onPrimary, size: 24),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                pago.concepto,
                                                style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(width: 8),
                                              Icon(Icons.visibility, size: 20, color: theme.colorScheme.outline),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          _formatCurrency.format(pago.monto),
                                          style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: [
                                        Chip(
                                          label: Text(pago.beneficiarioNombre ?? '-', style: TextStyle(fontWeight: FontWeight.bold)),
                                          backgroundColor: theme.colorScheme.primaryContainer,
                                          labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                                        ),
                                        Chip(
                                          label: Text(pago.tipoBeneficiario ?? '-'),
                                          backgroundColor: theme.colorScheme.secondaryContainer,
                                          labelStyle: TextStyle(color: theme.colorScheme.onSecondaryContainer),
                                        ),
                                        Chip(
                                          label: Text(pago.metodoPago ?? '-'),
                                          backgroundColor: theme.colorScheme.tertiaryContainer,
                                          labelStyle: TextStyle(color: theme.colorScheme.onTertiaryContainer),
                                        ),
                                        Chip(
                                          label: Text(pago.cuentaDestino, style: TextStyle(fontWeight: FontWeight.bold)),
                                          backgroundColor: theme.colorScheme.surfaceVariant,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Proyecto: ${pago.nombreProyecto ?? 'Sin proyecto relacionado'}', style: theme.textTheme.bodyLarge),
                                              if (pago.idEstatusPago == EstatusPago.pagado || pago.idEstatusPago == EstatusPago.conciliado)
                                                Text('Fecha de pago: ${_formatDate.format(pago.fechaPago)}', style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold))
                                              else
                                                Text('Fecha Programada: ${_formatDate.format(pago.fechaProgramada)}', style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: EstatusPago.getColor(pago.idEstatusPago),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                pago.estatusPago ?? '-',
                                                style: theme.textTheme.bodyMedium!.copyWith(
                                                  color: theme.colorScheme.surfaceContainerLowest,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text('Notas: ${pago.notas}', style: theme.textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ],
          );
        }
      ),
    );
  }

  void _onAddProyecto(refetch) {
    final pago = PagoDetalle.empty();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PagoPage(
          client: widget.client, 
          pago: pago.toPago(),
          onSave: (pago) {
            refetch!();
          },
          onBack: (pago) {
            refetch!();
          },
          onDelete: (pago) {
            refetch!();
          },
        )
      ),
    );
  }
  
  void _onOpenPago(PagoDetalle pago, refetch) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PagoPage(
          client: widget.client, 
          pago: pago.toPago(),
          onSave: (pago) {
            refetch!();
          },
          onBack: (pago) {
            refetch!();
          },
          onDelete: (pago) {
            refetch!();
          },
        )
      ),
    );
  }
}