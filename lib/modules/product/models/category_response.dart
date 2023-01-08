// ignore_for_file: file_names
import 'dart:convert';

import 'package:myapp/modules/product/models/category.dart';

class CategoryResponse {
  CategoryResponse({
    required this.estado,
    required this.resultados,
  });

  bool estado;
  List<Categoria> resultados;

  factory CategoryResponse.fromJson(String str) =>
      CategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponse.fromMap(Map<String, dynamic> json) {
    return CategoryResponse(
      estado: json["estado"],
      resultados: List<Categoria>.from(
        json["lista"].map(
          (x) => Categoria.fromMap(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "estado": estado,
      "lista": List<dynamic>.from(
        resultados.map(
          (x) => x.toMap(),
        ),
      ),
    };
  }
}
