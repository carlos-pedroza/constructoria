import 'package:constructoria/cors/constants.dart';
import 'package:constructoria/presentation/pages/app/constructoria_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initHiveForFlutter();

  const server = Constants.baseUrlDev;

  Constants.setBaseUrl(server);

  runApp(ConstructoriaApp(server: server));
}
