import 'dart:math' as math;
import 'ballistic_engine.dart';

void main() {
  final result = BallisticEngine.calculate(
    v0: 850.0,
    bc: 0.408,
    weightGrains: 148.0,
    distance: 1000.0,
    zeroDistance: 100.0,
    windSpeed: 0.0, // No wind specified in test case, assuming 0
    windDirectionHours: 3.0, // Default crosswind direction
    temperatureC: 15.0,
    pressureHpa: 992.0,
    sightHeightMm: 90.0, // 9 cm = 90 mm
    clickValue: 0.1,
  );

  print('Vertical MRAD: ${result.verticalMrad}');
  print('Horizontal MRAD: ${result.horizontalMrad}');
  print('Velocity at Target: ${result.velocityAtTarget}');
  print('Energy at Target: ${result.energyAtTarget}');
  print('Flight Time: ${result.timeOfFlight}');
}
