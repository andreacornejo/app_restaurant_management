import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import '../../../constans.dart';

class CardItem extends StatefulWidget {
  const CardItem({
    Key? key,
  }) : super(key: key);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  /// Item Product
  Row itemProduct(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.topLeft,
          width: MediaQuery.of(context).size.width / 2 * 0.8 - 15,
          margin: const EdgeInsets.only(right: 5),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tablita con queso carne y aderezos',
                  style: textStyleItem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
              Text(
                'Bs. 24',
                style: textStyleSubItem,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 5, left: 5),
          width: MediaQuery.of(context).size.width / 4,
          child: SpinBox(
            min: 0,
            decimals: 0,
            step: 1,
            max: 100,
            value: 0,
            spacing: 0,
            direction: Axis.horizontal,
            textStyle: textStyleSpinBoxNumber,
            incrementIcon: const Icon(Icons.add, size: 25, color: primaryColor),
            decrementIcon:
                const Icon(Icons.remove, size: 25, color: primaryColor),
            decoration: decorationSpinBox,
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width / 4 - 15,
            alignment: Alignment.topRight,
            child: const Text("Bs. 40", style: textStylePrice))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 25, top: 5, left: 5, right: 5),
      decoration: boxShadow,
      child: itemProduct(context),
    );
  }
}
