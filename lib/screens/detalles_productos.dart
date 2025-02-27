import 'package:app_distribuidora/models/productos_model.dart';
import 'package:app_distribuidora/widgets/widget_searchDP.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetallesProductos extends StatelessWidget {
  final Producto producto;

  const DetallesProductos({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    var width =
        MediaQuery.of(context).size.width; // Obtiene el ancho de la pantalla
    var height =
        MediaQuery.of(context).size.height; // Obtiene la altura de la pantalla

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WidgetSearchDP(),
          Expanded(
            child: Container(
              color: Colors.white,
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                child: Image.network(
                                  'https://distribuidoraassefperico.com.ar${producto.imagen}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SvgPicture.network(
                                      'https://distribuidoraassefperico.com.ar/img/No_image_available.svg',
                                      fit: BoxFit.cover,
                                      // placeholderBuilder: (context) =>
                                      //     const CircularProgressIndicator(), // Indicador de carga opcional
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(
                                          Icons.broken_image,
                                          size: 120,
                                          color: Colors.white,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: 320,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            producto.descripcion,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                        child: Text(
                                          '\$${producto.precioventa}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 320,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Stock disponible: ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .grey, // Texto en gris
                                                ),
                                              ),
                                              TextSpan(
                                                text: producto.stock,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .green, // Texto en negro
                                                ),
                                              ),

                                              //                                             TextSpan(
                                              //   text: (producto['stock'] != null && double.tryParse(producto['stock']) != null)
                                              //       ? (double.parse(producto['stock']).toInt() > 0
                                              //           ? double.parse(producto['stock']).toInt().toString()
                                              //           : 'Sin Stock')
                                              //       : 'Sin Stock',
                                              //   style: TextStyle(
                                              //     fontSize: 14,
                                              //     fontWeight: FontWeight.w500,
                                              //     color: (producto['stock'] != null && double.tryParse(producto['stock']) != null && double.parse(producto['stock']).toInt() > 0)
                                              //         ? Colors.green // Verde si hay stock
                                              //         : Colors.red,  // Rojo si no hay stock
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: 40,
                                      width: 320,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 3,
                                                spreadRadius: 1,
                                                offset: Offset(0, 2)),
                                          ]),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 80,
                                            child: Center(
                                              child: Text(
                                                'Cantidad:',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 110,
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[200],
                                            ),
                                            height: 30,
                                            width: 30,
                                            child: Icon(Icons.add),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[200],
                                            ),
                                            height: 30,
                                            width: 30,
                                            child: Icon(Icons.remove),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(
                                              255, 106, 160, 255),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 3,
                                                spreadRadius: 1,
                                                offset: Offset(0, 2)),
                                          ]),
                                      child: Center(
                                          child: Text(
                                        'Comprar ahora',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(
                                              255, 226, 236, 253),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 3,
                                                spreadRadius: 1,
                                                offset: Offset(0, 2)),
                                          ]),
                                      child: Center(
                                          child: Text(
                                        'Agregar al carrito',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              255, 106, 160, 255),
                                        ),
                                      )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Descripcion:',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      width: 320,
                                      child: Text(
                                        producto.descripcioncompleta,
                                        maxLines: 100,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
