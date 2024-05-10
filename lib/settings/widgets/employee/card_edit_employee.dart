import 'package:flutter/material.dart';
import '../../../../constans.dart';

class CardFormEditEmployee extends StatefulWidget {
  final TextEditingController nameContorller;
  final TextEditingController emailContorller;
  final TextEditingController passwordContorller;
  final TextEditingController cellContorller;
  final TextEditingController rolController;
  final TextEditingController statusContorller;
  const CardFormEditEmployee({
    Key? key,
    required this.nameContorller,
    required this.emailContorller,
    required this.passwordContorller,
    required this.cellContorller,
    required this.rolController,
    required this.statusContorller,
  }) : super(key: key);

  @override
  State<CardFormEditEmployee> createState() => _CardFormEditEmployeeState();
}

bool _passwordVisible = false;

class _CardFormEditEmployeeState extends State<CardFormEditEmployee> {
  late String imageLink = 'assets/img/cajero.png';
  late String dropdownValue = 'Cajero';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        dropdownValue = widget.rolController.text;
        imageLink = 'assets/img/${widget.rolController.text.toLowerCase()}.png';
      });
    });
    super.initState();
  }

  /// Imagen por defecto empleado
  imgEmployee() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 * 1.3,
      height: MediaQuery.of(context).size.width / 3 * 1.3,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: secondColor),
        ),
        child: Image(
          image: AssetImage(imageLink),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Nombre del empleado
  Column nameEmployee() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Nombre del Empleado'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: widget.nameContorller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Escriba el nombre de empleado';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Email
  Column email() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Correo electrónico'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            readOnly: true,
            enabled: false,
            controller: widget.emailContorller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Escriba el correo';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Contraseña
  Column password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Contraseña'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
              readOnly: true,
              obscureText: !_passwordVisible,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              controller: widget.passwordContorller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Escriba la contraseña';
                }
                return null;
              }),
        ),
      ],
    );
  }

  /// Celular
  Column cellphone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Celular'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
              keyboardType: TextInputType.number,
              controller: widget.cellContorller),
        ),
      ],
    );
  }

  /// Estado
  Row status() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Estado'),
        Row(
          children: [
            const Text('Activo'),
            Checkbox(
              value: widget.statusContorller.text == 'true' ? true : false,
              onChanged: (bool? value) {
                setState(() {
                  // valueStatus = value!;
                  widget.statusContorller.text = value! ? 'true' : 'false';
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  ///Tipo de empleado
  Column employeeType() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleCardForm('Cargo'),
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
                widget.rolController.text = newValue!;
                imageLink = ('assets/img/$newValue.png').toLowerCase();
              });
            },
            items: <String>['Cajero', 'Cocinero', 'Repartidor', 'Administrador']
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imgEmployee(),
        const SizedBox(height: 10),
        Container(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          margin: const EdgeInsets.only(bottom: 25, left: 5, right: 5),
          decoration: boxShadow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nameEmployee(),
              email(),
              password(),
              cellphone(),
              employeeType(),
              status(),
            ],
          ),
        ),
      ],
    );
  }
}
