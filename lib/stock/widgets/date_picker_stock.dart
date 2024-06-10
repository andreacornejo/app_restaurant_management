import 'package:app_restaurant_management/constans.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerStock extends StatefulWidget {
  final TextEditingController controller;
  const DatePickerStock({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DatePickerStock> createState() => _DatePickerStockState();
}

class _DatePickerStockState extends State<DatePickerStock> {
  Future<dynamic> modalDate(BuildContext context) async {
    return await showDatePicker(
      locale: const Locale('es', 'ES'),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      confirmText: 'Aceptar',
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.red,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
  }

  void _clearDate() {
    setState(() {
      widget.controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        await modalDate(context).then((value) {
          if (value != null) {
            setState(() {
              final dateController = DateFormat("dd/MM/yyyy").format(value);
              widget.controller.text = dateController;
            });
          }
        });
      },
      style: const TextStyle(
        fontFamily: "Poppins",
        fontSize: fontSizeRegular,
      ),
      controller: widget.controller,
      readOnly: true,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.highlight_remove_rounded),
                onPressed: _clearDate,
              )
            : null,
        prefixIcon: widget.controller.text.isNotEmpty
            ? null
            : const Icon(
                Icons.calendar_today,
              ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        contentPadding: const EdgeInsets.only(top: 15, right: 10),
        filled: true,
        isDense: true,
        hintStyle: const TextStyle(
          fontFamily: "Poppins",
          fontSize: fontSizeRegular,
        ),
      ),
    );
  }
}
