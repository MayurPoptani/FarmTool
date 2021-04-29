import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
class ChangeLanguagePage extends StatefulWidget {
  final bool shownOnAppStart;

  const ChangeLanguagePage({Key? key, this.shownOnAppStart = false}) : super(key: key);
  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  
  late Locale selectedLocale;
  
  @override
  void initState() {
    selectedLocale = Locale(prefs!.getString("locale_lang_code")!, prefs!.getString("locale_country_code")!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: widget.shownOnAppStart ? null : 0,
        title: Text("Select Language / भाषा का चयन करें", style: TextStyle(color: Colors.black),),
        leading: widget.shownOnAppStart ? null : IconButton(
          icon: Icon(Icons.chevron_left_rounded,), 
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Wrap(
                    // direction: Axis.vertical,
                    children: ({
                      "English" : Locale("en", "IN"), 
                      "हिंदी" : Locale("hi", "IN"),
                    }.entries).map((e) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => setState(() => selectedLocale = e.value),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          shadowColor: Colors.black54,
                          color: selectedLocale == e.value ? Colors.green : Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Text(e.key, style: TextStyle(color: selectedLocale == e.value ? Colors.white : Colors.black, fontSize: 16, fontWeight: FontWeight.bold,),),
                          
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(CHANGELANGUAGEPAGE.HELPER_LABEL, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 16,),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(CHANGELANGUAGEPAGE.BUTTON_LABEL),
                  ),
                  onPressed: () async {
                    await context.setLocale(selectedLocale);
                    prefs!.setString("locale_lang_code", selectedLocale.languageCode);
                    prefs!.setString("locale_country_code", selectedLocale.countryCode!);
                    if(!widget.shownOnAppStart) Navigator.of(context).pop(); 
                    else Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage(),),);
                  }, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}