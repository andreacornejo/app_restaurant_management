import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:app_restaurant_management/home/widgets/orders/card_confirm_order.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';

class DetailConfirmOrderScreen extends StatefulWidget {
  final String statusOrder;
  final OrderModel order;
  final int index;
  const DetailConfirmOrderScreen(
      {Key? key,
      required this.statusOrder,
      required this.order,
      required this.index})
      : super(key: key);

  @override
  State<DetailConfirmOrderScreen> createState() =>
      _DetailConfirmOrderScreenState();
}

class _DetailConfirmOrderScreenState extends State<DetailConfirmOrderScreen> {
  final TextEditingController noteRejection = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: fontBlack,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Detalle de la Orden",
          style: textStyleAppBar,
          textAlign: TextAlign.left,
        ),
      ),
      body: ListView(
        children: [
          CardConfirm(
            statusOrder: widget.statusOrder,
            order: widget.order,
            index: widget.index,
          ),
        ],
      ),
    );
  }
}
