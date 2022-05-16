// import 'package:app_restaurant_management/home/screens/new_order/new_order_screen.dart';
import 'package:app_restaurant_management/menu/screens/products_menu_screen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constans.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  //Tab Bar
  Tab tabBarValue(
      {required String text, required String img, double marginRight = 0}) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: marginRight),
        padding:
            const EdgeInsets.only(bottom: 10, left: 10, top: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: focusColor, width: 1),
        ),
        child: Row(
          children: [
            Image.asset(img, height: 24, width: 24),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w500,
                  fontSize: fontSizeSmall),
            ),
          ],
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
              // await Navigator.of(context).push(CupertinoPageRoute(
              //     builder: (context) => const NewOrderScreen()));
            }),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                          tabs: [
                            tabBarValue(
                                text: 'Platos', img: 'assets/img/plate.png'),
                            tabBarValue(
                                text: 'Bebidas', img: 'assets/img/cooke.png'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: redColor,
                ),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white, size: 30)),
              )
            ],
          ),
        ),
        // ignore: prefer_const_constructors
        body: TabBarView(
          children: const [
            ProductsMenuScreen(),
            ProductsMenuScreen(),
          ],
        ),
        floatingActionButton: floatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}