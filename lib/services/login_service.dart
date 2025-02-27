import 'dart:convert';
import 'package:app_distribuidora/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      _showSnackbar(context, "Por favor, ingrese su correo y contraseña.");
      return;
    }

    final url = Uri.parse(
      'https://distribuidoraassefperico.com.ar/apis-stg/users.php?action=login',
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
          _showSnackbar(context, "Login exitoso");

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        } else {
          _showSnackbar(context, "Credenciales incorrectas");
        }
      } else {
        _showSnackbar(context, "Error en la autenticación.");
      }
    } catch (e) {
      _showSnackbar(context, "Error de conexión. Inténtelo de nuevo.");
    }
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

