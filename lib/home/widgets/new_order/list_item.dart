import 'package:app_restaurant_management/constans.dart';
import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/widgets/new_order/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ListItemsOrder extends StatefulWidget {
  const ListItemsOrder({Key? key}) : super(key: key);

  @override
  State<ListItemsOrder> createState() => _ListItemsOrderState();
}

class _ListItemsOrderState extends State<ListItemsOrder> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: provider.listProduct.length,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var item = provider.listProduct[index];
          return Dismissible(
            background: Container(
              padding: const EdgeInsets.all(15),
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/img/trash.svg",
                    ),
                    const SizedBox(width: 10),
                    const Text('Eliminar',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            secondaryBackground: Container(
              padding: const EdgeInsets.all(15),
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/img/trash.svg",
                    ),
                    const SizedBox(width: 10),
                    const Text('Eliminar',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirmar Eliminación"),
                    content:
                        const Text("¿Está seguro de eliminar el producto?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Eliminar")),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Cancelar"),
                      ),
                    ],
                  );
                },
              );
            },
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) {
              setState(() {
                provider.deleteProduct(item.product);
                provider.items = provider.items - 1;
              });
            },
            child: CardItem(
              product: item,
              index: index,
            ),
          );
        });
  }
}
