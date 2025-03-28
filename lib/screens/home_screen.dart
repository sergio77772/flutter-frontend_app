import 'package:app_distribuidora/screens/favoritos_screen.dart';
import 'package:app_distribuidora/screens/notificaciones_screen.dart';
import 'package:app_distribuidora/screens/perfil_usuario_screen.dart';
import 'package:app_distribuidora/widgets/widget_categorias.dart';
import 'package:app_distribuidora/widgets/widget_productos.dart';
import 'package:app_distribuidora/widgets/widget_search_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;


  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          if (currentIndex == 0) homeScreen(height, width),
          if (currentIndex == 1) const FavoritosScreen(),
          if (currentIndex == 2) const NotificacionesScreen(),
          if (currentIndex == 3) const PerfilUsuarioScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: Colors.grey[200],
            indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            height: 50,
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(color: Colors.black, size: 26);
              }
              return IconThemeData(color: Colors.grey[500], size: 23);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black);
              }
              return TextStyle(fontSize: 8, fontWeight: FontWeight.w400, color: Colors.grey[600]);
            }),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 5),
            child: NavigationBar(
              destinations: [
                NavigationDestination(icon: Icon(MaterialSymbols.home), label: 'Inicio'),
                NavigationDestination(icon: Icon(MaterialSymbols.favorite), label: 'Favoritos'),
                NavigationDestination(icon: Icon(MaterialSymbols.notifications), label: 'Notificaciones'),
                NavigationDestination(icon: Icon(Icons.menu), label: 'Más'),
              ],
              onDestinationSelected: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              selectedIndex: currentIndex,
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
          WidgetSearchHome(),
       
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5,),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CategoriasWidgetHome(),
                  SizedBox(height: 10),
                  ProductoswidgetHome(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}  




