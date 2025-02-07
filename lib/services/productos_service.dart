import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductosService {
  Future<List<dynamic>> fetchProductos(int page, int limit) async {
    var url = Uri.parse(
        'https://distribuidoraassefperico.com.ar/apis/productos.php?endpoint=producto&search=&page=$page&limit=$limit');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data['producto'];
      } else {
        throw Exception('No se pudieron cargar los productos');
      }
    } catch (error) {
      throw Exception('Error al buscar los productos: $error');
    }
  }
}
