import 'package:app_restaurant_management/stock/widgets/date_picker_stock.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';

class CardFormProductStock extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController typeController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final TextEditingController expirationDateController;
  const CardFormProductStock({
    Key? key,
    required this.nameController,
    required this.typeController,
    required this.descriptionController,
    required this.priceController,
    required this.quantityController,
    required this.expirationDateController,
  }) : super(key: key);

  @override
  State<CardFormProductStock> createState() => _CardFormProductStockState();
}

class _CardFormProductStockState extends State<CardFormProductStock> {
  // File? _image;
  // final ImagePicker _picker = ImagePicker();

  /// Nombre del gasto
  Column nameStock() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('*Gasto'),
        TextFormField(
          controller: widget.nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Escriba el gasto';
            }
            return null;
          },
        ),
      ],
    );
  }

  /// Tipo de Gasto
  Column typeStock() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleCardForm('*Tipo de gasto'),
        DropdownButtonFormField(
          hint: const Text(
            "Seleccionar tipo de gasto",
            style: TextStyle(color: Colors.grey),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          style: textStyleItem,
          onChanged: (String? newValue) {
            setState(() {
              widget.typeController.text = newValue!;
            });
          },
          validator: (String? value) {
            if (value == null) {
              return "Seleccione un tipo de gasto";
            }
            return null;
          },
          items: <String>[
            'Alimentos',
            'Limpieza',
            'Alquiler',
            'Servicios Básicos',
            'Gastos administrativos',
            'Publicidad y mercadeo',
            'Transporte',
            'Otros',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
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
        TextFormField(
          maxLines: 3,
          keyboardType: TextInputType.number,
          controller: widget.descriptionController,
        ),
      ],
    );
  }

  expirationDate() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 * 0.8,
            child: titleCardForm('Fecha de caducidad (prod perecederos)'),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 2 * 0.8,
              child:
                  DatePickerStock(controller: widget.expirationDateController)),
          // TextFormField(
          //   controller: widget.descriptionController,
          // ),
        ],
      ),
    );
  }

  /// Precio
  SizedBox price() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('*Precio'),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: widget.priceController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Coloque un precio';
              }
              return null;
            },
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Bs.', style: textStyleItem)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Cantidad
  SizedBox quantity() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('Cantidad'),
          TextFormField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            controller: widget.quantityController,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      decoration: boxShadow,
      child: Column(
        children: [
          nameStock(),
          typeStock(),
          description(),
          expirationDate(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // photoProduct(),
              price(),
              quantity(),
            ],
          ),
        ],
      ),
    );
  }
}
