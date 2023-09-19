import 'package:flutter/material.dart';
import '../../../constans.dart';

enum SingingCharacter { disponible, nodisponible }

class CardEditProduct extends StatefulWidget {
  const CardEditProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<CardEditProduct> createState() => _CardEditProductState();
}

class _CardEditProductState extends State<CardEditProduct> {
  String dropdownValue = 'Platos';
  SingingCharacter? _character = SingingCharacter.disponible;

  /// Subtitle Forms
  Container titleCardForm(String text) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(right: 5, bottom: 5),
      child: Text(
        text,
        style: textStyleSubtitle,
      ),
    );
  }

  /// Nombre del Producto
  Column nameProduct() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Nombre del Producto'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            initialValue: 'Carne (200g)',
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  /// Categoría
  Column typeProduct() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleCardForm('Categoría'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            style: textStyleItem,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Platos', 'Bebidas']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Descripción
  Column description() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Descripción'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            initialValue: 'Carne de res',
            maxLines: 3,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  /// Foto del Producto
  Column photoProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleCardForm('Foto del Producto'),
        InkWell(
          child: Container(
              width: MediaQuery.of(context).size.width / 3 * 1.3,
              height: MediaQuery.of(context).size.width / 3 * 1.4,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: secondColor),
              ),
              child: const Icon(Icons.add_photo_alternate_rounded, size: 50)),
        ),
      ],
    );
  }

  /// Precio
  SizedBox prize() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('Precio'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              initialValue: '48',
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Bs.', style: textStyleItem)],
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
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
        children: [
          nameProduct(),
          typeProduct(),
          description(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              photoProduct(),
              Column(
                children: [
                  prize(),
                  status(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
