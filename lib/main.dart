import 'package:constructoria/cors/constants.dart';
import 'package:constructoria/domain/entities/services_provider.dart';
import 'package:constructoria/presentation/pages/app/app_%20main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initHiveForFlutter();

  const server = Constants.baseUrlDev;

  Constants.setBaseUrl(server);

  runApp(AppMain(server: server));
}
