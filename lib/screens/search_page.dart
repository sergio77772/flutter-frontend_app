import 'package:app_distribuidora/models/productos_model.dart';
import 'package:app_distribuidora/screens/detalles_productos.dart';
import 'package:app_distribuidora/services/search_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final SearchService _searchService = SearchService();
  List<Producto> _searchResultados = [];
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  Future<void> _searchProducts(String query) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final results = await _searchService.searchProducts(query);
      setState(() {
        _searchResultados = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
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
                      SizedBox(width: 5.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Icon(Icons.keyboard_arrow_left_outlined,
                              size: 30, color: Colors.grey),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Container(
                          height: 32,
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            onChanged: (value) {
                              setState(() {});
                              _searchProducts(value);
                            },
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              _searchFocusNode.unfocus();
                              _searchProducts(value);
                            },
                            cursorColor: Colors.black,
                            cursorHeight: 18,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.search,
                                  size: 20, color: Colors.grey),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        _searchController.clear();
                                        setState(() {});
                                      },
                                      child: const Icon(Icons.clear,
                                          size: 20, color: Colors.grey),
                                    )
                                  : null,
                              hintText: 'Buscar Productos',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) ...[
            Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Colors.grey),
              ),
            ),
          ] else if (_hasError) ...[
            const Center(child: Text('Error al cargar productos')),
          ] else if (_searchResultados.isNotEmpty) ...[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: List.generate(
                      _searchResultados.length,
                      (index) {
                        final producto = _searchResultados[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    DetallesProductos(producto: producto),
                              ),
                            );
                          },
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
                                        255, 202, 202, 202),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        color: Colors.white,
                                        child: Image.network(
                                          'https://distribuidoraassefperico.com.ar${producto.imagen}',
                                          width: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return SvgPicture.network(
                                              'https://distribuidoraassefperico.com.ar/img/No_image_available.svg',
                                              fit: BoxFit.cover,
                                              // placeholderBuilder: (context) =>
                                              //     const CircularProgressIndicator(), // Indicador de carga opcional
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.broken_image,
                                                  size: 70,
                                                  color: Colors.white,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
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
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: SizedBox(
                                            width: 200,
                                            child: Text(
                                              producto.descripcioncompleta,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
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
                      },
                    ),
                  ),
                ),
              ),
            ),
          ] else if (_searchController.text.isNotEmpty) ...[
            const Center(child: Text('No se encontraron productos')),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
