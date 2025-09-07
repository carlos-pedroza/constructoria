import 'dart:convert';
import 'package:constructoria/domain/entities/services_provider.dart';
import 'package:constructoria/domain/entities/user_empleado.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityAuth {
  const SecurityAuth({
    required this.jwt,
    required this.userEmpleado,
    this.isLogged = false,
  });

  final String jwt;
  final UserEmpleado userEmpleado;
  final bool isLogged;

  static const _userLogKey = 'user_log';

  static Future<SecurityAuth> login({
    required String jwt,
    required UserEmpleado userEmpleado,
  }) async {
    var userLog = SecurityAuth(
      jwt: jwt,
      userEmpleado: userEmpleado,
      isLogged: true,
    );
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
    var containsKey = prefs.containsKey(_userLogKey);
    if (!containsKey) return null;
    var jsonString = prefs.getString(_userLogKey);
    return SecurityAuth.fromJsonString(jsonString);
  }

  static SecurityAuth? fromJsonString(String? jsonString) {
    if (jsonString == null) return null;
    var json = jsonDecode(jsonString);
    return SecurityAuth(
      jwt: json['jwt'] as String,
      userEmpleado: UserEmpleado.fromJson(json['empleado']),
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
    return {'jwt': jwt, 'empleado': userEmpleado.toJson()};
  }

  @override
  String toString() {
    var empleadoString = jsonEncode(toJson());
    return empleadoString;
  }
}
