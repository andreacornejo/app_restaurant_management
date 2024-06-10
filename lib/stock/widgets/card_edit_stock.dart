import 'package:app_restaurant_management/stock/widgets/date_picker_stock.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';

enum SingingCharacter { disponible, nodisponible }

class CardEditStock extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController typeController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final TextEditingController expirationDateController;
  const CardEditStock({
    Key? key,
    required this.nameController,
    required this.typeController,
    required this.descriptionController,
    required this.priceController,
    required this.quantityController,
    required this.expirationDateController,
  }) : super(key: key);

  @override
  State<CardEditStock> createState() => _CardEditStockState();
}

class _CardEditStockState extends State<CardEditStock> {
  String type = "Alimentos";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        type = widget.typeController.text;
      });
    });
    super.initState();
  }

  final List<String> listTypeStock = [
    'Alimentos',
    'Limpieza',
    'Alquiler',
    'Servicios Básicos',
    'Gastos administrativos',
    'Publicidad y mercadeo',
    'Transporte',
    'Otros',
  ];

  /// Nombre del Producto
  Column nameProduct() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('*Gasto'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: widget.nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Escriba el gasto';
              }
              return null;
            },
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
        titleCardForm('*Categoría'),
        DropdownButtonFormField(
          hint: const Text(
            "Seleccionar tipo de gasto",
            style: TextStyle(color: Colors.grey),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          style: textStyleItem,
          value: type,
          onChanged: (String? newValue) {
            setState(() {
              type = newValue!;
              widget.typeController.text = newValue;
            });
          },
          validator: (String? value) {
            if (value == null) {
              return "Seleccione un tipo de gasto";
            }
            return null;
          },
          items: listTypeStock.map<DropdownMenuItem<String>>((String value) {
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
  Container quantity() {
    return Container(
      width: MediaQuery.of(context).size.width / 2 * 0.8,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
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
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 25, left: 5, right: 5),
      decoration: boxShadow,
      child: Column(
        children: [
          nameProduct(),
          typeProduct(),
          description(),
          expirationDate(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              price(),
              quantity(),
            ],
          ),
        ],
      ),
    );
  }
}
