import 'dart:math' as math;
import 'lib/ballistic_engine.dart';

void main() {
  for (double testBc = 0.2; testBc <= 1.0; testBc += 0.001) {
    final res = BallisticEngine.calculate(
      v0: 850,
      bc: testBc,
      bcModel: 'G1',
      weightGrains: 148,
      distance: 1000,
      zeroDistance: 100,
      windSpeed: 0,
      windDirectionHours: 0,
      temperatureC: 15,
      pressureHpa: 992,
      humidity: 39,
      angleDegrees: 0,
      sightHeightMm: 90,
      clickValue: 0.1,
      caliberMm: 7.62,
      twistMm: 305.0,
      twistDirection: 'right',
      bulletLengthMm: 32.0,
    );
    if ((res.velocityAtTarget - 629.0).abs() < 1.0) {
      print('BC = $testBc gives ${res.velocityAtTarget} m/s in G1');
      break;
    }
  }

  for (double testBc = 0.2; testBc <= 1.0; testBc += 0.001) {
    final res = BallisticEngine.calculate(
      v0: 850,
      bc: testBc,
      bcModel: 'G7',
      weightGrains: 148,
      distance: 1000,
      zeroDistance: 100,
      windSpeed: 0,
      windDirectionHours: 0,
      temperatureC: 15,
      pressureHpa: 992,
      humidity: 39,
      angleDegrees: 0,
      sightHeightMm: 90,
      clickValue: 0.1,
      caliberMm: 7.62,
      twistMm: 305.0,
      twistDirection: 'right',
      bulletLengthMm: 32.0,
    );
    if ((res.velocityAtTarget - 629.0).abs() < 1.0) {
      print('BC = $testBc gives ${res.velocityAtTarget} m/s in G7');
      break;
    }
  }
}
