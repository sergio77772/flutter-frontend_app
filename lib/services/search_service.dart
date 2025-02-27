import 'dart:convert';

import 'package:app_distribuidora/models/productos_model.dart';
import 'package:http/http.dart' as http;

class SearchService {
  Future<List<Producto>> searchProducts(String query) async {
    if (query.isEmpty) {
      return []; // Retornar una lista vacía en caso de query vacía
    }

    try {
      final url = Uri.parse(
          'https://distribuidoraassefperico.com.ar/apis/productos.php?endpoint=producto&search=$query&page=1&limit=20');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['producto'] != null && data['producto'] is List) {
          return (data['producto'] as List)
              .map((item) => Producto.fromJson(item))
              .toList();
        } else {
          return []; // Si no hay productos, retornar lista vacía
        }
      } else {
        throw Exception('Error al cargar productos');
      }
    } catch (e) {
      print('Error en searchProducts: $e');
      return []; // Retorna lista vacía si hay error
    }
  }
}
