import 'package:app_restaurant_management/home/widgets/orders/modal_confirm.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { agotado, cerrado, nodisponible }

class ModalStatus extends StatefulWidget {
  final TextEditingController noteRejection;
  const ModalStatus({Key? key, required this.noteRejection}) : super(key: key);

  @override
  State<ModalStatus> createState() => _ModalStatusState();
}

class _ModalStatusState extends State<ModalStatus> {
  SingingCharacter? _character = SingingCharacter.agotado;

  @override
  Widget build(BuildContext context) {
    widget.noteRejection.text = 'El producto esta agotado';
    return Dialog(
      child: ModalConfirm(
        message: 'Motivo del rechazo',
        secondMessage: Column(
          children: [
            RadioListTile<SingingCharacter>(
              title: const Text('El producto esta agotado'),
              value: SingingCharacter.agotado,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value!;
                  widget.noteRejection.text = 'El producto esta agotado';
                });
              },
            ),
            RadioListTile<SingingCharacter>(
              title: const Text('Negocio por cerrar'),
              value: SingingCharacter.cerrado,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value!;
                  widget.noteRejection.text = 'Negocio por cerrar';
                });
              },
            ),
            RadioListTile<SingingCharacter>(
              title: const Text('Producto no disponible'),
              value: SingingCharacter.nodisponible,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value!;
                  widget.noteRejection.text = 'Producto no disponible';
                });
              },
            ),
          ],
        ),
        onPressConfirm: () async {
          Navigator.of(context).pop(_character);
        },
        onPressCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
