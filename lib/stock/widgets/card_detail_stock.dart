import 'package:app_restaurant_management/stock/models/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constans.dart';

class CardDetailStock extends StatefulWidget {
  final StockModel stock;
  const CardDetailStock({
    Key? key,
    required this.stock,
  }) : super(key: key);

  @override
  State<CardDetailStock> createState() => _CardDetailStockState();
}

class _CardDetailStockState extends State<CardDetailStock> {
  /// Type Product
  Container typeProduct() {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        widget.stock.type,
        style: textStyleLabelOrange,
        textAlign: TextAlign.end,
      ),
    );
  }

  Container expirationDate() {
    String date = widget.stock.expirationDate != null
        ? DateFormat('dd/MM/yyyy').format(widget.stock.expirationDate!)
        : '';
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        'Vto: $date',
        style: textStyleSubItem,
        textAlign: TextAlign.end,
      ),
    );
  }

  /// Name Product
  Container nameProduct() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        widget.stock.quantity != 0
            ? '${widget.stock.quantity} ${widget.stock.name}'
            : widget.stock.name,
        style: textStyleSubTitle,
        textAlign: TextAlign.left,
      ),
    );
  }

  /// Total Product
  Container total() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text("Bs. ${(widget.stock.price).toStringAsFixed(1)}",
          style: textStyleTotalBs),
    );
  }

  /// Text description
  Container description() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        widget.stock.description,
        style: textStyleSubItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 25, top: 5, left: 5, right: 5),
      decoration: boxShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          typeProduct(),
          Visibility(
              visible: widget.stock.expirationDate != null,
              child: expirationDate()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameProduct(),
              total(),
            ],
          ),
          if (widget.stock.description != '') description(),
        ],
      ),
    );
  }
}
