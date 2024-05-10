import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/settings/widgets/canceled-orders/card_canceled_order.dart';
import 'package:app_restaurant_management/widgets/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCanceledOrdersScreen extends StatefulWidget {
  const ListCanceledOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ListCanceledOrdersScreen> createState() =>
      _ListCanceledOrdersScreenState();
}

class _ListCanceledOrdersScreenState extends State<ListCanceledOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final list = provider.listOrders
        .where((element) => element.status == 'cancel')
        .toList();
    return provider.loadingOrder
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              await provider.getAllOrders();
            },
            child: list.isEmpty
                ? const EmptyContent(texto: 'Ninguna orden cancelada')
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return CardOrderCancelled(
                        order: list[index],
                        index: index + 1,
                      );
                    },
                  ),
          );
  }
}
