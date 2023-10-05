// ignore_for_file: avoid_print
import 'package:app_restaurant_management/home/models/order_model.dart';
import 'package:app_restaurant_management/home/widgets/orders/modal_confirm.dart';
import 'package:app_restaurant_management/home/widgets/orders/modal_status.dart';
import 'package:app_restaurant_management/widgets/button_cancel.dart';
import 'package:app_restaurant_management/widgets/button_confirm.dart';
import 'package:app_restaurant_management/home/widgets/orders/card_confirm_order.dart';
import 'package:app_restaurant_management/widgets/modal_order.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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
                ///Functionality button cancel
                ButtonCancel(
                  textButton: 'Rechazar',
                  onPressed: () async {
                    var res = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const ModalStatus();
                      },
                    );
                    if (res != null) {
                      ///Evaluar
                      print(res);
                      if (context.mounted) {
                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                Navigator.of(context).pop();
                              },
                            );
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

                ///Functionality button confirm
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
                      if (context.mounted) {
                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const ModalOrder(
                              message: 'Orden #001 entregada',
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
