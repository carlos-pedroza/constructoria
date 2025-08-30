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
  final http.Client httpClient = http.Client();

  final HttpLink httpLink = HttpLink(
    httpClient: httpClient,
    '$server/graphql',
    defaultHeaders: {'Connection': 'keep-alive'},
  );

  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  );

  runApp(
    AppMain(
      client: client,
      httpLink: httpLink,
      servicesProvider: ServicesProvider(server: server),
    ),
  );
}
