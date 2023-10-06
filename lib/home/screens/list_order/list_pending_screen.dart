import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/widgets/orders/card_order.dart';
import 'package:app_restaurant_management/widgets/empty_content.dart';
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
    final listOrdersToday = provider.listOrders
        .where((element) =>
            element.dateTime.toString().substring(0, 10) ==
                DateTime.now().toString().substring(0, 10) &&
            element.status != 'cancel')
        .toList();
    return provider.loadingOrder
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              await provider.getAllOrders();
            },
            child: listOrdersToday.isEmpty
                ? const EmptyContent(texto: 'Ninguna orden agregada')
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: listOrdersToday.length,
                    itemBuilder: (context, index) {
                      return CardOrder(
                        order: listOrdersToday[index],
                        index: index + 1,
                      );
                    },
                  ),
          );
  }
}
