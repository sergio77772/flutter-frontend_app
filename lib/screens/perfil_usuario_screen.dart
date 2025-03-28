import 'package:app_distribuidora/providers/login_provider.dart';
import 'package:app_distribuidora/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilUsuarioScreen extends StatefulWidget {
  const PerfilUsuarioScreen({super.key});

  @override
  State<PerfilUsuarioScreen> createState() => _PerfilUsuarioScreenState();
}

class _PerfilUsuarioScreenState extends State<PerfilUsuarioScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar datos del usuario al abrir la pantalla
    Provider.of<LoginProvider>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 30, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loginProvider.userName.isNotEmpty
                              ? loginProvider.userName
                              : 'Usuario',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Mostramos el email del usuario guardado
                        Text(
                          loginProvider.userEmail.isNotEmpty
                              ? loginProvider.userEmail
                              : 'No hay usuario registrado',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.black),
              title: Text('Pedidos'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.credit_card, color: Colors.black),
              title: Text('Métodos de pago'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help_outline, color: Colors.black),
              title: Text('Ayuda y soporte'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Acerca de Distribuidora ASSEF Perico',
                style: TextStyle(fontSize: 13),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Cerrar sesión',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ), // Ajusta el radio si lo deseas
                      title: Text('Cerrar Sesión'),
                      content: Text('¿Desea cerrar sesión?'),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancelar',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(width: 8),
                            TextButton(
                              onPressed: () {
                                Provider.of<LoginProvider>(context, listen: false, ).cerrarSesion(context);
                                Provider.of<SearchProvider>(context, listen: false, ).clearHistorial();
                              },
                              child: Text(
                                'Aceptar',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              // onTap: () {
              //   Provider.of<LoginProvider>(context, listen: false).cerrarSesion(context);
              //   Provider.of<SearchProvider>(context, listen: false).clearHistorial();
              // },
            ),
          ],
        ),
      ),
    );
  }
}
