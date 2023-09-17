// import 'package:app_restaurant_management/home/bloc/sing_in_social_networks.dart';
import 'package:app_restaurant_management/home.dart';
import 'package:app_restaurant_management/home/bloc/order_provider.dart';
import 'package:app_restaurant_management/home/bloc/sing_in_social_networks.dart';
import 'package:app_restaurant_management/home/screens/sign_in.dart';
import 'package:app_restaurant_management/menu/bloc/menu_provider.dart';
import 'package:app_restaurant_management/settings/bloc/setting_provider.dart';
import 'package:app_restaurant_management/stock/bloc/stock_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
        ChangeNotifierProvider(create: (context) => SettingsProvider()..getAllEmployees()..getAllCategories()),
        ChangeNotifierProvider(create: (context) => MenuProvider()..getAllProducts()),
        ChangeNotifierProvider(create: (context) => StockProvider()..getAllStocks()),
        ChangeNotifierProvider(create: (context) => OrderProvider()..getAllOrders()),
      ],
      child: MaterialApp(
        title: 'Restaurant Management',
        theme: ThemeData(
          primarySwatch: Colors.red,
          inputDecorationTheme: InputDecorationTheme(
            border: const OutlineInputBorder(),
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
          // radioTheme: const RadioThemeData(
          //   visualDensity: VisualDensity(
          //     horizontal: VisualDensity.minimumDensity,
          //     vertical: VisualDensity.minimumDensity,
          //   ),
          // ),
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
  // bool status = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // final provider = Provider.of<SettingsProvider>(context, listen: false);
      // final user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      //   provider.getAllEmployees();
      //   final list = provider.listEmployees;
      //   final id =
      //       list.where((element) => element.email == user.email).toList();
      // status = id[0].status;
      // }
    });
    _loadingData();
    super.initState();
  }

  _loadingData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var authProvider =
          Provider.of<SignInSocialNetworkInProvider>(context, listen: false);

      authProvider.loadingValidate = true;
      var preferencias = await SharedPreferences.getInstance();

      if (preferencias.getString("uid_user") != null) {
        await authProvider.validateToken();
      }
      authProvider.loadingValidate = false;
      if (kDebugMode) {
        print("========Termino=======");
      }
      if (kDebugMode) {
        print(authProvider.loadingValidate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<SignInSocialNetworkInProvider>(context);
    if (authProvider.loadingValidate) {
      return _showLoading(context);
    } else {
      if (authProvider.isAuth == false) {
        return const Login();
      } else {
        // if (status) {
        return const Home();
        // } else {
        // return const Login();
        // }
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
