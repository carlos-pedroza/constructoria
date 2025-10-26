import 'package:constructoria/domain/entities/tipo_gasto.dart';
import 'package:constructoria/presentation/pages/administracion/gastos/tipo_gasto_page.dart';
import 'package:constructoria/presentation/pages/administracion/gastos/tipo_gastos_lista_page.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TipoGastosPage extends StatefulWidget {
  const TipoGastosPage({super.key, required this.client});

  final GraphQLClient client;

  @override
  State<TipoGastosPage> createState() => _TipoGastosPageState();
}

class _TipoGastosPageState extends State<TipoGastosPage> {
  final _pageController = PageController(initialPage: 0);
  late TipoGasto _gasto;
  dynamic _refetch;

  static const _listPage = 0;
  static const _editPage = 1;

  @override
  void initState() {
    super.initState();
    _gasto = TipoGasto.empty();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(widget.client),
      child: Scaffold(
        body: Column(
          children: [
            TitlePageComponent(onClose: _onClose),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TipoGastosListaPage(
                    onAdd: _onAdd, 
                    onEdit: _onEdit,
                  ),
                  TipoGastoPage(
                    client: widget.client,
                    gasto: _gasto,
                    onSave: _onSave,
                    onDelete: _onDelete,
                    onBack: _onBack,
                  ),
                ]
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

  void _onAdd(refetch) {
    setState(() {
      _gasto = TipoGasto.empty();
      _refetch = refetch;
    });
    _pageController.jumpToPage(_editPage);
  }

  void _onEdit(TipoGasto gasto, refetch) {
    setState(() {
      _gasto = gasto;
      _refetch = refetch;
    });
    _pageController.jumpToPage(_editPage);
  }

  void _onSave(TipoGasto gasto) {
    setState(() {
      _gasto = gasto;
    });
    _refetch();
    _onBack();
  }

  void _onDelete(TipoGasto gasto) {
    _onBack();
  }

  void _onBack() {
    _pageController.jumpToPage(_listPage);
  }
}