import 'package:app_restaurant_management/sales/widgets/date_picker_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget implements PreferredSizeWidget {
  const DatePicker({Key? key})
      : preferredSize = const Size.fromHeight(90.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DatePickerInput(
                  controller: dateStart,
                  typeDate: 'dateStart',
                  existingDateStart: dateStart.text.isEmpty
                      ? DateTime.now()
                      : DateFormat('dd-MM-yyyy').parse(dateStart.text),
                ),
                DatePickerInput(
                  controller: dateEnd,
                  typeDate: 'dateEnd',
                  existingDateStart: dateStart.text.isEmpty
                      ? DateTime.now()
                      : DateFormat('dd-MM-yyyy').parse(dateStart.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
