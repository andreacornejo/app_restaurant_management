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
  TextEditingController nameClient = TextEditingController();
  TextEditingController typeOrder = TextEditingController();
  TextEditingController table = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController cellphone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    return Scaffold(
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
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
        children: [
          CardFormClient(
            nameClient: nameClient,
            typeOrder: typeOrder,
            table: table,
            address: address,
            cellphone: cellphone,
          ),
          const SizedBox(height: 20),
          ButtonConfirm(
            width: MediaQuery.of(context).size.width / 1,
            textButton: 'Confirmar Orden',
            onPressed: () async {
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
                  client: nameClient.text,
                  products: provider.listProduct,
                  status: 'pending',
                  typeOrder: typeOrder.text,
                  table: int.parse(table.text),
                  address: address.text,
                  cellphone: cellphone.text,
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
            },
          ),
        ],
      ),
    );
  }
}
