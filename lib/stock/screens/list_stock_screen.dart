import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:app_restaurant_management/stock/widgets/card_stock.dart';
import 'package:app_restaurant_management/utils/tag_date.dart';
import 'package:app_restaurant_management/widgets/empty_content.dart';
import 'package:flutter/material.dart';

class ProductsStockScreen extends StatefulWidget {
  final StockProvider provider;
  const ProductsStockScreen({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  State<ProductsStockScreen> createState() => _ProductsStockScreenState();
}

class _ProductsStockScreenState extends State<ProductsStockScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.provider.loadingStock
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              await widget.provider.getAllStocks();
            },
            child: widget.provider.listStock.isEmpty
                ? const EmptyContent(texto: 'Ningún gasto registrado')
                : ListView.builder(
                    // reverse: true,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemCount: widget.provider.listStock.length,
                    itemBuilder: (context, index) {
                      // var list = widget.provider.listStock;
                      // if (equalDate(list[index].date!,
                      //     list[(index == 0) ? 0 : index - 1].date!)) {
                      //   return Column(
                      //     children: [
                      //       tagDate(index),
                      //       CardStock(
                      //         stock: widget.provider.listStock[index],
                      //       ),
                      //     ],
                      //   );
                      // } else {
                      //   CardStock(
                      //     stock: widget.provider.listStock[index],
                      //   );
                      // }
                      var actual = widget.provider.listStock[index];
                      var anterior =
                          widget.provider.listStock[index == 0 ? 0 : index - 1];
                      String actualDate =
                          actual.date.toString().substring(0, 10);
                      String anteriorDate =
                          anterior.date.toString().substring(0, 10);
                      if (actualDate == anteriorDate) {
                        if (index == 0) {
                          return Column(
                            children: [
                              tagDate(widget.provider.listStock[index].date!),
                              CardStock(
                                stock: widget.provider.listStock[index],
                              ),
                            ],
                          );
                        }
                        return CardStock(
                          stock: widget.provider.listStock[index],
                        );
                      } else {
                        return Column(
                          children: [
                            tagDate(widget.provider.listStock[index].date!),
                            CardStock(
                              stock: widget.provider.listStock[index],
                            ),
                          ],
                        );
                      }
                    },
                  ),
          );
  }
}
