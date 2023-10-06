import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/widgets/new_order/card_form_client.dart';
import 'package:app_restaurant_management/home/widgets/orders/modal_confirm.dart';
import 'package:app_restaurant_management/widgets/button_confirm.dart';
import 'package:app_restaurant_management/widgets/modal_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class FormClienScreen extends StatefulWidget {
  const FormClienScreen({Key? key}) : super(key: key);

  @override
  State<FormClienScreen> createState() => _FormClienScreenState();
}

class _FormClienScreenState extends State<FormClienScreen> {
  final _nameClient = TextEditingController();
  final _typeOrder = TextEditingController();
  final _table = TextEditingController();
  final _address = TextEditingController();
  final _cellphone = TextEditingController();
  final _formClient = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameClient.dispose();
    _typeOrder.dispose();
    _table.dispose();
    _address.dispose();
    _cellphone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
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
            "Confirmar Orden",
            style: textStyleAppBar,
            textAlign: TextAlign.left,
          ),
        ),
        body: GestureDetector(
          onTap: (() {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }),
          child: Form(
            key: _formClient,
            child: ListView(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
              children: [
                CardFormClient(
                  nameClient: _nameClient,
                  typeOrder: _typeOrder,
                  table: _table,
                  address: _address,
                  cellphone: _cellphone,
                ),
                const SizedBox(height: 20),
                ButtonConfirm(
                  width: MediaQuery.of(context).size.width / 1,
                  textButton: 'Confirmar Orden',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_formClient.currentState!.validate()) {
                      var res = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: ModalConfirm(
                              message: '¿Confirmar Orden?',
                              onPressConfirm: () async {
                                Navigator.of(context).pop('confirmar');
                              },
                              onPressCancel: () {
                                Navigator.pop(context, false);
                              },
                            ),
                          );
                        },
                      );
                      if (res != null) {
                        var order = provider.currentOrder!.copyWith(
                          client: _nameClient.text,
                          products: provider.listProduct,
                          status: 'pending',
                          typeOrder: _typeOrder.text,
                          table: _table.text != '' ? int.parse(_table.text) : 0,
                          address: _address.text,
                          cellphone: _cellphone.text,
                          total: provider.getTotal(),
                        );
                        await provider.addOrder(order);
                        if (context.mounted) {
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const ModalOrder(
                                  message: 'Ordén registrada exitosamente',
                                  image: 'assets/img/order-confirm.svg',
                                  secondMessage:
                                      'Revisa la orden en la lista de pendientes');
                            },
                          );
                        }
                        if (context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
