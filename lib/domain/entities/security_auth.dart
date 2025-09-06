import 'dart:convert';

import 'package:constructoria/domain/entities/empleado.dart';
import 'package:constructoria/domain/entities/services_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityAuth {
  const SecurityAuth({required this.jwt, required this.empleado});

  final String jwt;
  final Empleado empleado;
  final bool isLogged = false;

  static const _userLogKey = 'user_log';

  static Future<SecurityAuth> login({required jwt, required empleado}) async {
    var userLog = SecurityAuth(jwt: jwt, empleado: empleado);
    await userLog.set();
    return userLog;
  }

  static Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userLogKey);
    ServicesProvider.logout();
  }

  static Future<SecurityAuth?> get() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_userLogKey)) return null;
    var jsonString = prefs.getString(_userLogKey);
    return SecurityAuth.fromJsonString(jsonString);
  }

  static SecurityAuth? fromJsonString(String? jsonString) {
    if (jsonString == null) return null;
    var json = jsonDecode(jsonString);
    return SecurityAuth(
      jwt: json['jwt'] as String,
      empleado: Empleado.fromJson(json['empleado'] as Map<String, dynamic>),
    );
  }

  static Future<bool> isLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userLogKey);
  }

  Future set() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userLogKey, toString());
  }

  Map<String, dynamic> toJson() {
    return {'jwt': jwt, 'empleado': empleado.toJson()};
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
