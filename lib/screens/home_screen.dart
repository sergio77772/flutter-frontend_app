import 'package:app_distribuidora/screens/categorias_screen.dart';
import 'package:app_distribuidora/services/categorias_service.dart';
import 'package:app_distribuidora/widgets/widget_search_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoriasService _categoriasService = CategoriasService();
  List<dynamic> _categories = [];
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;

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
        _categories.addAll(newCategories);
        _page++;
        if (newCategories.length < _limit) _hasMore = false;
      });
    } catch (error) {
      print('Error al cargar categorías: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        height: height,
        width: width,
        child: Column(
          children: [
            widget_search_home(), // Widget de búsqueda.
            const SizedBox(height: 10),
            Container(
              height: 130,
              width: 330,
              color: Colors.white, // Placeholder para otro contenido.
            ),
            const SizedBox(height: 10),
            Categorias(
              categories: _categories,
            ),
          ],
        ),
      ),
    );
  }
}

class Categorias extends StatelessWidget {
  final List categories; // Lista de categorías.

  const Categorias({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    // Limita las categorías a un máximo de 10.
    final displayedCategories = categories.take(8).toList();

    return Container(
      height: 110,
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
        
            height: 85, // Altura total del contenedor.
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontal.
              itemCount: displayedCategories
                  .length, // Solo las primeras 10 categorías.
              itemBuilder: (context, index) {
                var categoria = displayedCategories[index]; // Categoría actual.
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
           
                    padding: EdgeInsets.only(top: 5),
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
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
                            categoria['imagen'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image,
                                    size: 40,
                                    color: Color.fromARGB(255, 211, 210, 210)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                    
                          child: Text(
                            categoria['nombre'],
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
