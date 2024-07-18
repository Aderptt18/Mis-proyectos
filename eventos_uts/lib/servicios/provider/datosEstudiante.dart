import 'dart:async';

import 'package:flutter/material.dart';

class datosEstudiante with ChangeNotifier {
  String _nombre = 'nombre';
  String _correo = 'correo@correo.com';

  bool _registado= false;

  Future<void> setDatos(String nombre, String correo) async {
    _nombre = nombre;
    _correo = correo;
    _registado=!_registado;
    notifyListeners();
  }

  Future<void> setRegistro() async{
    _registado=!_registado;
    notifyListeners();
  }
 

  String getNombre() => _nombre;
  String getCorreo() => _correo;
  bool getRegistrado()=> _registado;
}
