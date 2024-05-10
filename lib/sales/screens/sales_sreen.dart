import 'package:app_restaurant_management/sales/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';
import 'list_sales_screen.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  //Tab Bar
  Tab tabBarValue({required String text}) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 15, left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: focusColor),
        ),
        child: Text(text,
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w500,
                fontSize: fontSizeRegular)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // String current = DateFormat('dd-MM-yyyy').format(now);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Row(
          children: [
            Image.asset('assets/img/sale.png'),
            const SizedBox(width: 10),
            const Text(
              'Ventas',
              style: textStyleTitle,
              textAlign: TextAlign.left,
            ),
            const Spacer(),
          ],
        ),
      ),
      body: ListView(
        children: const [
          DatePicker(),
          ListSalesScreen(),
        ],
      ),
    );
  }
}
