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
  TextEditingController totalPayment = TextEditingController();
  TextEditingController cash = TextEditingController();

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
            ),
          ),
        ],
      ),
    );
  }

  /// Total Pagado
  SizedBox totalPagado() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 + 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleCardForm('Total Pagado'),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              controller: totalPayment,
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
              initialValue: '0',
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
            children: [totalPagado(), cambio(provider)],
          ),
          Visibility(visible: dropdownValue == 'Delivery', child: address()),
          Visibility(visible: dropdownValue == 'Delivery', child: cellphone()),
          total(provider),
        ],
      ),
    );
  }
}
