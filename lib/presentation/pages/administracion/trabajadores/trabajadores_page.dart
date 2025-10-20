import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/presentation/pages/administracion/trabajadores/trabajador_page.dart';
import 'package:constructoria/presentation/pages/administracion/trabajadores/trabajadores_lista_page.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
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
  late Empleado _empleado;
  dynamic _refetch;

  @override
  void initState() {
    super.initState();
    _empleado = Empleado.empty();
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
                  TrabajadoresListaPage(
                    onAddEmpleado: (refetch) => _onAddEmpleado(refetch),
                    onEditEmpleado: (empleado, refetch) => _editEmpleado(empleado, refetch),
                  ),
                  TrabajadorPage(
                    client: widget.client,
                    empleado: _empleado,
                    refetch: _refetch,
                    onSave: _onSave,
                    onBack: _onBack,
                    onDelete: _onDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editEmpleado(Empleado empleado, refetch) {
    setState(() {
      _empleado = empleado;
      _refetch = refetch;
    });
    _pageController.jumpToPage(1);
  }

  void _onAddEmpleado(refetch) {
    setState(() {
      _empleado = Empleado.empty();
      _refetch = refetch;
    });
    _pageController.jumpToPage(1);
  }

  void _onBack() {
    _pageController.jumpToPage(0);
  }

  void _onSave(refetch) {
    refetch();
    _pageController.jumpToPage(0);
  }

  void _onDelete(refetch) {
    refetch();
    _pageController.jumpToPage(0);
  }

  void _onClose() {
    Navigator.of(context).pop();
  }
}
