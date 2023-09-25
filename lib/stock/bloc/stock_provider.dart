import 'package:app_restaurant_management/stock/models/stock_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:flutter/material.dart';

class StockProvider with ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<StockModel> _listStock = [];

  bool loadingStock = false;

  List<StockModel> get listStock => _listStock;
  set listStock(List<StockModel> list) {
    _listStock = list;
    notifyListeners();
  }

  //metodo para crear una nuevo gasto
  Future<void> addStock(String name, String type, String description,
      double price, int quantity) async {
    var uuid = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      loadingStock = true;
      await _db.collection("Stock").doc(uuid).set(StockModel(
              id: uuid,
              name: name,
              type: type,
              description: description,
              quantity: quantity,
              price: price,
              date: DateTime.now())
          .toJson());
      loadingStock = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para listar gasto
  Future<void> getAllStocks() async {
    try {
      loadingStock = true;
      var res = await _db.collection("Stock").get();
      var info = res.docs.map((e) => StockModel.fromJson(e.data())).toList();
      listStock = info;
      loadingStock = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para actualizar un gasto
  Future<void> updateStock(String id, DateTime date, String name, String type,
      String description, double price, int quantity) async {
    try {
      loadingStock = true;
      await _db.collection("Stock").doc(id).update(StockModel(
              id: id,
              date: date,
              name: name,
              type: type,
              description: description,
              price: price,
              quantity: quantity)
          .toJson());
      loadingStock = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para eliminar gasto
  Future<void> deleteStock(var id) async {
    try {
      loadingStock = true;
      _db.collection('Stock').doc(id).delete();
      loadingStock = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
