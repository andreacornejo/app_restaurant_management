import 'dart:async';

import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:app_restaurant_management/home/screens/list_order/list_orders_screen.dart';
import 'package:app_restaurant_management/home/widgets/home/float_button.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  StreamSubscription? _sub;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<OrderProvider>(context, listen: false);
      provider.getAllOrders();
      _sub = provider.getListOrderStream().listen((event) {
        // print(event.docs);
        AudioPlayer().play(AssetSource('sounds/ping.mp3'));
        var list =
            event.docs.map((e) => OrderModel.fromJson(e.data())).toList();
        list.sort(((a, b) => a.dateTime!.compareTo(b.dateTime!)));
        provider.listOrders = list;
      });
    });
    super.initState();
  }

  // Banner
  banner() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: SvgPicture.asset(
        "assets/img/banner.svg",
      ),
    );
  }

  //Tab Bar
  Tab tabBarValue({required String text}) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: focusColor),
        ),
        child: Text(text,
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w500,
                fontSize: fontSizeSmall)),
      ),
    );
  }

  // Float Button Agregar Orden
  @override
  Widget build(BuildContext context) {
    final employee = Provider.of<SettingsProvider>(context, listen: false);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(120.0), // here the desired height
          child: AppBar(
            elevation: 0,
            backgroundColor: backgroundColor,
            title: banner(),
            bottom: TabBar(
              indicatorWeight: 0,
              padding: const EdgeInsets.only(bottom: 5),
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: focusColor,
              ),
              tabs: [
                tabBarValue(text: 'Pendientes'),
                tabBarValue(text: 'En curso'),
                tabBarValue(text: 'Entregados'),
              ],
            ),
          ),
        ),
        // ignore: prefer_const_constructors
        body: TabBarView(
          children: const [
            ListOrdersScreen(status: 'pending'),
            ListOrdersScreen(status: 'inprogress'),
            ListOrdersScreen(status: 'send'),
            // InProgressScreen(),
            // SendScreen(),
          ],
        ),
        floatingActionButton:
            employee.rol == 'Administrador' || employee.rol == 'Cajero'
                ? const FloatButton()
                : const Offstage(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
