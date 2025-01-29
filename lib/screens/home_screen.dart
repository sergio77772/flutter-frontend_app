import 'package:app_distribuidora/screens/favoritos_screen.dart';
import 'package:app_distribuidora/screens/notificaciones_screen.dart';
import 'package:app_distribuidora/services/categorias_service.dart';
import 'package:app_distribuidora/widgets/widget_categorias.dart';
import 'package:app_distribuidora/widgets/widget_search_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';

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
// Para controlar la pestaña seleccionada en la barra de navegación.
  int currentIndex = 0;

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
      body: Stack(
        children: [
          // Cambia el contenido mostrado según la pestaña seleccionada.
          if (currentIndex == 0) homeScreen(height, width),
          if (currentIndex == 1) const FavoritosScreen(),
          if (currentIndex == 2) const NotificacionesScreen(),
          if (currentIndex == 3) const Center(child: Text('Perfil de usuario')),
        ],
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: Colors.grey[200],

            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

            height: 50,
            // Personalización de los íconos.
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(
                    color: Colors.black, size: 26); // Ícono seleccionado.
              }
              return IconThemeData(
                  color: Colors.grey[500], size: 23); // Ícono no seleccionado.
            }),
            // Personalización del texto de las pestañas.
            labelTextStyle:
                WidgetStateProperty.resolveWith<TextStyle>((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                );
              }
              return TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              );
            }),
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: 5,
            ),
            child: NavigationBar(
              destinations: [
                // Define cada pestaña con su ícono y etiqueta.
                NavigationDestination(
                  icon: Icon(MaterialSymbols.home),
                  label: 'Inicio',
                ),
                NavigationDestination(
                  icon: Icon(MaterialSymbols.favorite),
                  label: 'Favoritos',
                ),
                NavigationDestination(
                  icon: Icon(MaterialSymbols.notifications),
                  label: 'Notificaciones',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu),
                  label: 'Más',
                ),
              ],
              onDestinationSelected: (int index) {
                // Cambia la pestaña seleccionada cuando el usuario toca una opción.
                setState(() {
                  currentIndex = index;
                });
              },
              selectedIndex: currentIndex, // Marca la pestaña activa.
            ),
          ),
        ),
      ),
    );
  }

  Widget homeScreen(double height, double width) {
    return Container(
      color: const Color(0xFFF5F5F5),
      height: height,
      width: width,
      child: Column(
        children: [
          widget_search_home(), // Widget de búsqueda.
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 130,
                    width: 330,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            spreadRadius: 1,
                          )
                        ]),
                  ),
                  const SizedBox(height: 10),
                  Categorias(
                    categories: _categories,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Productos(
                  //   categories: _categories,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class Productos extends StatelessWidget {
//   final List categories; // Lista de categorías.

//   const Productos({
//     super.key,
//     required this.categories,

//   });

//   @override
//   Widget build(BuildContext context) {
//     // Limita las categorías al número máximo permitido. usando .take
//     final displayedCategories = categories.toList();

//     return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 8),
//     child: Container(

//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white,
//           border: Border.all(
//               color: const Color.fromARGB(255, 202, 202, 202), width: 0.5),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               blurRadius: 6,
//               spreadRadius: 1,
//             )
//           ]),
//       child: Column(
//         children: [

//           Wrap(
//             children: List.generate(
//               displayedCategories.length, // Usa el número limitado de categorías.
//                 (index) {
//                   final categoria = displayedCategories[index];
//                 return GestureDetector(
//                   onTap: () {
//                   },
//                   child: Container(
//                     width: 170,
//                     height: 240, // 2  por fila
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(0),
//                       border: Border.all(
//                           color: const Color.fromARGB(255, 202, 202, 202),
//                           width: 0.2),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10, left: 8,right: 8),
//                           child: Container(
//                             child: Image.network(
//                             'https://distribuidoraassefperico.com.ar${categoria['imagen']}', // Concatenar correctamente la URL base con la ruta de la imagen
//                             fit: BoxFit.cover,

//                           ),
//                           ),
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(left: 5, top: 5, right: 5),
//                           child: Container(
//                             width: double.infinity,
//                             child: Text(
//                               categoria['nombre'] ?? 'Sin nombre',
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 child: Text(
//                                   '\$${categoria['price'].toString()}',
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),

//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
//   }
// }

