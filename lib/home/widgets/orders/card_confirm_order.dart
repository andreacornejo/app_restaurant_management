import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:app_restaurant_management/utils/status_time.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';

class CardConfirm extends StatefulWidget {
  final String statusOrder;
  final OrderModel order;
  final int index;
  const CardConfirm({
    Key? key,
    required this.statusOrder,
    required this.order,
    required this.index,
  }) : super(key: key);

  @override
  State<CardConfirm> createState() => _CardConfirmState();
}

class _CardConfirmState extends State<CardConfirm> {
  /// Info Client and hour
  Row infoClient() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2 * 0.7,
            child: Row(
              children: [
                const Icon(Icons.perm_identity, color: fontGris, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.order.client,
                    style: const TextStyle(
                        color: fontGris, fontSize: fontSizeSmall),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )),
        SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 22,
                  color:
                      widget.statusOrder == 'pending' ? redColor : yellowColor,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.statusOrder == 'pending'
                      ? '${StatusTime.parse(widget.order.dateTime!)} - Pendiente'
                      : '${StatusTime.parse(widget.order.dateTime!)} - En Curso',
                  style: widget.statusOrder == 'pending'
                      ? textStyleLabelRed
                      : textStyleLabelYellow,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
      ],
    );
  }

  /// Title number Order
  Container numOrder() {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 7),
      alignment: Alignment.topLeft,
      child: Text(
        "Orden #${widget.index.toString().padLeft(4, '0')}",
        style: textStyleTitle,
        textAlign: TextAlign.left,
      ),
    );
  }

  /// Subtitles Item, Cantidad y Total
  Container subtitles(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 10,
              child: const Text('Item', style: textStyleSubtitle)),
          SizedBox(
              width: MediaQuery.of(context).size.width / 4 - 20,
              child: const Text('Cantidad', style: textStyleSubtitle)),
          SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: const Text('Total',
                  style: textStyleSubtitle, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  /// Items Products
  Container itemProduct(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          for (var item in widget.order.products!)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width / 2,
                    margin: const EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.product.nameProduct,
                            style: textStyleItem,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                        Text(
                          'Bs. ${item.product.price}',
                          style: textStyleSubItem,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4 - 45,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: buttonBlack),
                      ),
                      child: Text(item.quantity.toString(),
                          style: textStyleQuantity),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 4,
                      alignment: Alignment.topRight,
                      child: Text("Bs. ${item.total}", style: textStylePrice))
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Title Text Note
  Container titleNote() {
    return Container(
        margin: const EdgeInsets.only(bottom: 7, top: 5),
        child: const Text('Nota', style: textStyleSubtitle));
  }

  /// Text field Note
  Container textFieldNote() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        initialValue: widget.order.note,
        decoration: const InputDecoration(
          enabled: false,
          border: OutlineInputBorder(),
          hintText: 'Sin nota...',
        ),
      ),
    );
  }

  /// Descuento y Subtotal
  Container subTotalDetail(String text, String total) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(text, style: textStyleSubTotal),
        Text(total, style: textStyleSubTotal),
      ]),
    );
  }

  /// Total Order
  Container total() {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total", style: textStyleTotal),
            Text("Bs. ${widget.order.total}", style: textStyleTotalBs)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 25, top: 5, left: 5, right: 5),
      decoration: boxShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoClient(),
          numOrder(),
          subtitles(context),
          itemProduct(context),
          titleNote(),
          textFieldNote(),
          subTotalDetail('Descuento', 'Bs. ${widget.order.discount}'),
          subTotalDetail('Subtotal', 'Bs. ${widget.order.total}'),
          const SizedBox(height: 10),
          divider,
          total()
        ],
      ),
    );
  }
}
