import 'package:farmtool/Dashboard/Dashboard.dart';
import 'package:farmtool/Global/functions/AWSConfiguration.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAWS();
  try {
    gUser = await Amplify.Auth.getCurrentUser();
  } on AuthException catch (e) {
    print(e.message??""+" == "+e.recoverySuggestion??""+" == "+e.underlyingException??"");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: gUser!=null ? Dashboard() : LoginPage()
    );
  }
}
