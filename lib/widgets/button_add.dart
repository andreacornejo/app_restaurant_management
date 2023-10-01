import 'package:flutter/material.dart';
import '../constans.dart';

class ButtonAdd extends StatefulWidget {
  final String textButton;
  final VoidCallback onPressed;
  final Color color;
  final Color colorText;
  final double padding;
  // ignore: use_key_in_widget_constructors
  const ButtonAdd(
      {required this.textButton,
      required this.onPressed,
      this.color = redColor,
      this.padding = 5,
      this.colorText = redColor});

  @override
  State<ButtonAdd> createState() => _ButtonAddState();
}

class _ButtonAddState extends State<ButtonAdd>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: unSelectColor,
          padding: const EdgeInsets.only(left: 5, right: 5),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: redColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 125,
          child: Text(
            widget.textButton,
            style: TextStyle(
                fontFamily: "Poppins",
                color: widget.colorText,
                fontWeight: FontWeight.w500,
                fontSize: fontSizeMedium),
          ),
        ));
  }
}
