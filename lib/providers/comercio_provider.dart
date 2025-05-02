import 'package:flutter/material.dart';
import 'package:app_distribuidora/models/comercio_model.dart';
import 'package:app_distribuidora/services/comercio_service.dart';

class ComercioProvider with ChangeNotifier {
  final ComercioService _comercioService = ComercioService();

  List<ApiComercio> _comercio = [];
  bool _cargando = false;

  List<ApiComercio> get comercios => _comercio;
  bool get cargando => _cargando;

  ComercioProvider() {
    cargarComercios();
  }

  Future<void> cargarComercios() async {
    _cargando = true;
    notifyListeners();

    try {
      _comercio = await _comercioService.fetchElementosComercio();
    } catch (error) {
      print('Error al cargar elementos: $error');
    }

    _cargando = false;
    notifyListeners();
  }
}

