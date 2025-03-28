import 'package:app_distribuidora/screens/home_screen.dart';
import 'package:app_distribuidora/screens/pre_login.dart';
import 'package:app_distribuidora/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _email = ""; 
  String get userEmail => _email;

  String _name = ""; 
  String get userName => _name;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context, String email, String password) async {
    _setLoading(true);
    bool success = await LoginService.login(context, email, password);
    _setLoading(false);

    if (success) {
      await _saveLoginData(email);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }

  // Guarda laa sesión en sharedpre
  Future<void> _saveLoginData(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    
    _email = email; 
    notifyListeners();
  }

  // Cargar datos del usuario al iniciar la app (guardados en sharedpre)
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? "";
    _name = prefs.getString('nombre') ?? "Usuario"; 
    notifyListeners(); //notifica los cambios
  }

  // Verifica si ya se inicio sesion anteriormente
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Cerrar sesión
  Future<void> cerrarSesion(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _email = "";
    _name = "";
    notifyListeners();

    _showSnackbar(context, "Sesión cerrada.");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PreLogin()),
      (route) => false,
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
    );
  }
}
