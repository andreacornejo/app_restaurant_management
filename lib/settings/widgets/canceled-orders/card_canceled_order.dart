import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:app_restaurant_management/home/screens/list_order/detail_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';

class CardOrderCancelled extends StatelessWidget {
  final OrderModel order;
  final int index;
  const CardOrderCancelled({
    Key? key,
    required this.order,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: boxShadow,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => DetailConfirmOrderScreen(
                    statusOrder: order.status,
                    order: order,
                    index: index,
                  )));
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
                      Icon(order.typeOrder == "delivery"
                          ? Icons.delivery_dining
                          : Icons.restaurant),
                      const SizedBox(width: 5),
                      Text(
                        "#${index.toString().padLeft(4, '0')}",
                        style: const TextStyle(
                            letterSpacing: 0.75,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizeRegular),
                      ),
                    ],
                  ),
                  Text(
                    'Bs. ${order.total}',
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
            const Row(
              children: [
                Icon(Icons.schedule, size: 22, color: redColor),
                SizedBox(width: 5),
                Text('Cancelado',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        letterSpacing: 0.25,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: fontSizeSmall,
                        color: redColor))
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
