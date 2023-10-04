// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:app_restaurant_management/menu/models/product_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String id;
  DateTime? dateTime;
  List<Product>? products;
  double discount;
  String note;
  String status;
  String client;
  String typeOrder;
  int table;
  String address;
  String cellphone;
  double total;
  String noteRejection;

  OrderModel({
    this.id = "",
    this.dateTime,
    this.products,
    this.discount = 0,
    this.note = "",
    this.status = "",
    this.client = "",
    this.typeOrder = "",
    this.table = 0,
    this.address = "",
    this.cellphone = "",
    this.total = 0,
    this.noteRejection = "",
  });

  OrderModel copyWith({
    String? id,
    int? idOrder,
    DateTime? dateTime,
    DateTime? time,
    List<Product>? products,
    double? discount,
    String? note,
    String? status,
    String? client,
    String? typeOrder,
    int? table,
    String? address,
    String? cellphone,
    double? total,
    String? noteRejection,
  }) =>
      OrderModel(
        id: id ?? this.id,
        dateTime: dateTime ?? this.dateTime,
        products: products ?? this.products,
        discount: discount ?? this.discount,
        note: note ?? this.note,
        status: status ?? this.status,
        client: client ?? this.client,
        typeOrder: typeOrder ?? this.typeOrder,
        table: table ?? this.table,
        address: address ?? this.address,
        cellphone: cellphone ?? this.cellphone,
        total: total ?? this.total,
        noteRejection: noteRejection ?? this.noteRejection,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        dateTime: DateTime.tryParse(json["date"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        discount: json["discount"]?.toDouble() ?? 0,
        note: json["note"] ?? "",
        status: json["status"],
        client: json["client"],
        typeOrder: json["typeOrder"],
        table: json["table"] ?? 0,
        address: json["address"] ?? "",
        cellphone: json["cellphone"] ?? "",
        total: json["total"]?.toDouble(),
        noteRejection: json["noteRejection"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": dateTime!.toIso8601String(),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "discount": discount,
        "note": note,
        "status": status,
        "client": client,
        "typeOrder": typeOrder,
        "table": table,
        "address": address,
        "cellphone": cellphone,
        "total": total,
        "noteRejection": noteRejection,
      };
}

class Product {
  ProductModel product;
  int quantity;
  double total;

  Product({
    required this.product,
    required this.quantity,
    required this.total,
  });

  Product copyWith({
    ProductModel? product,
    int? quantity,
    double? total,
  }) =>
      Product(
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        product: ProductModel.fromJson(json['product']),
        quantity: json["quantity"],
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "total": total,
      };
}
