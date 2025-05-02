// lib/models/producto_model.dart

import 'dart:convert';

class ApiComercio {
  final String id;
  final String nombre;
  final String telefono;
  final String direccion;
  final String email;
  final List<String> imagenes;
  // Agrega otros campos que estén presentes en tu respuesta JSON

  ApiComercio({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.email,
    required this.imagenes,
  });

  factory ApiComercio.fromJson(Map<String, dynamic> json) {
    return ApiComercio(
      id: json['id']?.toString() ?? 'Sin ID',
      nombre: json['Nombre']?.toString() ?? 'Sin nombre',
      telefono: json['telefono']?.toString() ?? 'Sin estado',
      direccion: json['direccion']?.toString() ?? 'Sin direccion',
      email: json['email']?.toString() ?? 'Sin email',
      imagenes: List<String>.from(jsonDecode(json['imagenes'])),
      // Asigna otros campos aquí
    );
  }
}