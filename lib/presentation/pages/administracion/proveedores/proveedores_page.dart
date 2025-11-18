import 'package:constructoria/domain/entities/proveedor.dart';
import 'package:constructoria/presentation/pages/administracion/proveedores/proveedor_page.dart';
import 'package:constructoria/presentation/pages/administracion/proveedores/proveedores_lista_page.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProveedoresPage extends StatefulWidget {
  const ProveedoresPage({super.key, required this.client});

  final GraphQLClient client;

  @override
  State<ProveedoresPage> createState() => _ProveedoresPageState();
}

class _ProveedoresPageState extends State<ProveedoresPage> {
  final _pageController = PageController(initialPage: 0);
  late Proveedor _proveedor;
  dynamic _refetch;

  @override
  void initState() {
    super.initState();
    _proveedor = Proveedor.empty();
  }

  void _onAddProveedor(dynamic refetch) {
    setState(() {
      _proveedor = Proveedor.empty();
      _refetch = refetch;
    });
    _pageController.jumpToPage(1);
  }

  void _editProveedor(Proveedor proveedor, dynamic refetch) {
    setState(() {
      _proveedor = proveedor;
      _refetch = refetch;
    });
    _pageController.jumpToPage(1);
  }

  void _onSave(dynamic refetch) {
    _pageController.jumpToPage(0);
    if (refetch != null) refetch();
  }

  void _onBack() {
    _pageController.jumpToPage(0);
  }

  void _onDelete(dynamic refetch) {
    _pageController.jumpToPage(0);
    if (refetch != null) refetch();
  }

  void _onClose() {
    Navigator.of(context).pop();
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
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProveedoresListaPage(
                    onAddProveedor: _onAddProveedor,
                    onEditProveedor: _editProveedor,
                  ),
                  ProveedorPage(
                    client: widget.client,
                    proveedor: _proveedor,
                    onSave: ()=>_onSave(_refetch),
                    onBack: ()=>_onBack(),
                    onDelete: ()=>_onDelete(_refetch),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
