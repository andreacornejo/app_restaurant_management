import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:app_restaurant_management/stock/screens/new_stock_screen.dart';
import 'package:app_restaurant_management/stock/screens/list_stock_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final List<String> listTypeStock = [
    'Todo',
    'Alimentos',
    'Limpieza',
    'Alquiler',
    'Servicios Básicos',
    'Gastos administrativos',
    'Publicidad y mercadeo',
    'Transporte',
    'Otros',
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    final provider = Provider.of<StockProvider>(context, listen: false);
    provider.getAllStocks();
    initializeDateFormatting();
    super.initState();
  }

  //Tab Bar
  Tab tabBarValue({required String text, double marginRight = 0}) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: marginRight),
        padding: const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: focusColor, width: 1),
        ),
        child: Text(
          text,
          style: const TextStyle(fontFamily: "Work Sans", fontWeight: FontWeight.w500, fontSize: fontSizeRegular),
        ),
      ),
    );
  }

  // Float Button Agregar Producto
  Widget floatButton() => Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width / 1,
        height: 40,
        child: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            isExtended: true,
            backgroundColor: primaryColor,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text(
                  "AGREGAR GASTO",
                  style: textStyleButton,
                  textAlign: TextAlign.center,
                )),
            onPressed: () async {
              await Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const NewProductStockScreen()));
            }),
      );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Row(
          children: [
            SvgPicture.asset('assets/img/inventario.svg'),
            const SizedBox(width: 10),
            const Text(
              'Gastos',
              style: textStyleTitle,
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
      // ignore: prefer_const_constructors
      body: provider.loadingStock
          ? const Center(child: CircularProgressIndicator())
          : ProductsStockScreen(
              provider: provider,
            ),
      floatingActionButton: floatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
