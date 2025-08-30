import 'package:flutter/material.dart';

class _MenuItem {
  final IconData icon;
  final String title;
  const _MenuItem(this.icon, this.title);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<_MenuItem> menuItems = const [
    _MenuItem(Icons.home, 'Inicio'),
    _MenuItem(Icons.people, 'Trabajadores'),
    _MenuItem(Icons.work, 'Proyectos y tareas'),
    _MenuItem(Icons.assignment, 'Informes proyectos'),
    _MenuItem(Icons.payments, 'Pagos'),
    _MenuItem(Icons.receipt_long, 'Informe pagos'),
  ];

  int selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget menu = Container(
      width: 300,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colorScheme.outline, width: 1),
              ),
              color: colorScheme.secondaryContainer,
            ),
          ),
          for (int i = 0; i < menuItems.length; i++)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: colorScheme.outline, width: 1),
                ),
              ),
              child: ListTile(
                leading: Icon(menuItems[i].icon, color: colorScheme.secondary),
                title: Text(
                  menuItems[i].title,
                  style: theme.textTheme.bodyMedium,
                ),
                trailing: Icon(Icons.chevron_right, size: 24),
                selected: selectedIndex == i,
                onTap: () {
                  setState(() {
                    selectedIndex = i;
                    _pageController.jumpToPage(i);
                  });
                },
              ),
            ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Scaffold(
          drawer: isMobile ? Drawer(child: menu) : null,
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(bottom: BorderSide(color: theme.dividerColor)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                width: double.infinity,
                child: Text(
                  'Constructoría',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    if (!isMobile) menu,
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          setState(() {
                            selectedIndex = i;
                          });
                        },
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: colorScheme.primary,
                            child: Center(
                              child: Text(
                                'Constructoria',
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          for (int i = 1; i < menuItems.length; i++)
                            Center(child: Text(menuItems[i].title)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
