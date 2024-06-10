// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

StockModel stockModelFromJson(String str) =>
    StockModel.fromJson(json.decode(str));

String stockModelToJson(StockModel data) => json.encode(data.toJson());

class StockModel {
  String id;
  String name;
  String type;
  String description;
  double price;
  int quantity;
  DateTime? expirationDate;
  DateTime? date;

  StockModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.quantity,
    this.expirationDate,
    this.date,
  });

  StockModel copyWith({
    String? id,
    String? name,
    String? type,
    String? description,
    double? price,
    int? quantity,
    DateTime? expirationDate,
    DateTime? date,
  }) =>
      StockModel(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        expirationDate: expirationDate ?? this.expirationDate,
        date: date ?? this.date,
      );

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        expirationDate: json["expirationDate"] != null
            ? DateTime.parse(json["expirationDate"])
            : null,
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "description": description,
        "price": price,
        "quantity": quantity,
        "expirationDate": expirationDate?.toIso8601String(),
        "date": date?.toIso8601String(),
      };
}
