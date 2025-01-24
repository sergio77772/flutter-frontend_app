
import 'package:app_distribuidora/screens/login_screen.dart';
import 'package:app_distribuidora/screens/register_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreLogin extends StatefulWidget {
  const PreLogin({super.key});

  @override
  State<PreLogin> createState() => _PreloginState();
}

class _PreloginState extends State<PreLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: 400,
                 color: Colors.white,
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Container(
                    height: 40,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
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
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RegisterScreen(),
                        ));
                  },
                  child: Container(
                    height: 40,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(0, 2)),
                        ]
                      ),
                    child: Center(
                        child: Text(
                      'Registrarse',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,

                      ),
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RegisterScreen(),
                        ));
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 35,
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                       boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(0, 2)),
                        ]
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/logo_gg.png'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            'Continuar con Google',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RegisterScreen(),
                        ));
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 35,
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                       boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(0, 2)),
                        ]
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.asset('assets/logo_fb.png'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            'Continuar con Facebook',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RegisterScreen(),
                        ));
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 35,
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                       boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(0, 2)),
                        ]
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset('assets/logo_ap.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            'Continuar con Apple',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
