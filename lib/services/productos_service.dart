import 'dart:convert'; // Importa funciones para trabajar con datos JSON.
import 'package:http/http.dart' as http; // Importa el paquete para realizar solicitudes HTTP.

class CategoriasService {
  // Método que obtiene una lista de categorías desde una API.
  Future<List<dynamic>> fetchCategorias(int page, int limit) async {
    // Construye la URL de la API con los parámetros de página y límite.
    var url = Uri.parse('https://distribuidoraassefperico.com.ar//apis/productos.php?endpoint=productos&page=$page&limit=$limit');
    
    try {
      // Realiza una solicitud GET a la URL.
      final response = await http.get(url);

      // Si la respuesta tiene un código de estado 200 (éxito).
      if (response.statusCode == 200) {
        // Convierte el cuerpo de la respuesta (JSON) en un objeto de Dart.
        var data = jsonDecode(response.body);
        // Devuelve la lista de categorías contenida en la clave 'categories'.
        return data['categories'];
      } else {
        // Lanza una excepción si el código de estado no es 200.
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      // Maneja errores durante la solicitud o procesamiento.
      throw Exception('Error fetching categories: $error');
    }
  }
}
