import 'package:app_restaurant_management/settings/screen/canceled%20orders/canceled_orders.dart';
import 'package:app_restaurant_management/settings/screen/category/category_screen.dart';
import 'package:app_restaurant_management/settings/screen/employee/employees_screen.dart';
import 'package:flutter/material.dart';

class OptionsView {
  final String title;
  final IconData icon;
  final Widget pageRoute;
  OptionsView({
    required this.title,
    required this.icon,
    required this.pageRoute,
  });
}

List<OptionsView> options = [
  OptionsView(title: 'Administracion de empleados', icon: Icons.perm_identity , pageRoute: const EmployeesScreen()),
  OptionsView(title: 'Administracion de categorías', icon:Icons.dashboard , pageRoute: const CategoryScreen()),
  OptionsView(title: 'Ordenes canceladas', icon: Icons.do_disturb , pageRoute: const CanceledOrdersScreen()),
];
