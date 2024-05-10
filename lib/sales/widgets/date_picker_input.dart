import 'package:app_restaurant_management/constans.dart';
import 'package:app_restaurant_management/sales/bloc/sales_provider.dart';
import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatePickerInput extends StatefulWidget {
  final TextEditingController controller;
  final String typeDate;
  final DateTime existingDateStart;
  const DatePickerInput({
    Key? key,
    required this.controller,
    required this.typeDate,
    required this.existingDateStart,
  }) : super(key: key);

  @override
  State<DatePickerInput> createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerInput> {
  Future<dynamic> modalDate(BuildContext context) async {
    DateTime initialDate;
    try {
      initialDate = DateFormat('dd-MM-yyyy').parse(widget.controller.text);
    } catch (e) {
      initialDate = DateTime.now();
    }
    return await showDatePicker(
      locale: const Locale('es', 'ES'),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      confirmText: 'Aceptar',
      initialDate: initialDate,
      firstDate: widget.typeDate == 'dateEnd'
          ? widget.existingDateStart
          : DateTime(2015),
      lastDate: DateTime.now(),
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

  void onDateSelected(SalesProvider salesProvider,
      TextEditingController controller, DateTime selectedDate) async {
    final stockProvider = Provider.of<StockProvider>(context, listen: false);
    await stockProvider.clearListStock();
    await salesProvider.clearListSales();
    if (widget.typeDate == 'dateStart') {
      salesProvider.dateStart = DateFormat("yyyy-MM-dd").format(selectedDate);
      stockProvider.dateStart = DateFormat("yyyy-MM-dd").format(selectedDate);
    } else if (widget.typeDate == 'dateEnd') {
      salesProvider.dateEnd = DateFormat("yyyy-MM-dd").format(selectedDate);
      stockProvider.dateEnd = DateFormat("yyyy-MM-dd").format(selectedDate);
    }
    await salesProvider.getAllSalesByDate();
    await stockProvider.getAllStocksByDate();
    salesProvider.getTotalIncomes();
    var expenses = stockProvider.getTotalExpenses();
    salesProvider.getBalance(expenses);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context);
    DateTime now = DateTime.now();
    String current = DateFormat('dd-MM-yyyy').format(now);
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      width: MediaQuery.of(context).size.width * 0.5 - 20,
      child: TextFormField(
        onTap: () async {
          await modalDate(context).then((value) {
            if (value != null) {
              setState(() {
                widget.controller.text = DateFormat('dd-MM-yyyy').format(value);
                onDateSelected(provider, widget.controller, value);
              });
            }
          });
        },
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: fontSizeRegular,
          color: Colors.white,
        ),
        controller: widget.controller,
        readOnly: true,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          fillColor: Colors.black,
          prefixIcon: Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.calendar_today,
              size: 20,
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.only(top: 15, right: 10),
          filled: true,
          isDense: true,
          hintText: current,
          hintStyle: const TextStyle(
              fontFamily: "Poppins",
              fontSize: fontSizeRegular,
              color: Colors.white),
        ),
      ),
    );
  }
}
