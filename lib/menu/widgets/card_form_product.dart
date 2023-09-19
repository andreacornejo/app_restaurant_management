import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:app_restaurant_management/settings/models/category_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../constans.dart';

class CardFormProduct extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController statusController;
  final Widget photo;
  final SettingsProvider category;
  const CardFormProduct({
    Key? key,
    required this.nameController,
    required this.categoryController,
    required this.descriptionController,
    required this.priceController,
    required this.statusController,
    required this.category,
    required this.photo,
  }) : super(key: key);

  @override
  State<CardFormProduct> createState() => _CardFormProductState();
}

class _CardFormProductState extends State<CardFormProduct> {
  PlatformFile? pickedFile;

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

  /// Nombre del Producto
  Column nameProduct() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Nombre del Producto *'),
        TextFormField(
          controller: widget.nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Escriba el nombre de producto';
            }
            return null;
          },
        ),
      ],
    );
  }

  /// Categoría
  typeProduct(
      List<CategoryModel> lista, String? selected, SettingsProvider provider) {
    var listCategories = <DropdownMenuItem<String>>[];
    listCategories = List<DropdownMenuItem<String>>.generate(
        lista.length,
        (index) => DropdownMenuItem<String>(
              value: lista[index].name,
              child: Text(lista[index].name),
            ));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleCardForm('Categoría *'),
        DropdownButtonFormField<String>(
          style: textStyleItem,
          hint: const Text(
            "Seleccionar Categoría",
            style: TextStyle(color: Colors.grey),
          ),
          value: selected!.isNotEmpty ? selected : null,
          validator: (String? value) {
            if (value == null) {
              return "Seleccione una categoria";
            }
            return null;
          },
          onChanged: (value) {
            selected = value;
            setState(() {
              widget.categoryController.text = value!;
            });
          },
          items: listCategories,
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
        TextFormField(maxLines: 3, controller: widget.descriptionController),
      ],
    );
  }

  /// Precio
  SizedBox price() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('Precio *'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: widget.priceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Coloque un precio';
                }
                return null;
              },
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
          titleCardForm('Estado *'),
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
      padding: const EdgeInsets.only(top: 5, bottom: 15, left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 25, left: 5, right: 5),
      decoration: boxShadow,
      child: Column(
        children: [
          nameProduct(),
          typeProduct(widget.category.listCategory,
              widget.categoryController.text, widget.category),
          description(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // photoProduct(),
              widget.photo,
              Column(
                children: [
                  price(),
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
