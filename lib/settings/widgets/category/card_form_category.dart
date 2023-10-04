import 'package:flutter/material.dart';
import '../../../../constans.dart';

class CardFormCategory extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController statusController;
  const CardFormCategory({
    Key? key,
    required this.nameController,
    required this.statusController,
  }) : super(key: key);

  @override
  State<CardFormCategory> createState() => _CardFormCategoryState();
}

class _CardFormCategoryState extends State<CardFormCategory> {
  SingingCharacter? _character = SingingCharacter.disponible;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.statusController.text.isNotEmpty) {
        _character = widget.statusController.text == "true"
            ? SingingCharacter.disponible
            : SingingCharacter.nodisponible;
      } else {
        widget.statusController.text =
            _character == SingingCharacter.disponible ? 'true' : 'false';
      }
    });
    super.initState();
  }

  /// Nombre de la Categoría
  Column nameCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Nombre de la Categoría'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: widget.nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Escriba el nombre de la categoría';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Estado
  Container status() {
    return Container(
      width: MediaQuery.of(context).size.width / 2 * 0.8,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('Estado'),
          RadioListTile<SingingCharacter>(
            contentPadding: const EdgeInsets.all(0),
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            title: const Text('Disponible'),
            value: SingingCharacter.disponible,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                widget.statusController.text =
                    value == SingingCharacter.disponible ? 'true' : 'false';
              });
            },
          ),
          RadioListTile<SingingCharacter>(
            contentPadding: const EdgeInsets.all(0),
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            title: const Text('No Disponible'),
            value: SingingCharacter.nodisponible,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                widget.statusController.text =
                    value == SingingCharacter.disponible ? 'true' : 'false';
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 25, left: 5, right: 5),
      decoration: boxShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameCategory(),
          status(),
        ],
      ),
    );
  }
}
