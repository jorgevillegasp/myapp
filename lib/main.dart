import 'package:flutter/material.dart';
import 'package:myapp/modules/product/page/home_screen1.dart';
import 'package:myapp/modules/product/services/category_providers.dart';
import 'package:myapp/modules/aut/services/login_provider.dart';
import 'package:myapp/modules/product/services/product_provider.dart';
import 'package:myapp/shared/preferences.dart';
import 'package:provider/provider.dart';

import 'modules/aut/page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const Provedores());
}

class Provedores extends StatelessWidget {
  const Provedores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',

      home: Preferences.token.isEmpty ? const LoginPage() : const  HomeScreen1(),

      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        fontFamily: 'SanFranciscoPro',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        //cambiar el tema de los botones
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
