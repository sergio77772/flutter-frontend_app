import 'package:flutter/material.dart';
import '../models/categorias_model.dart';
import '../services/categorias_service.dart';

class CategoriasProvider with ChangeNotifier {
  final CategoriasService _categoriasService = CategoriasService();
  
  List<Categoria> _categorias = [];
  // int _page = 1;
  // final int _limit = 10;
  bool _hasMore = true;

  List<Categoria> get categorias => _categorias;
  bool get hasMore => _hasMore;

  CategoriasProvider() {
    fetchAllCategorias();
  }

  /// carga categorías por (paginación normal)
  // Future<void> _fetchCategorias() async {
  //   if (!_hasMore) return;

  //   try {
  //     final newCategorias = await _categoriasService.fetchCategorias(_page, _limit);
  //     _categorias.addAll(newCategorias);
  //     _page++;
  //     if (newCategorias.length < _limit) _hasMore = false;
  //     notifyListeners();
  //   } catch (error) {
  //     print('Error al cargar categorías: $error');
  //   }
  // }

  //carga todas las categorías de una sola vez
  Future<void> fetchAllCategorias() async {
    try {
      final allCategorias = await _categoriasService.fetchCategorias(1, 100);
      _categorias = allCategorias;
      _hasMore = false; // Ya no se necesitará cargar más datos
      notifyListeners();
    } catch (error) {
      print('Error al cargar todas las categorías: $error');
    }
  }
}
