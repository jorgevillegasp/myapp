// ignore_for_file: unused_import
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/modules/aut/models/usuario.dart';
import 'package:myapp/shared/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  static const String _usuario = "admin";
  static const  String _contrasenia = "admin";

  Future<bool> iniciarSesion(Usuario user) async {
    if (user.usuario == _usuario && user.contrasenia == _contrasenia) {
      //Generamos el token cualquiera
      //Lo almacenamos en la cache
      Preferences.token = 'wehufvdbsuyfghsifsdf';
      Preferences.usuario = user.usuario;
      return true;
    }
    notifyListeners();
    return false;
  }
}
