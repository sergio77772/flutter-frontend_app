// import 'dart:convert';
// import 'package:app_distribuidora/models/productos_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class SearchProvider extends ChangeNotifier {
//   final String _baseUrl =
//       'https://distribuidoraassefperico.com.ar/apis/productos.php';

//   List<Producto> _searchResultados = [];
//   bool _isLoading = false;
//   bool _hasError = false;
//   final TextEditingController searchController = TextEditingController();
//   final FocusNode searchFocusNode = FocusNode();

//   List<Producto> get searchResultados => _searchResultados;
//   bool get isLoading => _isLoading;
//   bool get hasError => _hasError;

//   SearchProvider() {
//     // Future.delayed(const Duration(milliseconds: 300), () {
//     //   searchFocusNode.requestFocus();
//     // });
//   }

//   Future<void> searchProductos(String query) async {
//     if (query.isEmpty) {
//       _searchResultados = [];
//       notifyListeners();
//       return;
//     }

//     _isLoading = true;
//     _hasError = false;
//     notifyListeners();

//     try {
//       final url = Uri.parse('$_baseUrl?endpoint=producto&search=$query&page=1&limit=20');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['producto'] != null && data['producto'] is List) {
//           _searchResultados = (data['producto'] as List)
//               .map((item) => Producto.fromJson(item))
//               .toList();
//         } else {
//           _searchResultados = [];
//         }
//       } else {
//         _hasError = true;
//       }
//     } catch (e) {
//       _hasError = true;
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   void clearSearch() {
//     searchController.clear();
//     searchProductos('');
//   }
// }

import 'dart:convert';
import 'package:app_distribuidora/models/productos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider extends ChangeNotifier {
  final String _baseUrl = 'https://distribuidoraassefperico.com.ar/apis/productos.php';

  List<Producto> _searchResultados = [];
  bool _isLoading = false;
  bool _hasError = false;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  List<Producto> get searchResultados => _searchResultados;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  List<String> _searchHistorial = [];
  List<String> get searchHistory => _searchHistorial;

  SearchProvider() {
    _loadSearchHistorial(); // Cargar historial al iniciar
  }

  Future<void> searchProductos(String query) async {
    if (query.isEmpty) {
      _searchResultados = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final url = Uri.parse('$_baseUrl?endpoint=producto&search=$query&page=1&limit=20');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['producto'] != null && data['producto'] is List) {
          _searchResultados = (data['producto'] as List)
              .map((item) => Producto.fromJson(item))
              .toList();
        } else {
          _searchResultados = [];
        }
      } else {
        _hasError = true;
      }
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  // agregar al historial
  void addToHistorial(String query) async {
    if (!_searchHistorial.contains(query)) {
      _searchHistorial.insert(0, query);
      if (_searchHistorial.length > 5) {
        _searchHistorial.removeLast();
      }
      await _saveSearchHistorial(); // Guardar historial en almacenamiento
    }
    notifyListeners();
  }

  // eliminar del historial
  void removeFromHistory(int index) async {
    if (index >= 0 && index < _searchHistorial.length) {
      _searchHistorial.removeAt(index);
      await _saveSearchHistorial(); // Guardar cambios
      notifyListeners();
    }
  }

  // //borrar tdo el historial completo
  void clearHistorial() async {
    _searchHistorial.clear();
    await _saveSearchHistorial();
    notifyListeners();
  }

  // borrar lo del text field
  void clearSearch() {
    searchController.clear();
    searchProductos('');
  }

  // guardar historial en almacenamiento en dispositivo
  //prefs es preferencias
  Future<void> _saveSearchHistorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistorial', _searchHistorial);
  }

  // cargar historial al iniciar la app
  Future<void> _loadSearchHistorial() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistorial = prefs.getStringList('searchHistorial') ?? [];
    notifyListeners();
  }
}
