import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

User? globalUser;
Position? globalPos;
SharedPreferences? prefs;