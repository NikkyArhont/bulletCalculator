import 'dart:math' as math;
import '../lib/ballistic_engine.dart';

void main() {
  print('=== DEBUG CALIBRATION ===');

  final double targetMrad = 3.263;
  print('Calibrating for actual correction: 3.263 MRAD');

  // Let's copy the calibrateBc logic inline or call it and print inside
  final double calibratedBc = BallisticEngine.calibrateBc(
    targetDistance: 500.0,
    actualCorrection: targetMrad,
    correctionUnit: 'MRAD',
    v0: 850.0,
    bcModel: 'G1',
    weightGrains: 175.0,
    zeroDistance: 100.0,
    windSpeed: 0.0,
    windDirectionHours: 3.0,
    temperatureC: 15.0,
    pressureHpa: 1013.25,
    humidity: 50.0,
    angleDegrees: 0.0,
    sightHeightMm: 50.0,
    clickValue: 0.1,
    clickType: 'MRAD',
    caliberMm: 7.62,
    twistMm: 305.0,
    twistDirection: 'right',
    bulletLengthMm: 32.0,
  );

  print('Calibrated BC returned: $calibratedBc');

  // Let's run calculate with various BCs around calibratedBc
  for (double b = calibratedBc - 0.005; b <= calibratedBc + 0.005; b += 0.001) {
    final res = BallisticEngine.calculate(
      v0: 850.0,
      bc: b,
      bcModel: 'G1',
      weightGrains: 175.0,
      distance: 500.0,
      zeroDistance: 100.0,
      windSpeed: 0.0,
      windDirectionHours: 3.0,
      temperatureC: 15.0,
      pressureHpa: 1013.25,
      humidity: 50.0,
      angleDegrees: 0.0,
      sightHeightMm: 50.0,
      clickValue: 0.1,
      caliberMm: 7.62,
      twistMm: 305.0,
      twistDirection: 'right',
      bulletLengthMm: 32.0,
    );
    print('BC: ${b.toStringAsFixed(4)} -> verticalMrad: ${res.verticalMrad.toStringAsFixed(6)}');
  }
}
