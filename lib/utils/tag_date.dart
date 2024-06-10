import 'package:app_restaurant_management/constans.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Container tagDate(DateTime dateList) {
  // DateTime fecha = widget.provider.listStock[index].date!;
  String date = DateFormat("EEEE dd MMMM", "es").format(dateList);
  String today = DateFormat("EEEE dd MMMM", "es").format(DateTime.now());
  if (dateList.year < DateTime.now().year) {
    date = DateFormat("EEEE dd MMMM yyyy", "es").format(dateList);
  }
  return Container(
    alignment: Alignment.topLeft,
    margin: const EdgeInsets.all(10),
    child: Text(
      date == today ? 'Hoy' : date,
      style: const TextStyle(fontSize: 16, color: fontGris),
    ),
  );
}

bool equalDate(DateTime dateNow, DateTime dateBefore) {
  String date = DateFormat("yyyy-MM-dd", "es").format(dateNow);
  String date2 = DateFormat("yyyy-MM-dd", "es").format(dateBefore);
  return date == date2;
}
