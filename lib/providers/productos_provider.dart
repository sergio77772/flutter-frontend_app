import 'package:app_distribuidora/models/productos_model.dart';
import 'package:app_distribuidora/services/productos_service.dart';
import 'package:flutter/material.dart';

class ProductosProvider with ChangeNotifier {
  final ProductosService _productosService = ProductosService();

  List<Producto> _productos = [];
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool _cargando = false; 

  List<Producto> get productos => _productos;
  bool get hasMore => _hasMore;
  bool get cargando => _cargando; 

  ProductosProvider() {
    _fetchProductos();
  }

  /// Carga productos por página (paginación normal
  Future<void> _fetchProductos() async {
    if (!_hasMore || _cargando) return; 

    _cargando = true;
    notifyListeners();

    try {
      final newProductos = await _productosService.fetchProductos(
        _page,
        _limit,
      );
      _productos.addAll(newProductos);
      _page++;
      if (newProductos.length < _limit) _hasMore = false;
    } catch (error) {
      print('Error al cargar productos: $error');
    }

    _cargando = false;
    notifyListeners();
  }

  ///cargar más productos (antes en la intrfaz)
  void cargarMasProductos() {
    _fetchProductos();
  }
}
