// lib/models/producto_model.dart

class Categoria {
  final String idcategoria;
  final String nombre;
  final String estado;
  final String imagen;
  // Agrega otros campos que estén presentes en tu respuesta JSON

  Categoria({
    required this.idcategoria,
    required this.nombre,
    required this.estado,
    required this.imagen,
  });
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      idcategoria: json['idcategoria']?.toString() ?? 'Sin ID',
      nombre: json['nombre']?.toString() ?? 'Sin nombre',
      estado: json['estado']?.toString() ?? 'Sin estado',
      imagen: json['imagen']?.toString() ?? 'Sin imagen',
      // Asigna otros campos aquí
    );
  }
}
