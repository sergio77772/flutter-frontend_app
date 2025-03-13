import 'dart:convert';
import 'package:app_distribuidora/models/productos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  final String _baseUrl =
      'https://distribuidoraassefperico.com.ar/apis/productos.php';

  List<Producto> _searchResultados = [];
  bool _isLoading = false;
  bool _hasError = false;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  List<Producto> get searchResultados => _searchResultados;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  SearchProvider() {
    // Future.delayed(const Duration(milliseconds: 300), () {
    //   searchFocusNode.requestFocus();
    // });
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

  void clearSearch() {
    searchController.clear();
    searchProductos('');
  }
}
