
import 'package:app_distribuidora/screens/home_screen.dart';
import 'package:app_distribuidora/screens/register_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double alto = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: alto * 0.4, // Limitar la altura de la parte superior
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 10),
                    child: Text(
                      'Hola!\nInicia sesión!',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    width: double.infinity,
                    height: alto * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black, // Color del cursor
                            decoration: InputDecoration(
                              label: Text(
                                'Correo electrónico',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .black), // Línea negra cuando no está enfocado
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2), // Línea negra al enfocar
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                           obscureText: true,
                            cursorColor: Colors.black, // Color del cursor
                            decoration: InputDecoration(
                              label: Text(
                                'Contraseña',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .black), // Línea negra cuando no está enfocado
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2), // Línea negra al enfocar
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.black // Rojo brillante
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(height: 60),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                            },
                            child: Container(
                              height: 55,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 3,
                                      spreadRadius: 1,
                                      offset: Offset(0, 2)),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '¿No tienes una cuenta?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                RegisterScreen(),
                                          ));
                                    },
                                    child: Container(
                                      child: Text(
                                        'Registrarse',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
