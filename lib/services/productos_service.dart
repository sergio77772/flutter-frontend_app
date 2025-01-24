import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriasService {
  Future<List<dynamic>> fetchCategorias(int page, int limit) async {
    var url = Uri.parse(
        'https://distribuidoraassefperico.com.ar//apis/productos.php?endpoint=productos&page=$page&limit=$limit');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data['categories'];
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      throw Exception('Error fetching categories: $error');
    }
  }
}
