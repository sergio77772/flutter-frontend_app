import 'package:app_distribuidora/models/productos_model.dart';
import 'package:app_distribuidora/screens/detalles_productos.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_distribuidora/services/productos_service.dart';
import 'package:flutter_svg/svg.dart'; // Asegúrate de importar el servicio correcto.

class ProductoswidgetHome extends StatefulWidget {
  const ProductoswidgetHome({super.key});

  @override
  State<ProductoswidgetHome> createState() => _ProductoswidgetHomeState();
}

class _ProductoswidgetHomeState extends State<ProductoswidgetHome> {
  final ProductosService _productosService = ProductosService();
  List<Producto> _productos = [];
  int _paginaActual = 1;
  final int _productosPorPagina = 20;
  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  Future<void> _cargarProductos() async {
    if (_cargando) return;
    setState(() => _cargando = true);

    try {
      final nuevosProductos = await _productosService.fetchProductos(
          _paginaActual, _productosPorPagina);

      setState(() {
        _productos.addAll(nuevosProductos);
        _paginaActual++;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar productos: $error')),
      );
    } finally {
      setState(() => _cargando = false); // Finalizar la carga
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          // Lista de productos
          GestureDetector(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Wrap(
                children: List.generate(_productos.length, (index) {
                  final producto = _productos[index];
                  return GestureDetector(
                    onTap: () {
                      // Acción al tocar un producto
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                DetallesProductos(producto: producto),
                          ),
                        );
                      },
                      child: Container(
                        width: 170, // 2 por fila
                        height: 240,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 232, 232, 232),
                            width: 0.2,
                          ),
                        ),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 150,
                                    width: 150,
                                    color: Colors.white,
                                    child:
                                        // Image.network(
                                        //   'https://distribuidoraassefperico.com.ar${producto.imagen}',
                                        //   width: double.infinity,
                                        //   errorBuilder: (context, error, stackTrace) {
                                        //     return SvgPicture.network(
                                        //       'https://distribuidoraassefperico.com.ar/img/No_image_available.svg',
                                        //       fit: BoxFit.cover,
                                        //       // placeholderBuilder: (context) =>
                                        //       //     const CircularProgressIndicator(), // Indicador de carga opcional
                                        //       errorBuilder:
                                        //           (context, error, stackTrace) {
                                        //         return Icon(
                                        //           Icons.broken_image,
                                        //           size: 120,
                                        //           color: Colors.white,
                                        //         );
                                        //       },
                                        //     );
                                        //   },
                                        // ),
                                        CachedNetworkImage(
                                      imageUrl:
                                          'https://distribuidoraassefperico.com.ar${producto.imagen}',
                                      // fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.grey),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          SvgPicture.network(
                                        'https://distribuidoraassefperico.com.ar/img/No_image_available.svg',
                                        fit: BoxFit.cover,
                                        placeholderBuilder: (context) =>
                                            const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.black),
                                        ),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.broken_image,
                                            size: 120,
                                            color: Colors.white,
                                          );
                                        },
                                      ),
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  child: Text(
                                    producto.descripcion,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  height: 25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '\$${producto.precioventa}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          if (!_cargando) // Si no está cargando, mostrar botón
            Padding(
              padding: const EdgeInsets.all(10),

              // child: GestureDetector(
              //   onTap: _cargarProductos,
              //   child: Container(
              //     height: 40,
              //     width: 100,
              //     child: Center(
              //         child: Text(
              //       'Ver más',
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.w400,
              //         color: Colors.black54,
              //       ),
              //     )),
              //   ),
              // ),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: _cargarProductos,
                child: const Text(
                  'Ver más',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          // Indicador de carga
          // if (_cargando)
          //   const Padding(
          //     padding: EdgeInsets.all(10),
          //     child: CircularProgressIndicator(),
          //   ),
        ],
      ),
    );
  }
}
