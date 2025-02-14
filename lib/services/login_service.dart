import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('https://distribuidoraassefperico.com.ar/apis-stg/users.php?action=login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Error en la solicitud: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': 'Error de conexión: $e'};
    }
  }
}
