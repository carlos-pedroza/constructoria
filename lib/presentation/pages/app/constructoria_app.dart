import 'package:constructoria/cors/util.dart';
import 'package:constructoria/presentation/pages/app/theme.dart';
import 'package:constructoria/presentation/pages/home/main_page.dart';
import 'package:flutter/material.dart';

class ConstructoriaApp extends StatefulWidget {
  const ConstructoriaApp({super.key, required this.server});

  final String server;

  @override
  State<ConstructoriaApp> createState() => _ConstructoriaAppState();
}

class _ConstructoriaAppState extends State<ConstructoriaApp> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Montserrat", "Montserrat");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Constructoria',
      theme: theme
          .light(), // brightness == Brightness.light ? theme.light() : theme.dark(),
      home: MainPage(server: widget.server),
    );
  }
}
