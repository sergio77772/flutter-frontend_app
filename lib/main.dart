import 'package:app_distribuidora/providers/categoria_provider.dart';
import 'package:app_distribuidora/screens/home_screen.dart';
import 'package:app_distribuidora/screens/login_screen.dart';
import 'package:app_distribuidora/screens/pre_login.dart';
import 'package:app_distribuidora/screens/register_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoriasProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Productos',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => PreLogin(),
          'login_screen': (BuildContext context) => LoginScreen(),
          'register_screen': (BuildContext context) => RegisterScreen(),
          'home_screen': (BuildContext context) => HomeScreen(),
        });
  }
}
