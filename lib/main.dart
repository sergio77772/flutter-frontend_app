import 'package:app_distribuidora/providers/categoria_provider.dart';
import 'package:app_distribuidora/providers/comercio_provider.dart';
import 'package:app_distribuidora/providers/login_provider.dart';
import 'package:app_distribuidora/providers/productos_provider.dart';
import 'package:app_distribuidora/providers/search_provider.dart';
import 'package:app_distribuidora/screens/home_screen.dart';
import 'package:app_distribuidora/screens/login_screen.dart';
import 'package:app_distribuidora/screens/pre_login.dart';
import 'package:app_distribuidora/screens/register_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> _checkLoginStatus() async {
    return await LoginProvider().checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoriasProvider()),
        ChangeNotifierProvider(create: (_) => ProductosProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ComercioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'App Distribuidora',
        home: FutureBuilder<bool>(
          future: _checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.data == true) {
              return const HomeScreen();
            } else {
              return const PreLogin();
            }
          },
        ),
        routes: {
          'login_screen': (context) => const LoginScreen(),
          'register_screen': (context) => const RegisterScreen(),
          'home_screen': (context) => const HomeScreen(),
        },
      ),
    );
  }
}