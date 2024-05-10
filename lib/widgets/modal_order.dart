import 'package:app_restaurant_management/constans.dart';
import 'package:app_restaurant_management/widgets/button_confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ModalOrder extends StatelessWidget {
  const ModalOrder({
    Key? key,
    required this.message,
    this.image = '',
    this.secondMessage = '',
  }) : super(key: key);

  final String message;
  final String image;
  final String secondMessage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: textStyleMessage,
          ),
        ),
        Visibility(
          visible: image != '',
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: SvgPicture.asset(image,
                width: MediaQuery.of(context).size.width / 3 * 1.2),
          ),
        ),
        Visibility(
          visible: secondMessage != '',
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Text(
              secondMessage,
              textAlign: TextAlign.center,
              style: textStyleMessage,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: ButtonConfirm(
            textButton: 'Listo',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    ));
  }
}
