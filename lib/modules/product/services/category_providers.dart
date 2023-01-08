// ignore_for_file: unused_import
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/modules/product/models/category.dart';
import 'package:myapp/modules/product/models/category_response.dart';

class CategoryProvider extends ChangeNotifier {
  final String _base = 'gestion.promo.ec';
  final String _key = "VHozaS85TU9uUnhTR2FpMWh0eUJCZz09";
  final String _value =
      "gAAAAABgAGpunQZzKslbNqIL71S6nhjanaqWYmni6w7Bv_i0nc49t4WyDc3X6fPWVYzx2Lg_3b8PabFJ5RUF2rS43OGWXQ-Yuw==";

  List<Categoria> categories = [];
  late Categoria _categoria;

  Categoria get categoria => _categoria;
  set categoria(Categoria value){
    _categoria = value;
    notifyListeners();
  }



  getCategories() async {
    var url = Uri.https(
      _base,
      'promo/categoria/ws/listar-categorias/',
      {
        _key.toString(): _value,
      },
    );
    final response = await http.get(url);
    final categoryResponse = CategoryResponse.fromJson(response.body);
    categories = categoryResponse.resultados;
    print("getCategories =  $categories");
    notifyListeners();
  }
}
