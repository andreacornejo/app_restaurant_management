import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:app_restaurant_management/stock/widgets/card_form_stock.dart';
import 'package:app_restaurant_management/widgets/button_confirm.dart';
import 'package:app_restaurant_management/widgets/modal_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class NewProductStockScreen extends StatefulWidget {
  const NewProductStockScreen({Key? key}) : super(key: key);

  @override
  State<NewProductStockScreen> createState() => _NewProductStockScreenState();
}

class _NewProductStockScreenState extends State<NewProductStockScreen> {
  final _name = TextEditingController();
  final _type = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _quantity = TextEditingController();
  final _expirationDate = TextEditingController();
  final _formStock = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _type.dispose();
    _description.dispose();
    _price.dispose();
    _quantity.dispose();
    _expirationDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: fontBlack,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Nuevo Gasto",
          style: textStyleAppBar,
          textAlign: TextAlign.left,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: _formStock,
          child: ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
            children: [
              CardFormProductStock(
                nameController: _name,
                descriptionController: _description,
                typeController: _type,
                priceController: _price,
                quantityController: _quantity,
                expirationDateController: _expirationDate,
              ),
              const SizedBox(height: 10),
              provider.loadingStock
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ButtonConfirm(
                      width: MediaQuery.of(context).size.width,
                      textButton: 'Agregar',
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formStock.currentState!.validate()) {
                          final expirationDate = _expirationDate.text.isNotEmpty
                              ? DateFormat('dd/MM/yyyy')
                                  .parse(_expirationDate.text)
                              : null;

                          await provider.addStock(
                            _name.text,
                            _type.text,
                            _description.text,
                            double.parse(_price.text),
                            _quantity.text != ''
                                ? int.parse(_quantity.text)
                                : 0,
                            expirationDate,
                          );
                          await provider.getAllStocks();
                          if (context.mounted) {
                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const ModalOrder(
                                    message:
                                        'Se agrego correctamente a la lista del Inventario',
                                    image: 'assets/img/confirm-product.svg');
                              },
                            );
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        }
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
