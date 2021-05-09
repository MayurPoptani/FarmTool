import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';

User? globalUser;
Position? globalPos;
SharedPreferences? prefs;
WeatherFactory globalWeather = new WeatherFactory("816ac03c3873f5edc5908479c26e1677");