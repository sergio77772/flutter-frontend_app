import 'dart:convert';
import 'package:app_distribuidora/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<bool> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      _showSnackbar(context, "Por favor, ingrese su correo y contraseña.");
      return false;
    }

    final url = Uri.parse(
      // 'https://distribuidoraassefperico.com.ar/apis-stg/users.php?action=login',
      'https://distribuidoraassefperico.com.ar/apis/users.php?action=login',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'correo': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('success') &&
            data['success'].toString().toLowerCase().contains(
                  "login exitoso",
                )) {
          // Guardar nombre de usuario si viene en la respuesta
          String nombre =
              data.containsKey('nombre') ? data['nombre'] : "Usuario";

          _showSnackbar(context, "Login exitoso");
          await _saveLoginData(email, nombre);
          return true;
        } else {
          _showSnackbar(context, "Credenciales incorrectas");
        }
      } else {
        _showSnackbar(context, "Error en la autenticación.");
      }
    } catch (e) {
      _showSnackbar(context, "Error de conexión. Inténtelo de nuevo.");
    }
    
    return false;
  }

  static Future<void> _saveLoginData(String email, String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    await prefs.setString('nombre', nombre);
  }

  static void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
    );
  }
}
