import 'package:flutter/material.dart';
import '../../../../constans.dart';

class CardFormNewEmployee extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController cellphone;
  final TextEditingController rol;
  final TextEditingController status;

  const CardFormNewEmployee({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
    required this.cellphone,
    required this.rol,
    required this.status,
  }) : super(key: key);

  @override
  State<CardFormNewEmployee> createState() => _CardFormNewEmployeeState();
}

class _CardFormNewEmployeeState extends State<CardFormNewEmployee> {
  String dropdownValue = 'Cajero';
  String imageLink = 'assets/img/cajero.png';
  bool valueStatus = true;
  bool _passwordVisible = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.rol.text = dropdownValue;
      widget.status.text = valueStatus ? 'true' : 'false';
    });
    super.initState();
  }

  /// Imagen por defecto empleado
  imgEmployee() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4 * 1.3,
      height: MediaQuery.of(context).size.width / 4 * 1.3,
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
            controller: widget.name,
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
            controller: widget.email,
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
            obscureText: !_passwordVisible,
            controller: widget.password,
            decoration: InputDecoration(
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Escriba la contraseña';
              }
              return null;
            },
          ),
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
            controller: widget.cellphone,
          ),
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
              value: valueStatus,
              onChanged: (bool? value) {
                setState(() {
                  valueStatus = value!;
                  widget.status.text = value ? 'true' : 'false';
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
                dropdownValue = newValue!;
                widget.rol.text = dropdownValue;
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
        Container(
          padding:
              const EdgeInsets.only(top: 15, bottom: 5, left: 10, right: 10),
          margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
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
