import 'package:app_restaurant_management/home/widgets/new_order/card_product.dart';
import 'package:app_restaurant_management/menu/bloc/menu_provider.dart';
import 'package:app_restaurant_management/widgets/empty_content.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  final MenuProvider provider;
  final String category;
  const ProductsScreen(
      {Key? key, required this.provider, required this.category})
      : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final list = widget.provider.listProduct
        .where((element) => element.category == widget.category)
        .toList();
    final double sw = MediaQuery.of(context).size.width;
    return widget.provider.loadingProduct
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              await widget.provider.getAllProducts();
            },
            child: list.isEmpty
                ? const EmptyContent(
                    texto: 'Ningún producto agregado a la lista')
                : ListView(
                    padding: const EdgeInsets.only(bottom: 40),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: (sw / 2 + (sw / 2) * 0.3) + 50,
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 3),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SectionCardProduct(
                            product: list[index],
                          );
                        },
                      ),
                    ],
                  ),
          );
  }
}
