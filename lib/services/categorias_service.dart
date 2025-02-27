import 'dart:convert';
import 'package:app_distribuidora/models/categorias_model.dart';
import 'package:http/http.dart' as http;

class CategoriasService {
  Future<List<Categoria>> fetchCategorias(int page, int limit) async {
    var url = Uri.parse(
        'https://distribuidoraassefperico.com.ar/apis/categorias.php?endpoint=categoria&search=&page=$page&limit=$limit');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> categoriasJson = data['categories'];

        return categoriasJson.map((json) => Categoria.fromJson(json)).toList();
      } else {
        throw Exception('No se pudieron cargar las categorias');
      }
    } catch (error) {
      throw Exception('Error al buscar las categorias: $error');
    }
  }
}
