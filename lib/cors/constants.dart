import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String baseUrlProd = 'https://api.allgaze.com';
  static const String baseUrlDev = 'http://192.168.100.246:3000';
  static const String baseUrlKey = 'base_url_key';

  static const String _informeTrabajadoresPath = '/empleados/pdf';
  static const String _informeProveedoresPath = '/proveedores/pdf';

  static Future<String> getBaseUrl() async {
    var prefs = await SharedPreferences.getInstance();

    var gbaseUrl = prefs.getString(baseUrlKey);

    return gbaseUrl ?? baseUrlDev;
  }

  static Future<String> informeTrabajadoresUrl({
    required String puesto,
    required String filtroExtra,
  }) async {
    final baseUrl = await getBaseUrl();

    // Usar '[empty]' si están vacíos
    String safePuesto = puesto.isEmpty ? '[empty]' : puesto;
    String safeFiltro = filtroExtra.isEmpty ? '[empty]' : filtroExtra;

    // Calcular expiración: hora actual + 10 minutos, formato dd-MM-yyyy-HH-mm-ss
    final expired = DateTime.now().add(const Duration(minutes: 10));
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String expiration =
      '${twoDigits(expired.day)}-${twoDigits(expired.month)}-${expired.year}-${twoDigits(expired.hour)}-${twoDigits(expired.minute)}-${twoDigits(expired.second)}';

    // Concatenar todo y codificar en base64
    String concat = '$safePuesto|$safeFiltro|$expiration';
    String cParam = base64Encode(concat.codeUnits);
    cParam = Uri.encodeComponent(cParam);

    return '$baseUrl$_informeTrabajadoresPath?c=$cParam';
  }

  static Future<String> informeProveedoresUrl({
    required String filtro,
  }) async {
    final baseUrl = await getBaseUrl();

    // Usar '[empty]' si está vacío
    String safeFiltro = filtro.isEmpty ? '[empty]' : filtro;

    // Calcular expiración: hora actual + 10 minutos, formato dd-MM-yyyy-HH-mm-ss
    final expired = DateTime.now().add(const Duration(minutes: 10));
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String expiration =
      '${twoDigits(expired.day)}-${twoDigits(expired.month)}-${expired.year}-${twoDigits(expired.hour)}-${twoDigits(expired.minute)}-${twoDigits(expired.second)}';

    // Concatenar filtro y expiración, codificar en base64
    String concat = '$safeFiltro|$expiration';
    String cParam = base64Encode(concat.codeUnits);
    cParam = Uri.encodeComponent(cParam);

    return '$baseUrl$_informeProveedoresPath?c=$cParam';
  }

  static Future<void> setBaseUrl(String pbaseUrl) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(baseUrlKey, pbaseUrl);
  }
}
