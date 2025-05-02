import 'package:flutter/material.dart';
import 'package:app_distribuidora/providers/comercio_provider.dart';
import 'package:provider/provider.dart';

class WidgetImgsComercio extends StatelessWidget {
  const WidgetImgsComercio({super.key});

  @override
  Widget build(BuildContext context) {
    final comercioProvider = Provider.of<ComercioProvider>(context);
    final comercio = comercioProvider.comercios.isNotEmpty
        ? comercioProvider.comercios.first
        : null;

    if (comercio == null) return const SizedBox();

    final imagenes = comercio.imagenes
        .map((img) => 'https://distribuidoraassefperico.com.ar${img.replaceAll(r'\/', '/')}').toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 55,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: PageView(
          children: imagenes
              .map((url) => Image.network(
                    url,
                    fit: BoxFit.cover,
                  ))
              .toList(),
        ),
      ),
    );
  }
}



