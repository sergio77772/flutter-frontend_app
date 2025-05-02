import 'dart:convert';
import 'package:app_distribuidora/models/comercio_model.dart';
import 'package:http/http.dart' as http;

class ComercioService {
  Future<List<ApiComercio>> fetchElementosComercio() async {
    var url =
        Uri.parse('https://distribuidoraassefperico.com.ar/apis/comercio.php');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> comercioJson = jsonDecode(response.body);
        return comercioJson.map((json) => ApiComercio.fromJson(json)).toList();
      } else {
        throw Exception('No se pudieron cargar los elementos');
      }
    } catch (error) {
      throw Exception('Error al buscar los elememtos: $error');
    }
  }
}
