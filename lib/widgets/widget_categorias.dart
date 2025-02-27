import 'package:app_distribuidora/models/categorias_model.dart';
import 'package:app_distribuidora/screens/categorias_screen.dart';
import 'package:app_distribuidora/services/categorias_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriasWidgetHome extends StatefulWidget {
  @override
  _CategoriasWidgetHomeState createState() => _CategoriasWidgetHomeState();
}

class _CategoriasWidgetHomeState extends State<CategoriasWidgetHome> {
  final CategoriasService _categoriasService =
      CategoriasService(); // Instancia del servicio
  List<Categoria> _categorias = [];

  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchCategorias();
  }

  Future<void> _fetchCategorias() async {
    if (!_hasMore) return;

    try {
      final newCategories =
          await _categoriasService.fetchCategorias(_page, _limit);
      setState(() {
        _categorias.addAll(newCategories);
        _page++;
        if (newCategories.length < _limit) _hasMore = false;
      });
    } catch (error) {
      print('Error al cargar categorías: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Limita las categorías a un máximo de 8.
    final displayedCategories = _categorias.take(8).toList();

    return Container(
      height: 118,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 23,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Categorias',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CategoriasScreen(),
                          ));
                    },
                    child: Container(
                      child: Text(
                        'Ver más',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 92, // Altura total del contenedor.
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontal.
              itemCount: displayedCategories.length,
              itemBuilder: (context, index) {
                var categoria = displayedCategories[index]; // Categoría actual.
                return Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Colors.black.withOpacity(0.05),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            'https://distribuidoraassefperico.com.ar${categoria.imagen}',
                            width: double.infinity,
                            height: 120,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.white,
                              );
                            },
                          ), // Si la imagen es null o vacía, no muestra nada
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Text(
                            categoria.nombre,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
