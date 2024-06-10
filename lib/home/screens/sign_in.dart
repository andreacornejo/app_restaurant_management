import 'package:app_restaurant_management/constans.dart';
import 'package:app_restaurant_management/home/bloc/sign_in_social_networks.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formLogin = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<SignInSocialNetworkInProvider>(context);
    final employee = Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
            key: _formLogin,
            child: ListView(
              children: [
                topImage(context),
                message(),
                image(context),
                if (loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                emailForm(),
                passwordForm(),
                ButtonSignIn(
                  formLogin: _formLogin,
                  emailController: emailController,
                  passController: passController,
                  provider: auth,
                  text: 'Ingresar',
                  employee: employee,
                  context: context,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container emailForm() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(right: 5, bottom: 5),
              child: const Text(
                'Correo Electrónico:',
                style: textStyleSubtitle,
              )),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Escriba el correo';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Container passwordForm() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(right: 5, bottom: 5),
              child: const Text(
                'Contraseña:',
                style: textStyleSubtitle,
              )),
          TextFormField(
            controller: passController,
            obscureText: !_passwordVisible,
            keyboardType: TextInputType.text,
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
        ],
      ),
    );
  }

  Container image(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0),
      height: MediaQuery.of(context).size.height / 2 * 0.7,
      child: SvgPicture.asset(
        "assets/img/portada.svg",
      ),
    );
  }

  Container message() {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10, top: 5),
      child: const Text(
        "Mejora tu rendimiento y administra tu negocio de forma sencilla.",
        textAlign: TextAlign.center,
        style: textStyleItem,
      ),
    );
  }

  topImage(BuildContext context) {
    return SvgPicture.asset(
      "assets/img/welcome.svg",
    );
  }
}

class ButtonSignIn extends StatelessWidget {
  const ButtonSignIn({
    super.key,
    required this.context,
    required GlobalKey<FormState> formLogin,
    required this.emailController,
    required this.passController,
    required this.provider,
    required this.text,
    required this.employee,
  }) : _formLogin = formLogin;

  final BuildContext context;
  final GlobalKey<FormState> _formLogin;
  final TextEditingController emailController;
  final TextEditingController passController;
  final SignInSocialNetworkInProvider provider;
  final String text;
  final SettingsProvider employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10),
      child: (provider.loadingAuth)
          ? const CircularProgressIndicator()
          : TextButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (_formLogin.currentState!.validate()) {
                  await provider.emailAuth(
                      emailController.text, passController.text);
                  if (provider.isAuth) {
                    await employee.userData(emailController.text);
                    if (employee.status) {
                      var home = await employee.homeRole();
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => home,
                          ),
                        );
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Correo/contraseña incorrecta o usuario deshabilitado")));
                      }
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Correo/contraseña incorrecta o usuario deshabilitado")));
                    }
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2 * 1.5,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(text,
                        style: const TextStyle(
                          letterSpacing: 0.25,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: fontSizeMedium,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
