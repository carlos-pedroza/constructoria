import 'package:constructoria/cors/util.dart';
import 'package:constructoria/domain/entities/services_provider.dart';
import 'package:constructoria/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'theme.dart';

class AppMain extends StatefulWidget {
  const AppMain({
    super.key,
    required this.httpLink,
    required this.client,
    required this.servicesProvider,
  });

  final HttpLink httpLink;
  final GraphQLClient client;
  final ServicesProvider servicesProvider;

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Montserrat", "Montserrat");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Constructoria',
      theme: theme
          .light(), // brightness == Brightness.light ? theme.light() : theme.dark(),
      home: HomePage(
        httpLink: widget.httpLink,
        client: widget.client,
        servicesProvider: widget.servicesProvider,
      ),
    );
  }
}
