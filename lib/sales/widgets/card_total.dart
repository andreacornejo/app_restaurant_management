import 'package:app_restaurant_management/sales/bloc/sales_provider.dart';
import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';

class CardTotal extends StatelessWidget {
  final SalesProvider salesProvider;
  final StockProvider stockProvider;
  const CardTotal({
    required this.salesProvider,
    required this.stockProvider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final incomes = salesProvider.incomes;
    final expenses = stockProvider.expenses;
    final balance = salesProvider.balance;
    return Container(
      height: 80,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: boxShadow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          columnTotal(context, 'Ingresos', incomes.toString(), greenColor),
          const VerticalDivider(thickness: 2),
          columnTotal(context, 'Egresos', expenses.toString(), redColor),
          const VerticalDivider(thickness: 2),
          columnTotal(context, 'Balance', balance.toString(), Colors.black),
        ],
      ),
    );
  }

  SizedBox columnTotal(
      BuildContext context, String text, String total, Color color) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 * 0.8,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              letterSpacing: 0.75,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: fontSizeRegular,
              color: color,
            ),
          ),
          Text(
            total,
            style: TextStyle(
              fontFamily: "Work Sans",
              fontWeight: FontWeight.w700,
              fontSize: fontSizeTitle,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
