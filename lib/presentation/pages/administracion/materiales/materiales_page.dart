import 'package:constructoria/domain/entities/material_entidad.dart';
import 'package:constructoria/presentation/pages/administracion/materiales/material_entidad_page.dart';
import 'package:constructoria/presentation/pages/administracion/materiales/materiales_lista_page.dart';
import 'package:constructoria/presentation/pages/globales/title_page_component.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MaterialesPage extends StatefulWidget {
  const MaterialesPage({super.key, required this.client});

  final GraphQLClient client;

  @override
  State<MaterialesPage> createState() => _MaterialesPageState();
}

class _MaterialesPageState extends State<MaterialesPage> {
  final _pageController = PageController(initialPage: 0);
  late Material _material;
  dynamic _refetch;

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
                  MaterialesListaPage(
                    onAdd: _onAdd, 
                    onEdit: _onEdit,
                  ),
                  MaterialEntidadPage()
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

  _onAdd(refetch) {
  }

  _onEdit(MaterialEntidad material, refetch) {
  }
}