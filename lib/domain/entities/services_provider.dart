import 'package:shared_preferences/shared_preferences.dart';

class ServicesProvider {
  final String server;
  String? token;
  ServicesProvider({required this.server, this.token});

  static const keyServer = 'server';
  static const keyToken = 'token';

  static Future<ServicesProvider> getServer() async {
    var prefs = await SharedPreferences.getInstance();
    var server = prefs.getString(keyServer);
    var token = prefs.getString(keyToken);
    return ServicesProvider(server: server!, token: token);
  }

  Future<void> setServer() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(keyServer, server);
    prefs.setString(keyToken, token ?? '');
  }
}
