import 'package:app_restaurant_management/sales/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';
import 'list_sales_screen.dart';
import 'package:intl/intl.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController _dateController = TextEditingController();

  // void getNacionalByDate(BuildContext context, String date) {
  Future<dynamic> fechaModal(BuildContext context) async {
    return await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: primaryColor,
            surface: primaryColor,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      ),
    );
  }

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
          // Row(
          //   children: [
          //     // calendar(current),
          //     Container(
          //       margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          //       width: MediaQuery.of(context).size.width * 0.4,
          //       child: TextFormField(
          //         onTap: () async {
          //           await fechaModal(context).then((value) {
          //             if (value != null) {
          //               setState(() {
          //                 _dateController.text =
          //                     DateFormat('dd-MM-yyyy').format(value);
          //               });
          //               //     // getNacionalByDate(context, value.toString());
          //             }
          //           });
          //         },
          //         style: const TextStyle(
          //           fontFamily: "Poppins",
          //           fontSize: fontSizeRegular,
          //           color: Colors.white,
          //         ),
          //         controller: _dateController,
          //         readOnly: true,
          //         textAlign: TextAlign.center,
          //         keyboardType: TextInputType.datetime,
          //         decoration: InputDecoration(
          //           fillColor: Colors.black,
          //           prefixIcon: Container(
          //             padding: const EdgeInsets.all(10),
          //             child: const Icon(Icons.calendar_today,
          //                 size: 20, color: Colors.white),
          //           ),
          //           focusedBorder: InputBorder.none,
          //           contentPadding: const EdgeInsets.only(top: 15, right: 10),
          //           filled: true,
          //           isDense: true,
          //           hintText: current,
          //           hintStyle: const TextStyle(
          //               fontFamily: "Poppins",
          //               fontSize: fontSizeRegular,
          //               color: Colors.white),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          ListSalesScreen(),
        ],
      ),
    );
  }

  Future calendar(String current) async {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextFormField(
        onTap: () async {
          await fechaModal(context).then((value) {
            if (value != null) {
              setState(() {
                _dateController.text = DateFormat('dd-MM-yyyy').format(value);
              });
              //     // getNacionalByDate(context, value.toString());
            }
          });
        },
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: fontSizeRegular,
          color: Colors.white,
        ),
        controller: _dateController,
        readOnly: true,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          fillColor: Colors.black,
          prefixIcon: Container(
            padding: const EdgeInsets.all(10),
            child:
                const Icon(Icons.calendar_today, size: 20, color: Colors.white),
          ),
          focusedBorder: InputBorder.none,
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
