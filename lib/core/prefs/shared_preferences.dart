import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs; // Declare _prefs as late.

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre

  String get usuario {
    return _prefs.getString('usuario') ?? '';
  }

  set usuario(String value) {
    _prefs.setString('usuario', value);
  }

  // GET y SET de la última página
}
