// To parse this JSON data, do
//
//     final categoryResponsive = categoryResponsiveFromMap(jsonString);

import 'dart:convert';

import 'package:myapp/modules/product/models/producto.dart';

class ProductResponsive {
  ProductResponsive({
    required this.estado,
    required this.productos,
  });

  bool estado;
  List<Producto> productos;

  factory ProductResponsive.fromJson(String str) =>
      ProductResponsive.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponsive.fromMap(Map<String, dynamic> json) =>
      ProductResponsive(
        estado: json["estado"],
        productos: List<Producto>.from(
          json["productos"].map(
            (x) => Producto.fromMap(x),
          ),
        ),
      );

  Map<String, dynamic> toMap() => {
        "estado": estado,
        "productos": List<dynamic>.from(
          productos.map(
            (x) => x.toMap(),
          ),
        ),
      };
}
