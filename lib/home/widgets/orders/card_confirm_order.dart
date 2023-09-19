import 'package:flutter/material.dart';
import '../../../constans.dart';

class CardConfirm extends StatefulWidget {
  final String statusOrder;
  const CardConfirm({
    Key? key,
    required this.statusOrder,
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
            child: const Row(
              children: [
                Icon(Icons.perm_identity, color: fontGris, size: 24),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Adela Canedo Rodriguez Moscoso",
                    style: TextStyle(color: fontGris, fontSize: fontSizeSmall),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )),
        SizedBox(
            child: Row(
          children: [
            Icon(
              Icons.schedule,
              size: 22,
              color: widget.statusOrder == 'pending' ? redColor : yellowColor,
            ),
            const SizedBox(width: 5),
            Text(
              widget.statusOrder == 'pending'
                  ? 'Hace 10 min - Pendiente'
                  : 'Hace 10 min - En Curso',
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
      child: const Text(
        "Orden #001",
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: FadeInImage(
              width: MediaQuery.of(context).size.width / 2 * 0.33,
              height: 70,
              fit: BoxFit.cover,
              placeholder: const AssetImage("assets/img/background.png"),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/img/background.png");
              },
              image: const NetworkImage(
                  'https://images.unsplash.com/photo-1612871689353-cccf581d667b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width / 2 * 0.5,
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
          SizedBox(
            width: MediaQuery.of(context).size.width / 4 - 45,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: buttonBlack),
              ),
              child: const Text('2', style: textStyleQuantity),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 4,
              alignment: Alignment.topRight,
              child: const Text("Bs. 40", style: textStylePrice))
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
        initialValue: "",
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total", style: textStyleTotal),
            Text("Bs. 144", style: textStyleTotalBs)
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
          itemProduct(context),
          itemProduct(context),
          titleNote(),
          textFieldNote(),
          subTotalDetail('Descuento', 'Bs. 0'),
          subTotalDetail('Subtotal', 'Bs. 144'),
          const SizedBox(height: 10),
          divider,
          total()
        ],
      ),
    );
  }
}
