import 'package:app_restaurant_management/menu/bloc/menu_provider.dart';
import 'package:app_restaurant_management/menu/screens/new_product_screen.dart';
import 'package:app_restaurant_management/menu/screens/products_menu_screen.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // late TabController _tabController;

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }
  Tab tabBarValue({required String text, double marginRight = 0}) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: marginRight),
        padding:
            const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: focusColor, width: 1),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: "Work Sans",
              fontWeight: FontWeight.w500,
              fontSize: fontSizeRegular),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            isExtended: true,
            backgroundColor: primaryColor,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text(
                  "AGREGAR PRODUCTO",
                  style: textStyleButton,
                  textAlign: TextAlign.center,
                )),
            onPressed: () async {
              await Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const NewProductScreen()));
            }),
      );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context);
    final category = Provider.of<SettingsProvider>(context);
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
                elevation: 0,
                backgroundColor: backgroundColor,
                title: Row(
                  children: [
                    SvgPicture.asset('assets/img/menu.svg'),
                    const SizedBox(width: 10),
                    const Text(
                      'Menú',
                      style: textStyleTitle,
                      textAlign: TextAlign.left,
                    )
                  ],
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
                          tabs:
                              // tabMaker(category)
                              [
                            for (var listCategory in category.listCategory)
                              tabBarValue(text: listCategory.name),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(right: 10),
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: redColor,
              //       boxShadow: listBoxShadow),
              //   child: IconButton(
              //       onPressed: () async {
              //         await Navigator.of(context).push(CupertinoPageRoute(
              //             builder: (context) => const NewCategoryScreen()));
              //       },
              //       icon: const Icon(Icons.add, color: Colors.white, size: 30)),
              // )
            ],
          ),
        ),
        // ignore: prefer_const_constructors
        body: provider.loadingProduct
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                // controller: _tabController,
                children:
                    // category.listCategory.map((Tab tab) {
                    //   return ProductsMenuScreen(provider: provider);
                    // }).toList(),
                    [
                  for (var listCategory in category.listCategory)
                    // ProductsMenuScreen(provider: provider),
                    ProductsMenuScreen(
                        provider: provider, category: listCategory.name),
                ],
              ),
        floatingActionButton: floatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
