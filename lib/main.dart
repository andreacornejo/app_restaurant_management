// import 'package:app_restaurant_management/home/bloc/sing_in_social_networks.dart';
import 'package:app_restaurant_management/constans.dart';
import 'package:app_restaurant_management/home/home_admin.dart';
import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/bloc/sing_in_social_networks.dart';
import 'package:app_restaurant_management/home/home_cashier.dart';
import 'package:app_restaurant_management/home/home_chef.dart';
import 'package:app_restaurant_management/home/home_delivery.dart';
import 'package:app_restaurant_management/home/screens/sign_in.dart';
import 'package:app_restaurant_management/menu/bloc/menu_provider.dart';
import 'package:app_restaurant_management/sales/bloc/sales_provider.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  OutlineInputBorder borderInput({Color color = Colors.black}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => SignInSocialNetworkInProvider()),
        ChangeNotifierProvider<SettingsProvider>(
            create: (context) => SettingsProvider()),
        ChangeNotifierProvider<MenuProvider>(
            create: (context) => MenuProvider()),
        ChangeNotifierProvider<StockProvider>(
            create: (context) => StockProvider()),
        ChangeNotifierProvider<OrderProvider>(
            create: (context) => OrderProvider()),
        ChangeNotifierProvider<SalesProvider>(
            create: (context) => SalesProvider()),
      ],
      child: MaterialApp(
        title: 'Restaurant Management',
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
          Locale('en', 'US'),
        ],
        theme: ThemeData(
          checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.red;
                }
                return null;
              },
            ),
            side: MaterialStateBorderSide.resolveWith(
              (states) {
                if (states.contains(MaterialState.selected)) {
                  return const BorderSide(color: Colors.red);
                }
                return null;
              },
            ),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.red,
            selectionColor: Colors.red[200],
            selectionHandleColor: Colors.red[400],
          ),
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: Colors.red),
          colorScheme: const ColorScheme.light(
            background: Colors.white, // Cambiar a color blanco
            primary: cardColor,
            surface: cardColor,
            onPrimary: fontBlack,
            onSurface: fontBlack,
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.all(9),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: borderInput(),
            focusedErrorBorder: borderInput(),
            focusedBorder: borderInput(),
            errorBorder: borderInput(color: Colors.red),
          ),
          dropdownMenuTheme: DropdownMenuThemeData(
              inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(9),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: borderInput(),
            focusedErrorBorder: borderInput(),
            focusedBorder: borderInput(),
            errorBorder: borderInput(color: Colors.red),
          )),
          radioTheme: RadioThemeData(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.red;
              }
              return null;
            }),
          ),
        ),
        home: const ValidateToken(),
      ),
    );
  }
}

class ValidateToken extends StatefulWidget {
  const ValidateToken({Key? key}) : super(key: key);

  @override
  State<ValidateToken> createState() => _ValidateTokenState();
}

class _ValidateTokenState extends State<ValidateToken> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _loadingData();
      await _validateStatus();
    });
    super.initState();
  }

  _loadingData() async {
    var authProvider =
        Provider.of<SignInSocialNetworkInProvider>(context, listen: false);

    authProvider.loadingValidate = true;
    var preferencias = await SharedPreferences.getInstance();

    if (preferencias.getString("uid_user") != null) {
      await authProvider.validateToken();
    }
    authProvider.loadingValidate = false;
    if (kDebugMode) {
      // print("========Termino=======");
    }
    if (kDebugMode) {
      // print(authProvider.loadingValidate);
    }
  }

  _validateStatus() async {
    var employee = Provider.of<SettingsProvider>(context, listen: false);
    var preferencias = await SharedPreferences.getInstance();
    await employee.userData(preferencias.getString('email')!);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<SignInSocialNetworkInProvider>(context);
    final employee = Provider.of<SettingsProvider>(context);
    if (authProvider.loadingValidate) {
      return _showLoading(context);
    } else {
      if (authProvider.isAuth == false) {
        return const Login();
      } else {
        if (employee.status) {
          switch (employee.rol) {
            case 'Administrador':
              return const HomeAdmin();
            case 'Cajero':
              return const HomeCashier();
            case 'Cocinero':
              return const HomeChef();
            case 'Repartidor':
              return const HomeDelivery();
            default:
              return const HomeCashier();
          }
        } else {
          return const Login();
        }
      }
    }
  }

  Scaffold _showLoading(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            "assets/img/logo-app.png",
            width: MediaQuery.of(context).size.width / 4,
          ),
          const SizedBox(height: 20),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
