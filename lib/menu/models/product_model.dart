// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String nameProduct;
  String category;
  String description;
  String urlPhoto;
  double price;
  bool status;
  double? promotionalPrice;

  ProductModel({
    required this.id,
    required this.nameProduct,
    required this.category,
    required this.description,
    required this.urlPhoto,
    required this.price,
    required this.status,
    this.promotionalPrice,
  });

  ProductModel copyWith({
    String? id,
    String? nameProduct,
    String? category,
    String? description,
    String? urlPhoto,
    double? price,
    bool? status,
    double? promotionalPrice,
  }) =>
      ProductModel(
        id: id ?? this.id,
        nameProduct: nameProduct ?? this.nameProduct,
        category: category ?? this.category,
        description: description ?? this.description,
        urlPhoto: urlPhoto ?? this.urlPhoto,
        price: price ?? this.price,
        status: status ?? this.status,
        promotionalPrice: promotionalPrice ?? this.promotionalPrice,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        nameProduct: json["nameProduct"],
        category: json["category"],
        description: json["description"],
        urlPhoto: json["urlPhoto"],
        price: json["price"]?.toDouble(),
        status: json["status"],
        promotionalPrice: json["promotionalPrice"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameProduct": nameProduct,
        "category": category,
        "description": description,
        "urlPhoto": urlPhoto,
        "price": price,
        "status": status,
        "promotionalPrice": promotionalPrice,
      };
}
