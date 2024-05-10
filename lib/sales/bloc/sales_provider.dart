import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:flutter/material.dart';

class SalesProvider with ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<OrderModel> _listSales = [];

  List<Product> _listProduct = [];

  double _incomes = 0.0;
  double _balance = 0.0;

  String _dateStart = DateTime.now().toString();
  String _dateEnd = DateTime.now().toString();

  OrderModel? _currentOrder;

  bool _loadingSale = false;
  int _items = 0;

  List<Product> get listProduct => _listProduct;

  set listProduct(List<Product> list) {
    _listProduct = list;
    notifyListeners();
  }

  OrderModel? get currentOrder => _currentOrder;
  set currentOrder(OrderModel? data) {
    _currentOrder = data;
    notifyListeners();
  }

  bool get loadingSale => _loadingSale;
  set loadingSale(bool state) {
    _loadingSale = state;
    notifyListeners();
  }

  int get items => _items;
  set items(int state) {
    _items = state;
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

  double get incomes => _incomes;
  set incomes(double state) {
    _incomes = state;
    notifyListeners();
  }

  double get balance => _balance;
  set balance(double state) {
    _balance = state;
    notifyListeners();
  }

  List<OrderModel> get listSales => _listSales;
  set listSales(List<OrderModel> list) {
    _listSales = list;
    notifyListeners();
  }

  init() {
    listSales = [];
    listProduct = [];
    incomes = 0;
    balance = 0;
    dateStart = DateTime.now().toString();
    dateEnd = DateTime.now().toString();
    items = 0;
    loadingSale = false;
    currentOrder = null;
  }

  //metodo para listar ventas
  Future<void> getAllSales() async {
    try {
      loadingSale = true;
      var res =
          await _db.collection("Order").orderBy('date', descending: true).get();
      var infoOrders =
          res.docs.map((e) => OrderModel.fromJson(e.data())).toList();
      listSales =
          infoOrders.where((element) => element.status != 'send').toList();

      loadingSale = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para obtener el total de una orden
  double getTotalSales() {
    var total = 0.0;
    for (var item in listProduct) {
      total += item.total;
    }
    return total;
  }

  //metodo para obtener los ingresos
  double getTotalIncomes() {
    for (var sale in listSales) {
      double total = sale.total;
      incomes += total;
    }
    return incomes;
  }

  //metodo para obtener el total de una orden
  double getBalance(double expenses) {
    balance = incomes - expenses;
    return balance;
  }

  //metodo para obtener las ventas segund las fechas
  Future<void> getAllSalesByDate() async {
    try {
      loadingSale = true;
      var res = await _db
          .collection("Order")
          .where('date',
              isGreaterThanOrEqualTo:
                  DateTime.parse(dateStart).toIso8601String())
          .where('date',
              isLessThanOrEqualTo: DateTime.parse(dateEnd).toIso8601String())
          .orderBy('date', descending: true)
          .get();
      var infoOrders =
          res.docs.map((e) => OrderModel.fromJson(e.data())).toList();
      listSales =
          infoOrders.where((element) => element.status != 'send').toList();
      loadingSale = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  clearListSales() {
    listSales = [];
    listProduct = [];
    incomes = 0;
    balance = 0;
    items = 0;
    loadingSale = false;
    currentOrder = null;
  }
}
