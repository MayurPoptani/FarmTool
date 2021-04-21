import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admin/firebase_admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseAdmin.instance.initializeApp(AppOptions(
    
  // ));
  // fAdmin = FirebaseAdmin.instance.app();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Tool',
      theme: ThemeData(
        fontFamily: "Raleway",
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          counterStyle: TextStyle(fontSize: double.minPositive,),
          labelStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
          elevation: MaterialStateProperty.all(4),
          shadowColor: MaterialStateProperty.all(Colors.white38,),
          backgroundColor: MaterialStateProperty.all(colorBgColor,),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),),
        )),
      ),
      home: LoginPage()
    );
  }
}
