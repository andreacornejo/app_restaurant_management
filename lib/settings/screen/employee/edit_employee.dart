import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:app_restaurant_management/settings/models/employee_model.dart';
import 'package:app_restaurant_management/settings/widgets/employee/card_edit_employee.dart';
import 'package:app_restaurant_management/widgets/button_confirm.dart';
import 'package:app_restaurant_management/widgets/modal_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class EditEmployeeScreen extends StatefulWidget {
  final EmployeeModel employee;
  const EditEmployeeScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _cellphone = TextEditingController();
  final _rol = TextEditingController();
  final _status = TextEditingController();
  final _formEmployee = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _name.text = widget.employee.name;
      _email.text = widget.employee.email;
      _password.text = widget.employee.password;
      _cellphone.text = widget.employee.cellphone;
      _rol.text = widget.employee.rol;
      _status.text = widget.employee.status.toString();
    });
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _cellphone.dispose();
    _rol.dispose();
    _status.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: fontBlack,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Editar Empleado",
          style: textStyleAppBar,
          textAlign: TextAlign.left,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: _formEmployee,
          child: ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
            children: [
              CardFormEditEmployee(
                nameContorller: _name,
                emailContorller: _email,
                passwordContorller: _password,
                cellContorller: _cellphone,
                rolController: _rol,
                statusContorller: _status,
              ),
              const SizedBox(height: 10),
              provider.loadingEmployees
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ButtonConfirm(
                      width: MediaQuery.of(context).size.width,
                      textButton: 'Guardar cambios',
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formEmployee.currentState!.validate()) {
                          await provider.updateEmployee(
                              widget.employee.id,
                              _name.text,
                              _email.text,
                              _password.text,
                              _cellphone.text,
                              _rol.text,
                              _status.text == 'true' ? true : false);
                          await provider.getAllEmployees();
                          if (context.mounted) {
                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const ModalOrder(
                                    message: 'Cambios guardados correctamente',
                                    image: 'assets/img/confirm-product.svg');
                              },
                            );
                          }
                        }
                        if (context.mounted) {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pop(true);
                        }
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
