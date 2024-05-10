// ignore_for_file: avoid_print
import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:app_restaurant_management/home/widgets/orders/modal_confirm.dart';
import 'package:app_restaurant_management/home/widgets/orders/modal_status.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:app_restaurant_management/widgets/button_cancel.dart';
import 'package:app_restaurant_management/widgets/button_confirm.dart';
import 'package:app_restaurant_management/home/widgets/orders/card_confirm_order.dart';
import 'package:app_restaurant_management/widgets/modal_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class ConfirmOrderInProgressScreen extends StatefulWidget {
  final String statusOrder;
  final OrderModel order;
  final int index;
  const ConfirmOrderInProgressScreen(
      {Key? key,
      required this.statusOrder,
      required this.order,
      required this.index})
      : super(key: key);

  @override
  State<ConfirmOrderInProgressScreen> createState() =>
      _ConfirmOrderInProgressScreenState();
}

class _ConfirmOrderInProgressScreenState
    extends State<ConfirmOrderInProgressScreen> {
  final TextEditingController noteRejection = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final employee = Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: fontBlack,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Confirmar Entrega",
          style: textStyleTitle,
          textAlign: TextAlign.left,
        ),
      ),
      body: ListView(
        children: [
          CardConfirm(
            statusOrder: widget.statusOrder,
            order: widget.order,
            index: widget.index,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (employee.rol != 'Repartidor')
                  ButtonCancel(
                    textButton: 'Rechazar',
                    onPressed: () async {
                      var res = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return ModalStatus(noteRejection: noteRejection);
                        },
                      );
                      if (res != null) {
                        await provider.updateOrder(widget.order, 'cancel',
                            widget.order.id, noteRejection.text);
                        await provider.getAllOrders();
                        if (context.mounted) {
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const ModalOrder(
                                  message: 'Orden #001 rechazado',
                                  image: 'assets/img/order-cancel.svg');
                            },
                          );
                          if (context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        }
                      }
                    },
                  ),
                if (employee.rol != 'Repartidor')
                  ButtonConfirm(
                    textButton: 'Entregado',
                    onPressed: () async {
                      var res = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: ModalConfirm(
                              message: '¿Confirmar entrega?',
                              onPressConfirm: () async {
                                Navigator.of(context).pop('confirmar');
                              },
                              onPressCancel: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                      if (res != null) {
                        await provider.updateOrder(widget.order, 'send',
                            widget.order.id, noteRejection.text);
                        await provider.getAllOrders();
                        if (context.mounted) {
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return ModalOrder(
                                message:
                                    'Orden #${widget.index.toString().padLeft(4, '0')} entregada',
                                image: 'assets/img/confirm-send.svg',
                              );
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
          ),
        ],
      ),
    );
  }
}
