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
  final _pageController = PageController(initialPage: _listPage);
  late MaterialEntidad _material;
  dynamic _refetch;

  static const _listPage = 0;
  static const _editPage = 1;

  @override
  void initState() {
    super.initState();
    _material = MaterialEntidad(
      nombre: '',
      descripcion: '',
      unidad: '',
      codigo: '',
      costo: 0.0,
    );
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
                  MaterialesListaPage(
                    onAdd: _onAdd, 
                    onEdit: _onEdit,
                  ),
                  MaterialEntidadPage(
                    client: widget.client,
                    material: _material,
                    onSave: _onSave,
                    onDelete: _onDelete,
                    onBack: _onBack,
                  )
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
    setState(() {
      _material = MaterialEntidad(
        nombre: '',
        descripcion: '',
        unidad: '',
        codigo: '',
        costo: 0.0,
      );
      _refetch = refetch;
    });
    _pageController.jumpToPage(_editPage);
  }

  _onEdit(MaterialEntidad material, refetch) {
    setState(() {
      _material = material;
      _refetch = refetch;
    });
    _pageController.jumpToPage(_editPage);
  }

  void _onSave(MaterialEntidad material) {
    setState(() {
      _material = material;
    });
    _refetch();
    _onBack();
  }

  void _onDelete(MaterialEntidad material) {
    _onBack();
    _refetch();
  }

  void _onBack() {
    _pageController.jumpToPage(_listPage);
  }
}