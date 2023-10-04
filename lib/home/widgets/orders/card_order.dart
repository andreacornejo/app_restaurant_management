import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:app_restaurant_management/home/screens/list_order/confirm_in_progress_order.dart';
import 'package:app_restaurant_management/home/screens/list_order/confirm_pending_order.dart';
import 'package:app_restaurant_management/utils/status_time.dart';
import 'package:app_restaurant_management/widgets/modal_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';

class CardOrder extends StatelessWidget {
  final OrderModel order;
  final int index;
  const CardOrder({Key? key, required this.order, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: boxShadow,
      child: InkWell(
        onTap: () {
          if (order.status == 'pending') {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) =>
                    ConfirmOrderScreen(statusOrder: order.status)));
          }
          if (order.status == 'inprogress') {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) =>
                    ConfirmOrderInProgressScreen(statusOrder: order.status)));
          }
          if (order.status == 'send') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ModalOrder(
                    message: 'Orden #001 entregada',
                    image: 'assets/img/order-send.svg');
              },
            );
          }
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Icon(order.typeOrder == "Delivery"
                          ? Icons.delivery_dining
                          : Icons.restaurant),
                      const SizedBox(width: 5),
                      Text(
                        "# ${index.toString().padLeft(4, '0')}",
                        style: const TextStyle(
                            letterSpacing: 0.75,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizeRegular),
                      ),
                    ],
                  ),
                  Text(
                    order.total.toString(),
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w700,
                        fontSize: fontSizeTitle),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.perm_identity, size: 22, color: fontGris),
                const SizedBox(width: 8),
                Text(
                  order.client,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      letterSpacing: 0.75,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: fontSizeRegular,
                      color: fontGris),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.schedule,
                    size: 22,
                    color: order.status == 'pending'
                        ? redColor
                        : order.status == 'inprogress'
                            ? yellowColor
                            : greenColor),
                const SizedBox(width: 5),
                Text(StatusTime.parse(order.dateTime!),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        letterSpacing: 0.25,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: fontSizeSmall,
                        color: order.status == 'pending'
                            ? redColor
                            : order.status == 'inprogress'
                                ? yellowColor
                                : greenColor))
              ],
            ),
            const SizedBox(height: 7),
            divider,
            const SizedBox(height: 7),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in order.products!)
                    Text(
                      '${item.quantity}X ${item.product.nameProduct}',
                      style: const TextStyle(
                          letterSpacing: 0.75,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: fontSizeRegular,
                          color: fontGris),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
