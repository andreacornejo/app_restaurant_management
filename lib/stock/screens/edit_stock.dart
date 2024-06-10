import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:app_restaurant_management/stock/models/stock_model.dart';
import 'package:app_restaurant_management/stock/widgets/card_edit_stock.dart';
import 'package:app_restaurant_management/widgets/button_cancel.dart';
import 'package:app_restaurant_management/widgets/button_confirm.dart';
import 'package:app_restaurant_management/widgets/modal_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class EditProductStockScreen extends StatefulWidget {
  final StockModel stock;
  const EditProductStockScreen({Key? key, required this.stock})
      : super(key: key);

  @override
  State<EditProductStockScreen> createState() => _EditProductStockScreenState();
}

class _EditProductStockScreenState extends State<EditProductStockScreen> {
  final _name = TextEditingController();
  late DateTime _date;
  final _type = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _quantity = TextEditingController();
  final _expirationDate = TextEditingController();
  final _formStock = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _name.text = widget.stock.name;
      _type.text = widget.stock.type;
      _description.text = widget.stock.description;
      _price.text = widget.stock.price.toString();
      _quantity.text = widget.stock.quantity.toString();
      _expirationDate.text = widget.stock.expirationDate == null
          ? ""
          : DateFormat('dd/MM/yyyy').format(widget.stock.expirationDate!);
      _date = widget.stock.date!;
    });
    super.initState();
  }

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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: fontBlack,
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Text(
            "Editar Producto",
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
                CardEditStock(
                  nameController: _name,
                  typeController: _type,
                  descriptionController: _description,
                  priceController: _price,
                  quantityController: _quantity,
                  expirationDateController: _expirationDate,
                ),
                const SizedBox(height: 10),
                provider.loadingStock
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonCancel(
                            textButton: 'Cancelar',
                            onPressed: () async {
                              Navigator.of(context).pop(true);
                            },
                          ),
                          ButtonConfirm(
                            textButton: 'Guardar',
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_formStock.currentState!.validate()) {
                                final expirationDate =
                                    _expirationDate.text.isNotEmpty
                                        ? DateFormat('dd/MM/yyyy')
                                            .parse(_expirationDate.text)
                                        : null;

                                await provider.updateStock(
                                  widget.stock.id,
                                  _date,
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
                                            'Cambios guardados exitosamente',
                                        image: 'assets/img/confirm-product.svg',
                                      );
                                    },
                                  );
                                }
                                if (context.mounted) {
                                  Navigator.of(context).pop(true);
                                  Navigator.of(context).pop(true);
                                }
                              }
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
