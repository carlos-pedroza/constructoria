import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String baseUrl = 'http://192.168.100.4:3333';
  static const String baseUrlDev = 'http://192.168.100.4:3333';
  static const String baseUrlKey = 'base_url_key';

  static Future<String> getBaseUrl() async {
    var prefs = await SharedPreferences.getInstance();

    var gbaseUrl = prefs.getString(baseUrlKey);

    return gbaseUrl ?? baseUrlDev;
  }

  static Future<void> setBaseUrl(String pbaseUrl) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(baseUrlKey, pbaseUrl);
  }
}
