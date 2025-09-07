import 'package:constructoria/domain/entities/security_auth.dart';
import 'package:constructoria/domain/repositories/security_queries.dart';
import 'package:constructoria/presentation/pages/home/home_page.dart';
import 'package:constructoria/presentation/pages/home/login/login_main_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.server});

  final String server;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  HttpLink? _httpLink;
  GraphQLClient? _client;

  Future<void> initializeClient() async {
    var httpClient = http.Client();

    setState(() {
      _httpLink = HttpLink(
        httpClient: httpClient,
        '${widget.server}/graphql',
        defaultHeaders: {'Connection': 'keep-alive'},
      );

      _client = GraphQLClient(
        link: _httpLink!,
        cache: GraphQLCache(store: HiveStore()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    initializeClient();
  }

  Future<SecurityAuth?> getSecurityAuth() async {
    var auth = await SecurityAuth.get();
    return auth;
  }

  @override
  Widget build(BuildContext context) {
    return _client != null && _httpLink != null
        ? GraphQLProvider(
            client: ValueNotifier(_client!),
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
                      client: _client!,
                      onLogin: () {
                        setState(() {});
                      },
                    );
                  }
                  return Query(
                    options: QueryOptions(
                      document: gql(SecurityQueries.verifyJwt),
                      variables: {'token': securityAuth.jwt},
                      fetchPolicy: FetchPolicy.noCache,
                    ),
                    builder: (result, {fetchMore, refetch}) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error no fue posible realizar la conexion',
                          ),
                        );
                      }

                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (result.data?['verifyJwt'] == false) {
                        SecurityAuth.logout().then((_) {
                          setState(() {});
                        });
                        return const Center(child: CircularProgressIndicator());
                      }

                      return HomePage(
                        httpLink: _httpLink!,
                        securityAuth: securityAuth,
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
