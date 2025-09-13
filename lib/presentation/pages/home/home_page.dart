import 'package:constructoria/domain/entities/security_auth.dart';
import 'package:constructoria/presentation/pages/home/login/login_page.dart'
    show LoginPage;
import 'package:constructoria/presentation/pages/trabajadores/trabajadores_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class _MenuItem {
  const _MenuItem(this.icon, this.title, this.openRoute);

  final IconData icon;
  final String title;
  final void Function() openRoute;
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.httpLink,
    required this.securityAuth,
  });

  final HttpLink httpLink;
  final SecurityAuth? securityAuth;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  static const _pageLogin = 0;
  static const _pageHome = 1;
  static const _pageTrabajadores = 2;

  late AuthLink? _authLink;
  late GraphQLClient? _client;

  Future<void> _initClient() async {
    _authLink = AuthLink(
      getToken: () async => 'Bearer ${widget.securityAuth?.jwt}',
    );
    var link = _authLink!.concat(widget.httpLink);
    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    );
    _onVerifyLogin();
  }

  @override
  void initState() {
    super.initState();
    _initClient();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final List<_MenuItem> menuItems = [
      _MenuItem(Icons.home, 'Inicio', () {
        setState(() {
          selectedIndex = 2;
          _pageController.jumpToPage(_pageHome);
        });
      }),
      _MenuItem(Icons.people, 'Trabajadores', () {
        setState(() {
          selectedIndex = 2;
          _pageController.jumpToPage(_pageTrabajadores);
        });
      }),
      _MenuItem(Icons.work, 'Proyectos y tareas', () {}),
      _MenuItem(Icons.payments, 'Pagos', () {}),
      _MenuItem(Icons.receipt_long, 'Informes', () {}),
    ];

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
            height: 116,
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
                onTap: menuItems[i].openRoute,
                leading: Icon(menuItems[i].icon, color: colorScheme.secondary),
                title: Text(
                  menuItems[i].title,
                  style: theme.textTheme.bodyMedium,
                ),
                trailing: Icon(Icons.chevron_right, size: 24),
                selected: selectedIndex == i,
              ),
            ),
        ],
      ),
    );
    var client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: widget.httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return Scaffold(
            drawer: isMobile ? Drawer(child: menu) : null,
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        border: Border(
                          bottom: BorderSide(color: theme.dividerColor),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      width: double.infinity,
                      child: Text(
                        '',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (_authLink != null && _client != null)
                      Expanded(
                        child: Row(
                          children: [
                            if (!isMobile) menu,
                            Expanded(
                              child: PageView(
                                controller: _pageController,
                                physics: NeverScrollableScrollPhysics(),
                                onPageChanged: (i) {
                                  setState(() {
                                    selectedIndex = i;
                                  });
                                },
                                children: [
                                  LoginPage(onLogin: _onVerifyLogin),
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: colorScheme.primary,
                                    child: Center(
                                      child: Text(
                                        'CONSTRUCTORIA',
                                        style: theme.textTheme.headlineLarge
                                            ?.copyWith(
                                              color: colorScheme.onPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                  TrabajadoresPage(client: _client!),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 16, top: 22),
                    height: 140,
                    child: Image.asset(
                      'assets/images/constructoria.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onVerifyLogin() async {
    var userLog = await SecurityAuth.get();
    if (userLog == null) {
      _pageController.jumpToPage(_pageLogin);
    }
    _pageController.jumpToPage(_pageHome);
  }
}
