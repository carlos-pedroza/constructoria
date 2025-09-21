import 'package:constructoria/domain/entities/proyecto.dart';
import 'package:constructoria/presentation/pages/proyectos/proyecto_page.dart';
import 'package:constructoria/presentation/pages/proyectos/proyectos_lista_page.dart';
import 'package:constructoria/presentation/pages/proyectos/tareas_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProyectosPage extends StatefulWidget {
  const ProyectosPage({super.key, required this.client});

  final GraphQLClient client;

  @override
  State<ProyectosPage> createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {
  final _pageController = PageController(initialPage: 0);
  late Proyecto _proyecto;

  static const int _pageListaProyectos = 0;
  static const int _pageProyecto = 1;
  static const int _pageTareas = 2;

  @override
  void initState() {
    super.initState();
    _proyecto = Proyecto.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ProyectosListaPage(
            client: widget.client,
            onAvances: (proyecto) => _onAvances(proyecto),
            onEditarTareas: (proyecto) => _onEditarTareas(proyecto),
            onEditProyecto: (proyecto) => _editProyecto(proyecto),
          ),
          ProyectoPage(
            client: widget.client,
            proyecto: _proyecto,
            onSave: _onSave,
            onBack: _onBack,
            onDelete: _onDelete,
          ),
          TareasPage(
            client: widget.client,
            proyecto: _proyecto,
            onBack: _onBack,
          ),
        ],
      ),
    );
  }

  void _editProyecto(Proyecto proyecto) {
    setState(() {
      _proyecto = proyecto;
    });
    _pageController.jumpToPage(_pageProyecto);
  }

  void _onAvances(Proyecto proyecto) {
    // Implementa la navegación o acción para avances
  }

  void _onEditarTareas(Proyecto proyecto) {
    setState(() {
      _proyecto = proyecto;
    });
    _pageController.jumpToPage(_pageTareas);
  }

  void _onBack() {
    _pageController.jumpToPage(_pageListaProyectos);
  }

  void _onSave(Proyecto proyecto) {
    // Aquí podrías refrescar la lista si tienes backend
    _pageController.jumpToPage(_pageListaProyectos);
  }

  void _onDelete(Proyecto proyecto) {
    // Aquí podrías refrescar la lista si tienes backend
    _pageController.jumpToPage(_pageListaProyectos);
  }
}
