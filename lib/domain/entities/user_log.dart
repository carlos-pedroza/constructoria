import 'dart:convert';

import 'package:constructoria/domain/entities/empleado.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLog {
  const UserLog({required this.jwt, required this.empleado});

  final String jwt;
  final Empleado empleado;

  static const _userLogKey = 'user_log';

  static Future<UserLog> login({required jwt, required empleado}) async {
    var userLog = UserLog(jwt: jwt, empleado: empleado);
    await userLog.set();
    return userLog;
  }

  static Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userLogKey);
  }

  static Future<UserLog?> get() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString(_userLogKey);
    return UserLog.fromJsonString(jsonString);
  }

  static UserLog? fromJsonString(String? jsonString) {
    if (jsonString == null) return null;
    var json = jsonDecode(jsonString);
    return UserLog(
      jwt: json['jwt'] as String,
      empleado: Empleado.fromJson(json['empleado'] as Map<String, dynamic>),
    );
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
