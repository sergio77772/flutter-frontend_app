import 'package:app_distribuidora/providers/categoria_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {


  @override
  Widget build(BuildContext context) {
    final categoriasProvider = Provider.of<CategoriasProvider>(context);
    final categorias = categoriasProvider.categorias;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
    return Scaffold(      
      body:  Container(
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
                                  // displayedCategories.length, // muestra la cantidad de categorias que quiera.
                                categorias.length,
                                (index) {
                                  var categoria = categorias[index];
                                  return Container(
                                    margin: const EdgeInsets.all(3.0),
                                    clipBehavior: Clip.antiAlias,
                                    width: (width - 40) / 3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1,
                                          spreadRadius: 2,
                                          color: Colors.black.withOpacity(0.1),
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
                                            height: 90,
                                            width: 100,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            //                   child: Image.network(
                                            //   'https://distribuidoraassefperico.com.ar${categoria['imagen']}', // Concatenar correctamente la URL base con la ruta de la imagen
                                            // ),
                                            child:
                                            // Image.network(
                                            //   'https://distribuidoraassefperico.com.ar${categoria.imagen}',
                                            //   fit: BoxFit.cover,
                                            //   errorBuilder:
                                            //       (context, error, stackTrace) {
                                            //     return const Icon(
                                            //       Icons.broken_image,
                                            //       size: 90,
                                            //       color: Colors.white,
                                            //     );
                                            //   },
                                            // ), 
                                            CachedNetworkImage(
                                                imageUrl:
                                                    'https://distribuidoraassefperico.com.ar${categoria.imagen}',
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(color: Colors.black,),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                  Icons.broken_image,
                                                  size: 90,
                                                  color: Colors.white,
                                                ),
                                              )// Si la imagen es null o vacía, no muestra nada
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          color: Colors.grey[100],
                                          width: 115,
                                          height: 35,
                                          child: Center(
                                            child: Text(
                                              categoria.nombre,
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
