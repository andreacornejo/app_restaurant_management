import 'package:app_restaurant_management/stock/models/stock_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:flutter/material.dart';

class StockProvider with ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<StockModel> _listStock = [];

  double _expenses = 0.0;

  bool loadingStock = false;

  String _dateStart = DateTime.now().toString();
  String _dateEnd = DateTime.now().toString();

  init() {
    listStock = [];
    loadingStock = false;
    expenses = 0;
    dateStart = DateTime.now().toString();
    dateEnd = DateTime.now().toString();
  }

  double get expenses => _expenses;
  set expenses(double state) {
    _expenses = state;
    notifyListeners();
  }

  String get dateStart => _dateStart;
  set dateStart(String state) {
    _dateStart = state;
    notifyListeners();
  }

  String get dateEnd => _dateEnd;
  set dateEnd(String state) {
    _dateEnd = state;
    notifyListeners();
  }

  List<StockModel> get listStock => _listStock;
  set listStock(List<StockModel> list) {
    _listStock = list;
    notifyListeners();
  }

  //metodo para obtener el total de todas las ordenes
  double getTotalExpenses() {
    for (var stock in listStock) {
      double total = stock.price;
      expenses += total;
    }
    return expenses;
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
      var res =
          await _db.collection("Stock").orderBy('date', descending: true).get();
      var info = res.docs.map((e) => StockModel.fromJson(e.data())).toList();
      listStock = info;
      loadingStock = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para listar gasto
  Future<void> getAllStocksByDate() async {
    try {
      loadingStock = true;
      var res = await _db
          .collection("Stock")
          .where('date',
              isGreaterThanOrEqualTo:
                  DateTime.parse(dateStart).toIso8601String())
          .where('date',
              isLessThanOrEqualTo: DateTime.parse(dateEnd).toIso8601String())
          .orderBy('date', descending: true)
          .get();
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

  clearListStock() {
    listStock = [];
    loadingStock = false;
    expenses = 0;
  }
}
