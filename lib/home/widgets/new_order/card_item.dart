import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class CardItem extends StatefulWidget {
  const CardItem({Key? key, required this.product, required this.index})
      : super(key: key);
  final Product product;
  final int index;
  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  /// Item Product
  Row itemProduct(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.topLeft,
          width: MediaQuery.of(context).size.width / 2 * 0.8 - 15,
          margin: const EdgeInsets.only(right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.product.product.nameProduct,
                  style: textStyleItem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
              Text(
                'Bs. ${widget.product.product.price}',
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
            value: widget.product.quantity.toDouble(),
            spacing: 0,
            direction: Axis.horizontal,
            textStyle: textStyleSpinBoxNumber,
            incrementIcon: const Icon(Icons.add, size: 25, color: primaryColor),
            decrementIcon:
                const Icon(Icons.remove, size: 25, color: primaryColor),
            decoration: decorationSpinBox,
            onChanged: (value) {
              provider.editQuantity(widget.index, value.toInt());
              if (value.toInt() == 0) {
                var item = provider.listProduct[widget.index];
                provider.deleteProduct(item.product);
                provider.items = provider.items - 1;
              }
              if (provider.items == 0) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width / 4 - 15,
            alignment: Alignment.topRight,
            child: Text("Bs. ${widget.product.total}", style: textStylePrice))
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
