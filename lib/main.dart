import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'IN'), Locale('hi', 'IN')],
    path: 'assets/translations', // <-- change the path of the translation files 
    fallbackLocale: Locale('hi', 'IN'),
    startLocale: Locale('hi', 'IN'),
    // assetLoader: JsonAssetLoader(),
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Tool',
      theme: ThemeData(
        // scaffoldBackgroundColor: Color(0xFFf5f4f0),
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LoginPage(),
    );
  }
}
