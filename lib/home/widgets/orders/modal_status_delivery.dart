import 'package:app_restaurant_management/home/widgets/orders/modal_confirm.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { agotado, cerrado, nodisponible }

class ModalStatusDelivery extends StatefulWidget {
  final TextEditingController noteRejection;
  const ModalStatusDelivery({Key? key, required this.noteRejection})
      : super(key: key);

  @override
  State<ModalStatusDelivery> createState() => _ModalStatusDeliveryState();
}

class _ModalStatusDeliveryState extends State<ModalStatusDelivery> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ModalConfirm(
        message: 'Escriba el motivo por el cual no llego a entregar el pedido',
        secondMessage: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: widget.noteRejection,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Debe llenar este campo';
                }
                return null;
              },
            ),
          ),
        ),
        onPressConfirm: () async {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pop(true);
          }
        },
        onPressCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
