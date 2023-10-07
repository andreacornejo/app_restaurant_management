import 'package:app_restaurant_management/menu/screens/menu_screen.dart';
import 'package:app_restaurant_management/sales/screens/sales_sreen.dart';
import 'package:app_restaurant_management/settings/screen/settings_screen.dart';
import 'package:app_restaurant_management/stock/screens/stock_screen.dart';
import 'package:flutter/material.dart';
import 'constans.dart';
import 'home/screens/list_order/home_orders_screen.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  static const List<Widget> _widgetOptions = [
    OrdersScreen(),
    MenuScreen(),
    SalesScreen(),
    StockScreen(),
    SettingsScreen(),
  ];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Home._widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: navbarColor,
        selectedLabelStyle: const TextStyle(
          fontFamily: "Work Sans",
          fontSize: fontSizeSmall,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "Work Sans",
          color: secondColor,
          fontSize: fontSizeSmall,
        ),
        items: [
          bottomItem(context, Icons.home, 'Inicio'),
          bottomItem(context, Icons.local_dining, 'Menú'),
          bottomItem(context, Icons.assessment, 'Ventas'),
          bottomItem(context, Icons.assignment, 'Gastos'),
          bottomItem(context, Icons.settings, 'Ajustes'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem bottomItem(
      BuildContext context, IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
