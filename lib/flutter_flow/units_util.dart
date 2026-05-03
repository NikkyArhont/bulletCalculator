import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

enum DistanceUnit { m, yd }
enum TemperatureUnit { c, f }
enum PressureUnit { mm, hpa, inhg }

class UnitsManager extends ChangeNotifier {
  UnitsManager._();
  static final UnitsManager instance = UnitsManager._();

  DistanceUnit distanceUnit = DistanceUnit.m;
  TemperatureUnit temperatureUnit = TemperatureUnit.c;
  PressureUnit pressureUnit = PressureUnit.mm;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final d = prefs.getString('distance_unit') ?? 'm';
    final t = prefs.getString('temp_unit') ?? 'c';
    final p = prefs.getString('pressure_unit') ?? 'mm';

    distanceUnit = d == 'yd' ? DistanceUnit.yd : DistanceUnit.m;
    temperatureUnit = t == 'f' ? TemperatureUnit.f : TemperatureUnit.c;
    
    if (p == 'hpa') {
      pressureUnit = PressureUnit.hpa;
    } else if (p == 'inhg') {
      pressureUnit = PressureUnit.inhg;
    } else {
      pressureUnit = PressureUnit.mm;
    }
    notifyListeners();
  }

  Future<void> updateDistanceUnit(String unit) async {
    distanceUnit = unit == 'yd' ? DistanceUnit.yd : DistanceUnit.m;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('distance_unit', unit);
    notifyListeners();
  }

  Future<void> updateTemperatureUnit(String unit) async {
    temperatureUnit = unit == 'f' ? TemperatureUnit.f : TemperatureUnit.c;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('temp_unit', unit);
    notifyListeners();
  }

  Future<void> updatePressureUnit(String unit) async {
    if (unit == 'hpa') {
      pressureUnit = PressureUnit.hpa;
    } else if (unit == 'inhg') {
      pressureUnit = PressureUnit.inhg;
    } else {
      pressureUnit = PressureUnit.mm;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pressure_unit', unit);
    notifyListeners();
  }

  String get distanceLabel => distanceUnit == DistanceUnit.m ? 'м' : 'yd';
  String get temperatureLabel => temperatureUnit == TemperatureUnit.c ? '°C' : '°F';
  String get pressureLabel {
    if (pressureUnit == PressureUnit.hpa) return 'hPa';
    if (pressureUnit == PressureUnit.inhg) return 'inHg';
    return 'mmHg';
  }
}

class UnitConverter {
  // Distance: m <-> yd (1 m = 1.09361 yd)
  static double metersToYards(double m) => m * 1.09361;
  static double yardsToMeters(double yd) => yd / 1.09361;

  // Temperature: C <-> F (F = C * 9/5 + 32)
  static double celsiusToFahrenheit(double c) => (c * 9 / 5) + 32;
  static double fahrenheitToCelsius(double f) => (f - 32) * 5 / 9;

  // Pressure: mmHg <-> hPa (1 mmHg = 1.33322 hPa), inHg (1 mmHg = 0.03937 inHg)
  static double mmHgTohPa(double mmHg) => mmHg * 1.33322;
  static double hPaTommHg(double hPa) => hPa / 1.33322;
  static double mmHgToInHg(double mmHg) => mmHg * 0.0393701;
  static double inHgToMmHg(double inHg) => inHg / 0.0393701;

  // Generic conversion based on Current Settings
  static double convertDistance(double val, {bool toSelected = true}) {
    if (UnitsManager.instance.distanceUnit == DistanceUnit.m) return val;
    return toSelected ? metersToYards(val) : yardsToMeters(val);
  }

  static double convertTemperature(double val, {bool toSelected = true}) {
    if (UnitsManager.instance.temperatureUnit == TemperatureUnit.c) return val;
    return toSelected ? celsiusToFahrenheit(val) : fahrenheitToCelsius(val);
  }

  static double convertPressure(double val, {bool toSelected = true}) {
    if (UnitsManager.instance.pressureUnit == PressureUnit.mm) return val;
    if (toSelected) {
      return UnitsManager.instance.pressureUnit == PressureUnit.hpa
          ? mmHgTohPa(val)
          : mmHgToInHg(val);
    } else {
      return UnitsManager.instance.pressureUnit == PressureUnit.hpa
          ? hPaTommHg(val)
          : inHgToMmHg(val);
    }
  }
}
