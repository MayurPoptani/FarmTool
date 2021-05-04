import 'package:flutter_weather_bg/flutter_weather_bg.dart';

class WeatherCodeMapping {
  static WeatherType getWeatherType(int c) {
    if(c >= 801 && c<=804) return WeatherType.cloudy;
    else if(c>=600 && c<=622) return WeatherType.middleSnow;
    else if(c>=500 && c<=531) return WeatherType.middleRainy;
    else if(c>=300 && c<=321) return WeatherType.lightRainy;
    else if(c>=200 && c<=232) return WeatherType.thunder;
    else return WeatherType.sunny;
  }

}