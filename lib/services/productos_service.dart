import 'dart:convert';
import 'package:app_distribuidora/models/productos_model.dart';
import 'package:http/http.dart' as http;

class ProductosService {
  Future<List<Producto>> fetchProductos(int page, int limit) async {
    var url = Uri.parse(
        'https://distribuidoraassefperico.com.ar/apis/productos.php?endpoint=producto&search=&page=$page&limit=$limit');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> productosJson = data['producto'];

        return productosJson.map((json) => Producto.fromJson(json)).toList();
      } else {
        throw Exception('No se pudieron cargar los productos');
      }
    } catch (error) {
      throw Exception('Error al buscar los productos: $error');
    }
  }
}
