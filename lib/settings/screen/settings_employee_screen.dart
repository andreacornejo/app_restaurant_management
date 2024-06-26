import 'package:app_restaurant_management/home/bloc/sign_in_social_networks.dart';
import 'package:app_restaurant_management/home/widgets/orders/modal_confirm.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:app_restaurant_management/settings/widgets/perfil_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import '../../../constans.dart';

class SettingsEmployeeScreen extends StatefulWidget {
  const SettingsEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<SettingsEmployeeScreen> createState() => _SettingsEmployeeScreenState();
}

class _SettingsEmployeeScreenState extends State<SettingsEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<SignInSocialNetworkInProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Row(
            children: [
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
        body: Consumer<SettingsProvider>(
          builder: (context, value, child) {
            return value.loadingEmployees
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ).add(const EdgeInsets.only(top: 10)),
                    children: [
                      PerfilSection(
                        email: user?.email ?? '',
                      ),
                      const SizedBox(height: 40),
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
                  );
          },
        ));
  }

  // Row functions
  function(
      {required String text,
      required IconData icon,
      bool arrow = true,
      required VoidCallback onPressed}) {
    return SizedBox(
      height: 40,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(text),
              ],
            ),
            if (arrow) const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
