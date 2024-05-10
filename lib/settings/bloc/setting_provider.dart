import 'package:app_restaurant_management/home/home_admin.dart';
import 'package:app_restaurant_management/home/home_cashier.dart';
import 'package:app_restaurant_management/home/home_chef.dart';
import 'package:app_restaurant_management/home/home_delivery.dart';
import 'package:app_restaurant_management/settings/models/category_model.dart';
import 'package:app_restaurant_management/settings/models/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  // CATEGORIA

  List<CategoryModel> _listCategory = [];

  bool loadingCategories = false;

  List<CategoryModel> get listCategory => _listCategory;
  set listCategory(List<CategoryModel> list) {
    _listCategory = list;
    notifyListeners();
  }

  //metodo para crear una nueva categoria
  Future<void> addCategory(String name, bool status) async {
    var uuid = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      loadingCategories = true;
      await _db
          .collection("Categories")
          .doc(uuid)
          .set(CategoryModel(id: uuid, name: name, status: status).toJson());
      loadingCategories = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para listar categoria
  Future<void> getAllCategories() async {
    try {
      loadingCategories = true;
      var res = await _db.collection("Categories").get();
      var info = res.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
      listCategory = info;
      loadingCategories = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para actualizar una categoria
  Future<void> updateCategory(String id, String name, bool status) async {
    try {
      loadingCategories = true;
      // Obtener la categoría anterior
      final res = await _db.collection("Categories").doc(id).get();

      {
        String oldName = res.data()?['name'];
        await _db
            .collection("Categories")
            .doc(id)
            .update(CategoryModel(id: id, name: name, status: status).toJson());

        var listProducts = await _db
            .collection("Product")
            .where("category", isEqualTo: oldName)
            .get();
        for (var product in listProducts.docs) {
          await product.reference.update({"category": name});
        }
      }

      loadingCategories = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Widget> homeRole() async {
    switch (rol) {
      case 'Administrador':
        return const HomeAdmin();
      case 'Cajero':
        return const HomeCashier();
      case 'Cocinero':
        return const HomeChef();
      case 'Repartidor':
        return const HomeDelivery();
      default:
        return const HomeCashier();
    }
  }

  //metodo para eliminar categoria
  Future<void> deleteCategory(var id) async {
    try {
      loadingCategories = true;
      _db.collection('Categories').doc(id).delete();
      loadingCategories = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // EMPLEADO

  List<EmployeeModel> _listEmployees = [];
  String _name = '';
  String _rol = '';
  bool _status = false;
  bool loadingEmployees = false;

  List<EmployeeModel> get listEmployees => _listEmployees;
  set listEmployees(List<EmployeeModel> list) {
    _listEmployees = list;
    notifyListeners();
  }

  String get name => _name;
  set name(String state) {
    _name = state;
    notifyListeners();
  }

  String get rol => _rol;
  set rol(String state) {
    _rol = state;
    notifyListeners();
  }

  bool get status => _status;
  set status(bool state) {
    _status = state;
    notifyListeners();
  }

  //metodo para obtener datos del usuario
  Future<void> userData(String email) async {
    loadingEmployees = true;
    await getAllEmployees();
    final user =
        listEmployees.where((element) => element.email == email).toList();
    name = user[0].name;
    rol = user[0].rol;
    status = user[0].status;
    loadingEmployees = false;
  }

  //metodo para crear usuario autentificado en firebase
  Future<void> newUser(String emailAddress, String password) async {
    try {
      // final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // //metodo para eliminar un usuario en firebase
  // Future<void> deleteUser(AuthCredential credential) async {
  //   final userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //   final user = userCredential.user;
  //   print(user?.uid);
  //   if (user != null) {
  //     for (final providerProfile in user.providerData) {
  //       // ID of the provider (google.com, apple.com, etc.)
  //       final provider = providerProfile.providerId;

  //       // UID specific to the provider
  //       final uid = providerProfile.uid;

  //       // Name, email address, and profile photo URL
  //       final name = providerProfile.displayName;
  //       final emailAddress = providerProfile.email;
  //       final profilePhoto = providerProfile.photoURL;
  //     }
  //   }
  //   await user?.delete();
  // }

  //metodo para crear un nuevo empleado
  Future<void> addEmployee(String name, String email, String password,
      String cellphone, String rol, bool status) async {
    var uuid = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      loadingEmployees = true;
      await _db.collection("Employees").doc(uuid).set(EmployeeModel(
              id: uuid,
              name: name,
              email: email,
              password: password,
              cellphone: cellphone,
              rol: rol,
              status: status)
          .toJson());
      await newUser(email, password);
      loadingEmployees = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para listar empleados
  Future<void> getAllEmployees() async {
    try {
      loadingEmployees = true;
      var res = await _db.collection("Employees").get();
      var info = res.docs.map((e) => EmployeeModel.fromJson(e.data())).toList();
      listEmployees = info;
      loadingEmployees = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // EMPLEADO

  //metodo para actualizar un empleado
  Future<void> updateEmployee(String id, String name, String email,
      String password, String cellphone, String rol, bool status) async {
    try {
      loadingEmployees = true;
      await _db.collection("Employees").doc(id).update(EmployeeModel(
              id: id,
              name: name,
              email: email,
              password: password,
              cellphone: cellphone,
              rol: rol,
              status: status)
          .toJson());
      loadingEmployees = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para deshabilitar/habilitar el acceso a un empleado
  Future<void> changeStatusEmployee(String id, String name, String email,
      String password, String cellphone, String rol, bool status) async {
    try {
      loadingEmployees = true;
      await _db.collection("Employees").doc(id).update(EmployeeModel(
              id: id,
              name: name,
              email: email,
              password: password,
              cellphone: cellphone,
              rol: rol,
              status: status)
          .toJson());
      loadingEmployees = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //metodo para eliminar empleado
  Future<void> deleteEmployee(var id) async {
    try {
      loadingEmployees = true;
      _db.collection('Employees').doc(id).delete();
      loadingEmployees = false;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
