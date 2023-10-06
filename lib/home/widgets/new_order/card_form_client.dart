import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class CardFormClient extends StatefulWidget {
  final TextEditingController nameClient;
  final TextEditingController typeOrder;
  final TextEditingController table;
  final TextEditingController address;
  final TextEditingController cellphone;

  const CardFormClient({
    Key? key,
    required this.nameClient,
    required this.typeOrder,
    required this.table,
    required this.address,
    required this.cellphone,
  }) : super(key: key);

  @override
  State<CardFormClient> createState() => _CardFormClientState();
}

class _CardFormClientState extends State<CardFormClient> {
  String dropdownValue = 'Servirse en el local';
  final _totalPayment = TextEditingController();
  final _cashController = TextEditingController();
  @override
  void initState() {
    widget.typeOrder.text = dropdownValue;
    super.initState();
  }

  /// Title Datos del Cliente
  Container title() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.perm_identity),
          SizedBox(width: 10),
          Text('Datos del Cliente', style: textStyleTitle),
        ],
      ),
    );
  }

  /// Nombre Completo
  Column name() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Nombre Completo'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: widget.nameClient,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Escriba el nombre del cliente';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Tipo de Orden
  SizedBox typeOrder() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 + 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          titleCardForm('Tipo de Orden'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: DropdownButtonFormField(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              style: textStyleItem,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  widget.typeOrder.text = newValue;
                });
              },
              items: <String>['Servirse en el local', 'Para llevar', 'Delivery']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Numero Mesa
  SizedBox numberTable() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('Nro Mesa'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: widget.table,
              validator: (value) {
                if (dropdownValue == 'Servirse en el local') {
                  if (value == null || value.isEmpty) {
                    return 'Escriba el nro de mesa';
                  }
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Total Pagado
  SizedBox totalPagado(OrderProvider order) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 + 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('Total Pagado'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              onChanged: (value) {
                _cashController.text =
                    order.getCash(double.parse(value)).toString();
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              controller: _totalPayment,
              decoration: const InputDecoration(
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Bs.', style: textStyleItem)],
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Anote el total pagado';
                }
                if (double.parse(value) < order.getTotal()) {
                  return 'El monto es menor al total';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Cambio
  SizedBox cambio(OrderProvider order) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('Cambio'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _cashController,
              // initialValue: order.cash.toString(),
              enabled: false,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Bs.', style: textStyleItem)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Direccion
  Column address() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Dirección'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: widget.address,
            validator: (value) {
              if (dropdownValue == 'Delivery') {
                if (value == null || value.isEmpty) {
                  return 'Escriba la direccion';
                }
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Nro Celular
  Column cellphone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleCardForm('Nro de Celular'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: widget.cellphone,
            validator: (value) {
              if (dropdownValue == 'Delivery') {
                if (value == null || value.isEmpty) {
                  return 'Escriba el número de referencia';
                }
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Total Order
  Container total(OrderProvider order) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total", style: textStyleTotal),
            Text("Bs. ${order.getTotal()}", style: textStyleTotalBs)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);

    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 25, left: 5, right: 5),
      decoration: boxShadow,
      child: Column(
        children: [
          title(),
          name(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              typeOrder(),
              Visibility(
                  visible: dropdownValue == 'Servirse en el local',
                  child: numberTable())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [totalPagado(provider), cambio(provider)],
          ),
          Visibility(visible: dropdownValue == 'Delivery', child: address()),
          Visibility(visible: dropdownValue == 'Delivery', child: cellphone()),
          total(provider),
        ],
      ),
    );
  }
}
