import 'package:app_restaurant_management/constans.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:app_restaurant_management/settings/models/employee_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilSection extends StatefulWidget {
  final String email;
  const PerfilSection({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<PerfilSection> createState() => _PerfilSectionState();
}

class _PerfilSectionState extends State<PerfilSection> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final EmployeeModel user = provider.listEmployees.where((employee) => employee.email == widget.email).first;
    String name = user.name;
    String rol = user.rol;
    return provider.loadingEmployees
        ? Container()
        : Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 45,
                  child: ClipOval(
                    child:
                        // signIn.userInfo.photoURL == null?
                        FadeInImage(
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage("assets/img/profile.png"),
                      image: AssetImage("assets/img/${rol.toLowerCase()}.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  rol.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
  }
}
