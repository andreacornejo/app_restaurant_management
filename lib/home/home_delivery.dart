import 'package:app_restaurant_management/settings/screen/settings_employee_screen.dart';
import 'package:flutter/material.dart';
import '../constans.dart';
import 'screens/list_order/home_orders_screen.dart';

class HomeDelivery extends StatefulWidget {
  const HomeDelivery({
    Key? key,
  }) : super(key: key);

  static const List<Widget> _widgetOptions = [
    OrdersScreen(),
    SettingsEmployeeScreen(),
  ];

  @override
  State<HomeDelivery> createState() => _HomeDeliveryState();
}

class _HomeDeliveryState extends State<HomeDelivery> {
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
        child: HomeDelivery._widgetOptions.elementAt(_selectedIndex),
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
