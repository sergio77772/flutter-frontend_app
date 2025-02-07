import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriasService {
  Future<List<dynamic>> fetchCategorias(int page, int limit) async {
    var url = Uri.parse(
        'https://distribuidoraassefperico.com.ar/apis/categorias.php?endpoint=categoria&search=&page=$page&limit=$limit');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data['categories'];
      } else {
        throw Exception('No se pudieron cargar las categorias');
      }
    } catch (error) {
      throw Exception('Error al buscar las categorias: $error');
    }
  }
}
