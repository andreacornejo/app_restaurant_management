import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/screens/new_order/detail_order_screen.dart';
import 'package:app_restaurant_management/home/screens/new_order/products_screen.dart';
import 'package:app_restaurant_management/menu/bloc/menu_provider.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<MenuProvider>(context, listen: false);
      provider.getAllProducts();
      final category = Provider.of<SettingsProvider>(context, listen: false);
      category.getAllCategories();
      final order = Provider.of<OrderProvider>(context, listen: false);
      order.cleanCurrentOrder;
    });
    super.initState();
  }

  //Tab Bar
  Tab tabBarValue({required String text}) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        padding:
            const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: focusColor, width: 1),
        ),
        child: Text(text,
            style: const TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.w500,
                fontSize: fontSizeSmall)),
      ),
    );
  }

  // Float Button Agregar Orden
  Widget floatButton(int item) => Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        width: MediaQuery.of(context).size.width / 1,
        color: Colors.white,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$item Items seleccionados'),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                // clipBehavior: Clip.antiAliasWithSaveLayer,
                // isExtended: true,
                backgroundColor: primaryColor,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text(
                    "Ver Orden",
                    style: textStyleButton,
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () async {
                  var res = await Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const DetailOrderScreen()));
                  if (res == true) {
                    if (context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context);
    final category = Provider.of<SettingsProvider>(context);
    final order = Provider.of<OrderProvider>(context);
    return DefaultTabController(
      length: category.listCategory.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(120.0), // here the desired height
          child: Stack(
            alignment: const Alignment(1, 0.9),
            children: [
              AppBar(
                foregroundColor: fontBlack,
                elevation: 0,
                backgroundColor: backgroundColor,
                title: const Text(
                  'Nueva Orden',
                  style: textStyleTitle,
                  textAlign: TextAlign.left,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        TabBar(
                          labelPadding:
                              const EdgeInsets.only(left: 5, right: 5),
                          isScrollable: true,
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 5, right: 5),
                          unselectedLabelColor: Colors.black,
                          indicatorWeight: 0,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: focusColor,
                          ),
                          tabs: [
                            for (var listCategory in category.listCategory)
                              tabBarValue(text: listCategory.name),
                            // tabBarValue(text: 'Platos'),
                            // tabBarValue(text: 'Bebidas'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: provider.loadingProduct
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  for (var listCategory in category.listCategory)
                    ProductsScreen(
                        provider: provider, category: listCategory.name)
                ],
              ),
        // floatingActionButton: floatButton(order.items),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: floatButton(order.items),
      ),
    );
  }
}
