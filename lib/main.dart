import 'package:athulya_app/pages/direct_modules.dart';
import 'package:athulya_app/pages/direct_page.dart';
import 'package:athulya_app/pages/main_page.dart';
import 'package:athulya_app/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:athulya_app/pages/my_home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Athulya Senior Care'),
      // home: UserPage(),

      // home: MainPage(),

      // home: DirectPage(),

      home: DirectModules(),
    );
  }
}
