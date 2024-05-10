import 'package:app_restaurant_management/settings/models/employee_model.dart';
import 'package:app_restaurant_management/settings/screen/employee/detail_employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constans.dart';

class CardEmployee extends StatelessWidget {
  final EmployeeModel employee;
  const CardEmployee({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: boxShadow,
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                  builder: (context) =>
                      DetailEmployeeScreen(employee: employee)),
            );
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 * 1.2 - 15,
                    child: Text(
                      employee.name,
                      style: textStyleItem,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4 + 20,
                    child: Text(
                      employee.rol,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizeRegular,
                        color: employee.rol == 'Administrador'
                            ? greenColor
                            : fontBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
