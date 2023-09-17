// import 'package:app_restaurant_management/home/screens/new_order/new_order_screen.dart';
import 'dart:math';

import 'package:app_restaurant_management/home/bloc/sing_in_social_networks.dart';
import 'package:app_restaurant_management/home/widgets/orders/modal_confirm.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:app_restaurant_management/settings/screen/canceled%20orders/canceled_orders.dart';
import 'package:app_restaurant_management/settings/screen/category/category_screen.dart';
import 'package:app_restaurant_management/settings/screen/employee/employees_screen.dart';
import 'package:app_restaurant_management/settings/widgets/perfil_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<SettingsProvider>(context, listen: false);
      await provider.getAllEmployees();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<SignInSocialNetworkInProvider>(context);
    final provider = Provider.of<SettingsProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Row(
          children: const [
            Icon(Icons.settings, size: 30, color: Colors.black),
            SizedBox(width: 10),
            Text(
              'Ajustes',
              style: textStyleTitle,
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
      body: provider.loadingEmployees
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              children: [
                profile(
                  email: user!.email,
                ),
                const SizedBox(height: 40),
                // function(
                //     text: 'Administración de negocio',
                //     icon: Icons.business,
                //     onPressed: () {
                //       Navigator.of(context).push(CupertinoPageRoute(
                //           builder: (context) => const BusinessInfoScreen()));
                //     }),
                // const Divider(),
                function(
                    text: 'Administracion de empleados',
                    icon: Icons.perm_identity,
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const EmployeesScreen()));
                    }),
                const Divider(),
                function(
                    text: 'Administracion de categorías',
                    icon: Icons.dashboard,
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const CategoryScreen()));
                    }),
                const Divider(),
                function(
                    text: 'Ordenes canceladas',
                    icon: Icons.do_disturb,
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const CanceledOrdersScreen()));
                    }),
                const Divider(),
                function(
                  text: 'Cerrar Sesión',
                  icon: Icons.logout,
                  arrow: false,
                  onPressed: () async {
                    var res = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: ModalConfirm(
                            message: '¿Seguro que quieres cerrar sesión?',
                            onPressConfirm: () async {
                              Navigator.of(context).pop('confirmar');
                            },
                            onPressCancel: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                    if (res != null) {
                      await auth.logOut();
                      if (context.mounted) {
                        Phoenix.rebirth(context);
                      }
                    }
                  },
                ),
              ],
            ),
    );
  }

  PerfilSection profile({String? email}) {
    return PerfilSection(
      email: email! ,
    );
  }

  // Row functions
  function({required String text, required IconData icon, bool arrow = true, required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(text),
            const Spacer(),
            if (arrow) const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
