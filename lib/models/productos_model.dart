// lib/models/producto_model.dart

class Producto {
  final String id;
  final String descripcion;
  final String precioventa;
  final String imagen;
  final String descripcioncompleta;
    final String stock;
  // Agrega otros campos que estén presentes en tu respuesta JSON

  Producto({
    required this.id,
    required this.descripcion,
    required this.precioventa,
    required this.imagen,
    required this.descripcioncompleta,
    required this.stock,
  });
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id']?.toString() ?? 'Sin ID',
      descripcion: json['descripcion']?.toString() ?? 'Sin descripcion',
      precioventa: json['precioventa']?? '0.00',
      imagen: json['imagen']?.toString() ?? 'Sin imagen',
      descripcioncompleta: json['descripcioncompleta']?.toString() ?? 'Sin descripcion completa',
      stock: json['stock']?.toString() ?? 'Sin stock',
      // Asigna otros campos aquí
    );
  }
}
