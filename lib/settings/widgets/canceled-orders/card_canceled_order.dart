import 'package:flutter/material.dart';
import '../../../constans.dart';

class CardOrderCancelled extends StatelessWidget {
  final String id;
  final String typeOrder;
  final String price;
  final String name;
  final String description;
  const CardOrderCancelled({
    Key? key,
    required this.id,
    required this.typeOrder,
    required this.price,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: boxShadow,
      child: InkWell(
        onTap: () {},
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
                      Icon(typeOrder == "d"
                          ? Icons.delivery_dining
                          : Icons.restaurant),
                      const SizedBox(width: 5),
                      Text(
                        id,
                        style: const TextStyle(
                            letterSpacing: 0.75,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizeRegular),
                      ),
                    ],
                  ),
                  Text(
                    price,
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
                  name,
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
              child: Text(
                description,
                style: const TextStyle(
                    letterSpacing: 0.75,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: fontSizeRegular,
                    color: fontGris),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
