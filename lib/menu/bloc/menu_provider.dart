import 'dart:io';

import 'package:app_restaurant_management/menu/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  // Points to the root reference
  // final storageRef = FirebaseStorage.instance.ref();
  UploadTask? uploadTask;

  Future<String> uploadFile(var pickedFile) async {
    loadingProduct = true;
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    String urlDownload = await snapshot.ref.getDownloadURL();
    loadingProduct = false;
    return urlDownload;
    // print('Download Link: $urlDownload');
  }

  List<ProductModel> _listProduct = [];

  bool _loadingProduct = false;

  bool get loadingProduct => _loadingProduct;
  set loadingProduct(bool state) {
    _loadingProduct = state;
    /* notifyListeners(); */
  }

  List<ProductModel> get listProduct => _listProduct;
  set listProduct(List<ProductModel> list) {
    _listProduct = list;
    notifyListeners();
  }

  //metodo para crear una nuevo producto
  Future<void> addProduct(String name, bool status, String category,
      String description, double price, String urlPhoto) async {
    var uuid = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      loadingProduct = true;
      await _db.collection("Product").doc(uuid).set(ProductModel(
              id: uuid,
              nameProduct: name,
              status: status,
              category: category,
              description: description,
              price: price,
              urlPhoto: urlPhoto)
          .toJson());
      loadingProduct = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para listar producto
  Future<void> getAllProducts() async {
    try {
      loadingProduct = true;
      var res = await _db.collection("Product").get();
      var info = res.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      listProduct = info;
      loadingProduct = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para actualizar un producto
  Future<void> updateProduct(
      String id,
      String name,
      bool status,
      String category,
      String description,
      double price,
      String urlPhoto) async {
    try {
      loadingProduct = true;
      await _db.collection("Product").doc(id).update(ProductModel(
              id: id,
              nameProduct: name,
              status: status,
              category: category,
              description: description,
              price: price,
              urlPhoto: urlPhoto)
          .toJson());
      loadingProduct = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para eliminar producto
  Future<void> deleteProduct(var id) async {
    try {
      loadingProduct = true;
      _db.collection('Product').doc(id).delete();
      loadingProduct = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
