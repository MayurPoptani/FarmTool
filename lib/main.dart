import 'package:farmtool/ChangeLanguagePage/ChangeLanguagePage.dart';
import 'package:farmtool/Dashboard/Dashboard.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  globalUser = FirebaseAuth.instance.currentUser;
  if(globalUser==null || !prefs!.containsKey("locale_lang_code")) {
    prefs!.setString("locale_lang_code", "en");
    prefs!.setString("locale_country_code", "IN");
  }
  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'IN'), Locale('hi', 'IN')],
    path: 'assets/translations', // <-- change the path of the translation files 
    fallbackLocale: Locale('en', 'IN'),
    saveLocale: true,
    startLocale: Locale(prefs!.getString("locale_lang_code")!, prefs!.getString("locale_country_code")!),
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
          // backgroundColor: MaterialStateProperty.all(colorBgColor,),
          backgroundColor: MaterialStateProperty.all(Colors.green.shade700,),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),),
        )),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: globalUser == null ? ChangeLanguagePage(shownOnAppStart: true) : Dashboard(),
    );
  }
}
