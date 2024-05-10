import 'package:app_restaurant_management/sales/bloc/sales_provider.dart';
import 'package:app_restaurant_management/sales/widgets/card_sale.dart';
import 'package:app_restaurant_management/sales/widgets/card_total.dart';
import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:app_restaurant_management/utils/tag_date.dart';
import 'package:app_restaurant_management/widgets/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSalesScreen extends StatefulWidget {
  const ListSalesScreen({Key? key}) : super(key: key);

  @override
  State<ListSalesScreen> createState() => _ListSalesScreenState();
}

class _ListSalesScreenState extends State<ListSalesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final salesProvider = Provider.of<SalesProvider>(context, listen: false);
      final stockProvider = Provider.of<StockProvider>(context, listen: false);
      await salesProvider.init();
      await stockProvider.init();
      await salesProvider.getAllSales();
      await stockProvider.getAllStocks();
      salesProvider.getTotalIncomes();
      var expenses = stockProvider.getTotalExpenses();
      salesProvider.getBalance(expenses);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final salesProvider = Provider.of<SalesProvider>(context);
    final stockProvider = Provider.of<StockProvider>(context);
    final listSales = salesProvider.listSales;
    return salesProvider.loadingSale
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              await salesProvider.getAllSales();
              await stockProvider.getAllStocks();
              salesProvider.getTotalIncomes();
              var expenses = stockProvider.getTotalExpenses();
              salesProvider.getBalance(expenses);
            },
            child: listSales.isEmpty
                ? const EmptyContent(texto: 'Ninguna venta registrada')
                : ListView(
                    padding: const EdgeInsets.all(10),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      CardTotal(
                        salesProvider: salesProvider,
                        stockProvider: stockProvider,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: listSales.length,
                          itemBuilder: (context, index) {
                            var actual = listSales[index];
                            var anterior =
                                listSales[index == 0 ? 0 : index - 1];
                            String actualDate =
                                actual.dateTime.toString().substring(0, 10);
                            String anteriorDate =
                                anterior.dateTime.toString().substring(0, 10);

                            if (actualDate == anteriorDate) {
                              if (index == 0) {
                                return Column(
                                  children: [
                                    tagDate(listSales[index].dateTime!),
                                    CardSale(
                                      order: listSales[index],
                                      index: index + 1,
                                    ),
                                  ],
                                );
                              }

                              return CardSale(
                                order: listSales[index],
                                index: index + 1,
                              );
                            } else {
                              return Column(
                                children: [
                                  tagDate(listSales[index].dateTime!),
                                  CardSale(
                                    order: listSales[index],
                                    index: index + 1,
                                  ),
                                ],
                              );
                            }
                          }),
                    ],
                  ),
          );
  }
}
