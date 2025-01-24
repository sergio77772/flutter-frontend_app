// import 'package:app_distribuidora/services/categoria_service.dart';
// import 'package:flutter/material.dart';

// class CategoriasScreen extends StatefulWidget {
//   const CategoriasScreen({super.key});

//   @override
//   State<CategoriasScreen> createState() => _CategoriasScreenState();
// }

// class _CategoriasScreenState extends State<CategoriasScreen> {
//   final CategoriasService _categoriasService = CategoriasService();
//   List<dynamic> _categories = [];
//   int _page = 1;
//   final int _limit = 10;
//   bool _hasMore = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchCategorias();
//   }

//   Future<void> _fetchCategorias() async {
//     if (!_hasMore) return;

//     try {
//       final newCategories = await _categoriasService.fetchCategorias(_page, _limit);
//       setState(() {
//         _categories.addAll(newCategories);
//         _page++;
//         if (newCategories.length < _limit) _hasMore = false;
//       });
//     } catch (error) {
//       print('Error al cargar categorías: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;

//     final displayedCategories = _categories; // limitar cantidas usandoo .take()`

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.grey),
//         ),
//         backgroundColor: Colors.white,
//         title: const Padding(
//           padding: EdgeInsets.only(left: 60),
//           child: Text(
//             'Categorías',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         height: height,
//         width: width,
//         color: const Color(0xFFF5F5F5),
//         padding: const EdgeInsets.all(8.0),
//         child: Wrap(
//           spacing: 8.0, // Espacio horizontal entre elementos.
//           runSpacing: 8.0, // Espacio vertical entre filas.
//           children: List.generate(
//             displayedCategories.length, // Mostramos todas las categorías.
//             (index) {
//               var categoria = displayedCategories[index];
//               return Container(
//                 clipBehavior: Clip.antiAlias,
//                 height: 110,
//                 width: (width - 32) / 3, // Divide el ancho en tres columnas.
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 2,
//                       spreadRadius: 1,
//                       color: Colors.black.withOpacity(0.05),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5),
//                       child: Container(
//                         height: 70,
//                         width: 70,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: BoxDecoration(
//                           color: Colors.amber,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.network(
//                           categoria['imagen'] ?? '',
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) =>
//                               const Icon(Icons.broken_image, size: 40, color: Color.fromARGB(255, 211, 210, 210)),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Container(
//                       color: Colors.blue,
//                       width: 110,
//                       height: 25,
//                       child: Text(
//                         categoria['nombre'] ?? '',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey[500],
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:app_distribuidora/services/categorias_service.dart';
import 'package:flutter/material.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  final CategoriasService _categoriasService = CategoriasService();
  List<dynamic> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategorias();
  }

  Future<void> _fetchCategorias() async {
    try {
      final allCategories = await _categoriasService.fetchCategorias(1, 50);
      setState(() {
        _categories = allCategories;
      });
    } catch (error) {
      print('Error al cargar categorías: $error');
    } finally {
      setState(() {
        _isLoading =
            false; // Cambia el estado de carga a `false` cuando termine.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _isLoading
          ? Container(
              color: const Color(0xFFF5F5F5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            )
          : Container(
              height: height,
              width: width,
              color: const Color(0xFFF5F5F5),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.grey),
                          ),
                          const SizedBox(width: 80),
                          const Text(
                            'Categorías',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 8, right: 8, bottom: 8),
                            child: Wrap(
                              spacing: 3.0,
                              runSpacing: 3.0,
                              children: List.generate(
                                _categories.length,
                                (index) {
                                  var categoria = _categories[index];
                                  return Container(
                                    margin: const EdgeInsets.all(3.0),
                                    clipBehavior: Clip.antiAlias,
                                    width: (width - 40) / 3,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1,
                                          spreadRadius: 2,
                                          color: Colors.black.withOpacity(0.03),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Container(
                                            height: 70,
                                            width: 90,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Image.network(
                                              categoria['imagen'] ?? '',
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Icon(Icons.broken_image,
                                                      size: 40,
                                                      color: Color.fromARGB(
                                                          255, 211, 210, 210)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          color: Colors.white,
                                          width: 115,
                                          height: 35,
                                          child: Center(
                                            child: Text(
                                              categoria['nombre'] ?? '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
