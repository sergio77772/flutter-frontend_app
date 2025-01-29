import 'package:flutter/material.dart';

Widget widget_search_home() {
  return Container(
    height: 70,
    child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 5, right: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                  // decoration: BoxDecoration(
                  //   boxShadow: [
                  //     BoxShadow(
                  //                     color: Colors.black.withOpacity(0.1),
                  //                     blurRadius: 2,
                  //                     spreadRadius: 1,
                  //                     offset: Offset(0, 2)),
                  //   ]
                  // ),
                    height: 32,
                    width: 290,
                    child: TextField(
                      cursorColor: Colors.black,
                      cursorHeight: 18, // Color del cursor
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey,
                        ),
                        hintText: 'Buscar Productos',
                        hintStyle: TextStyle(
                            color: Colors.grey, // Cambia el color aquí
                            fontSize: 16,
                            fontWeight: FontWeight
                                .w400 // También puedes ajustar el tamaño de fuente
                            ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: Colors.grey), // Borde por defecto
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: Colors
                                  .white), // Borde cuando no está enfocado
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 2), // Borde cuando está enfocado
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    // color: Colors.white,
                    height: 30,
                    width: 30,
                    child: Icon(Icons.shopping_cart_outlined, color: Colors.black,), 
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
