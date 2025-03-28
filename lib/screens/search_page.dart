// intento 2
//mezclado
import 'package:app_distribuidora/providers/search_provider.dart';
import 'package:app_distribuidora/screens/detalles_productos.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();

    // Se usa un Future para que se ejecute después de que la pantalla se haya cargado completamente.
    Future.delayed(Duration.zero, () {
      if (mounted) {
        // Verifica que la pantalla aún esté activa antes de modificar el estado.
        final provider = Provider.of<SearchProvider>(context, listen: false);
        provider.searchFocusNode
            .requestFocus(); // Enfoca el campo de búsqueda automáticamente.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Barra de búsqueda
          Container(
            color: const Color(0xFFF5F5F5),
            height: 75,
            padding: const EdgeInsets.only(top: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 5.0),
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          searchProvider.clearSearch();
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left_outlined,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        child: SizedBox(
                          height: 32,
                          child: TextField(
                            controller: searchProvider.searchController,
                            focusNode: searchProvider.searchFocusNode,
                            onChanged: (value) {
                              searchProvider.searchProductos(value);
                            },
                            onSubmitted: (value) {
                              searchProvider.searchProductos(value);
                              searchProvider.addToHistorial(value);
                              FocusScope.of(context).unfocus();
                            },
                            cursorColor: Colors.black,
                            cursorHeight: 18,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.grey,
                              ),
                              suffixIcon:
                                  searchProvider
                                          .searchController
                                          .text
                                          .isNotEmpty
                                      ? GestureDetector(
                                        onTap: () {
                                          searchProvider.clearSearch();
                                          searchProvider.searchFocusNode
                                              .requestFocus();
                                        },
                                        child: const Icon(
                                          Icons.clear,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                      )
                                      : null, // Si el campo está vacío, no muestra el icono.
                              hintText: 'Buscar Productos',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Contenido principal
          Expanded(
            child: Column(
              children: [
                // Mostrar historial si el campo de búsqueda está vacío y hay elementos en el historial.
                if (searchProvider.searchController.text.isEmpty &&
                    searchProvider.searchHistory.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //vaciar historiall
                        //    Container(
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         'Historial de búsqueda',
                        //         style: TextStyle(fontWeight: FontWeight.bold),
                        //       ),
                        //       IconButton(
                        //         icon: const Icon(
                        //           Icons.delete,
                        //           color: Colors.grey,
                        //         ),
                        //         onPressed: () {
                        //           searchProvider.clearHistory();
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                          for (var query in searchProvider.searchHistory)
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(
                                  context,
                                ).unfocus(); // Oculta el teclado
                                searchProvider.searchController.text = query;
                                searchProvider.searchProductos(query);
                              },
                              child: Container(
                                width: double.infinity, // Ocupa todo el ancho
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    const Icon(
                                      Icons.history,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ), // Espaciado entre el ícono y el texto
                                    Expanded(
                                      // Hace que el texto ocupe el espacio restante
                                      child: Text(
                                        query,
                                        overflow:
                                            TextOverflow
                                                .ellipsis, // Evita desbordamientos largos
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        searchProvider.removeFromHistory(
                                          searchProvider.searchHistory.indexOf(
                                            query,
                                          ),
                                        ); // Elimina solo ese ítem
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                // Muestra si estan carganddo los productos
                if (searchProvider.isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.grey),
                    ),
                  ),

                // Muestra los resultadosde la busqueda.
                if (searchProvider.searchResultados.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: List.generate(searchProvider.searchResultados.length, (
                            index,
                          ) {
                            final producto =
                                searchProvider.searchResultados[index];
                            return GestureDetector(
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => DetallesProductos(
                                            producto: producto,
                                          ),
                                    ),
                                  ),
                              child: Column(
                                children: [

                                  Container(
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                          255,
                                          202,
                                          202,
                                          202,
                                        ),
                                        width: 0.2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://distribuidoraassefperico.com.ar${producto.imagen}',
                                              width: double.infinity,
                                              height: double.infinity,
                                              placeholder:
                                                  (
                                                    context,
                                                    url,
                                                  ) => const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Colors.grey,
                                                        ),
                                                  ),
                                              errorWidget:
                                                  (
                                                    context,
                                                    url,
                                                    error,
                                                  ) => SvgPicture.network(
                                                    'https://distribuidoraassefperico.com.ar/img/No_image_available.svg',
                                                    fit: BoxFit.cover,
                                                    placeholderBuilder:
                                                        (
                                                          context,
                                                        ) => const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                        ),
                                                    errorBuilder: (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return const Icon(
                                                        Icons.broken_image,
                                                        size: 120,
                                                        color: Colors.white,
                                                      );
                                                    },
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Text(
                                                producto.descripcion,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5,
                                              ),
                                              child: SizedBox(
                                                width: 200,
                                                child: Text(
                                                  producto.descripcioncompleta,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5,
                                              ),
                                              child: Text(
                                                '\$${producto.precioventa}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),

                // Muestra el text sin no se encontraron los productoss.
                if (searchProvider.searchController.text.isNotEmpty &&
                    searchProvider.searchResultados.isEmpty &&
                    !searchProvider.isLoading)
                  const Expanded(
                    child: Center(child: Text('No se encontraron productos')),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


