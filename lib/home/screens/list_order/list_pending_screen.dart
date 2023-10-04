import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/widgets/orders/card_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: provider.listOrders.length,
      itemBuilder: (context, index) {
        return CardOrder(
          order: provider.listOrders[index],
          index: index + 1,
        );
      },
    );
  }
}
