import 'package:constructoria/cors/util.dart';
import 'package:constructoria/domain/entities/security_auth.dart';
import 'package:constructoria/domain/repositories/security_queries.dart';
import 'package:constructoria/presentation/pages/home/home_page.dart';
import 'package:constructoria/presentation/pages/home/login/login_main_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'theme.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key, required this.server});

  final String server;

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  late HttpLink _httpLink;
  late GraphQLClient _client;

  @override
  void initState() {
    super.initState();
    var httpClient = http.Client();
    _httpLink = HttpLink(
      httpClient: httpClient,
      '${widget.server}/graphql',
      defaultHeaders: {'Connection': 'keep-alive'},
    );

    _client = GraphQLClient(
      link: _httpLink,
      cache: GraphQLCache(store: HiveStore()),
    );
  }

  Future<SecurityAuth?> getSecurityAuth() async {
    var auth = await SecurityAuth.get();
    return auth;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Montserrat", "Montserrat");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Constructoria',
      theme: theme
          .light(), // brightness == Brightness.light ? theme.light() : theme.dark(),
      home: GraphQLProvider(
        client: ValueNotifier(_client),
        child: FutureBuilder<SecurityAuth?>(
          future: getSecurityAuth(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error no fue posible realizar la conexion'),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final securityAuth = snapshot.data;
              if (securityAuth == null) {
                return LoginMainPage(
                  client: _client,
                  onLogin: () {
                    setState(() {});
                  },
                );
              }
              return Query(
                options: QueryOptions(
                  document: gql(SecurityQueries.verifyJwt),
                  variables: {'token': securityAuth.jwt},
                  fetchPolicy: FetchPolicy.networkOnly,
                ),
                builder: (result, {fetchMore, refetch}) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error no fue posible realizar la conexion'),
                    );
                  }

                  if (result.data == null ||
                      result.data?['verifyJwt'] == false) {
                    SecurityAuth.logout().then((_) {
                      setState(() {});
                    });
                    return const Center(child: CircularProgressIndicator());
                  }

                  return HomePage(
                    httpLink: _httpLink,
                    securityAuth: securityAuth,
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
