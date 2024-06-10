import 'package:flutter/material.dart';
import '../constans.dart';

class ButtonConfirm extends StatefulWidget {
  final String textButton;
  final VoidCallback onPressed;
  final Color color;
  final Color colorText;
  final double width;
  final IconData? icon;

  // ignore: use_key_in_widget_constructors
  const ButtonConfirm({
    required this.textButton,
    required this.onPressed,
    this.color = focusColor,
    this.width = 125,
    this.colorText = Colors.white,
    this.icon,
  });

  @override
  State<ButtonConfirm> createState() => _ButtonConfirmState();
}

class _ButtonConfirmState extends State<ButtonConfirm>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(widget.color),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          overlayColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return primaryColor;
            }
            if (states.contains(WidgetState.hovered)) {
              return primaryColor;
            }
            if (states.contains(WidgetState.pressed)) {
              return primaryColor;
            }
            return primaryColor;
            // Defer to the widget's default.
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: focusColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: widget.width == 125
              ? MediaQuery.of(context).size.width / 2 * 0.8
              : widget.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: widget.icon != null,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(
                    widget.icon,
                    color: widget.colorText,
                  ),
                ),
              ),
              Text(
                widget.textButton,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: widget.colorText,
                    fontWeight: FontWeight.w500,
                    fontSize: fontSizeMedium),
              ),
            ],
          ),
        ));
  }
}
