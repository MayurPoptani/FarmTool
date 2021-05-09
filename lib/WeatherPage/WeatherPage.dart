import 'package:farmtool/Global/variables/variables.dart';
import 'package:farmtool/WeatherPage/WeatherCodeMapping.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';
import 'package:farmtool/Global/widgets/MyExtentions.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  Weather? w;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getWeatherInfo();
  }

  getWeatherInfo() async {
    if(prefs!.getString("locale_lang_code")=='en') globalWeather.language = Language.ENGLISH;
    else globalWeather.language = Language.HINDI;
    w = await globalWeather.currentWeatherByLocation(globalPos!.latitude, globalPos!.longitude);
    isLoading = false;
    if(mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green),)
      ) : Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            WeatherBg(
              weatherType: WeatherCodeMapping.getWeatherType(w!.weatherConditionCode??-1),
              height: context.deviceSize.height,
              width: context.deviceSize.width,
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("WEATHER", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text((w!.weatherMain??"No Information")+"\n"+(w!.weatherDescription??"No Information"), style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                  24.heightbox,
                  Text("TEMPERATURE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Text(w!.temperature?.toString()??"No Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                  24.heightbox,
                  Text("WIND SPEED", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Text((w!.windSpeed?.toString()??"-")+" m/s", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                  24.heightbox,
                  Text("HUMIDITY", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Text(w!.humidity?.toString()??"No Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                  24.heightbox,
                  Text("RAIN IN LAST 1 HOURS", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Text(w!.rainLastHour?.toString()??"No Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                  24.heightbox,
                  Text("RAIN IN LAST 3 HOURS", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Text(w!.rainLast3Hours?.toString()??"No Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}