import 'package:app_distribuidora/screens/search_page.dart';
import 'package:flutter/material.dart';

class WidgetSearchHome extends StatefulWidget {
  const WidgetSearchHome({super.key});

  @override
  State<WidgetSearchHome> createState() => _WidgetSearchHomeState();
}

class _WidgetSearchHomeState extends State<WidgetSearchHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFFF5F5F5),
          height: 75,
          padding: const EdgeInsets.only(top: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Expanded(
                      child: Container(
                        height: 32,
                        width: 290,
                        // decoration: BoxDecoration(
                        //   boxShadow: [
                        //     BoxShadow(
                        //                     color: Colors.black.withOpacity(0.1),
                        //                     blurRadius: 2,
                        //                     spreadRadius: 1,
                        //                     offset: Offset(0, 2)),
                        //   ]
                        // ),
                        child: TextField(
                          readOnly:
                              true, // No es editable directamente, solo redirige
                          onTap: () {
                            // Redirige a la página de búsqueda
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()),
                            );
                          },
                          cursorColor: Colors.black,
                          cursorHeight: 18,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search,
                                size: 20, color: Colors.grey),
                            hintText: 'Buscar Productos',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Icon(Icons.shopping_cart_outlined,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
