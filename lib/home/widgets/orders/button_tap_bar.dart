import 'package:flutter/material.dart';
import '../../../constans.dart';

class ButtonTabBar extends StatefulWidget {
  final String textButton;
  final VoidCallback onPressed;
  final Color color;
  final Color colorText;
  final double width;
  // ignore: use_key_in_widget_constructors
  const ButtonTabBar({
    required this.textButton,
    required this.onPressed,
    this.color = focusColor,
    this.width = 125,
    this.colorText = Colors.black,
  });

  @override
  State<ButtonTabBar> createState() => _ButtonTabBarState();
}

class _ButtonTabBarState extends State<ButtonTabBar>
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
          backgroundColor: MaterialStateProperty.all<Color>(widget.color),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return focusColor;
            }
            if (states.contains(MaterialState.hovered)) {
              return focusColor;
            }
            if (states.contains(MaterialState.pressed)) {
              return focusColor;
            }
            return focusColor;
            // Defer to the widget's default.
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: focusColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(widget.textButton,
              style: TextStyle(
                  fontFamily: "Work Sans",
                  color: widget.colorText,
                  fontWeight: FontWeight.w500,
                  fontSize: fontSizeSmall)),
        ));
  }
}
