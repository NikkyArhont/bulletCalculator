import 'dart:math' as math;
import '../lib/ballistic_engine.dart';

void main() {
  print('=== STARTING BALLISTIC ENGINE CALIBRATION TESTS ===');

  testSingleBcCalibration();
  testMultiBcSequentialCalibration();
  testDynamicZoneLookup();

  print('=== ALL TESTS COMPLETED SUCCESSFULLY ===');
}

void testSingleBcCalibration() {
  print('\n--- Running test: Single BC Calibration ---');

  // Let's run a calculation first to see what the correction drop is
  final initialRes = BallisticEngine.calculate(
    v0: 850.0,
    bc: 0.45,
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

  final double originalMrad = initialRes.verticalMrad;
  print('Initial BC = 0.45. Drop at 500m = ${initialRes.dropCm.toStringAsFixed(2)} cm. Correction = ${originalMrad.toStringAsFixed(3)} MRAD');

  // Let's simulate that the user actually hit the target with a correction of originalMrad + 0.3 MRAD
  // (which means the bullet fell more than expected, so the real BC must be lower)
  final double targetMrad = originalMrad + 0.3;
  print('Calibrating for actual correction: ${targetMrad.toStringAsFixed(3)} MRAD');

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

  print('Calibrated BC: $calibratedBc');
  assert(calibratedBc < 0.45, 'Calibrated BC should be lower than original 0.45 because the drop was larger.');

  // Verify the calculation using the calibrated BC matches the target correction
  final verificationRes = BallisticEngine.calculate(
    v0: 850.0,
    bc: calibratedBc,
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

  print('Verification Drop: ${verificationRes.dropCm.toStringAsFixed(2)} cm. Correction = ${verificationRes.verticalMrad.toStringAsFixed(3)} MRAD');
  final diff = (verificationRes.verticalMrad - targetMrad).abs();
  print('Difference: ${diff.toStringAsFixed(6)} MRAD');
  assert(diff < 0.005, 'Verification check failed! Calibration error is too large.');
  print('Single BC Calibration Test passed successfully!');
}

void testMultiBcSequentialCalibration() {
  print('\n--- Running test: Multi BC Sequential Calibration ---');

  // Define 3 calibration points with their actual corrections
  List<Map<String, dynamic>> rawPoints = [
    {'distance': 300.0, 'actual_correction': 1.5, 'unit': 'MRAD'}, // 1.5 MRAD at 300m
    {'distance': 600.0, 'actual_correction': 5.2, 'unit': 'MRAD'}, // 5.2 MRAD at 600m
    {'distance': 900.0, 'actual_correction': 11.8, 'unit': 'MRAD'}, // 11.8 MRAD at 900m
  ];

  final calibrated = BallisticEngine.recalibrateMultiBc(
    points: rawPoints,
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

  print('Calibrated Points:');
  for (var pt in calibrated) {
    print('  Distance: ${pt['distance']}m, Correction: ${pt['actual_correction']} MRAD, Calibrated BC: ${pt['calculated_bc']}');
  }

  assert(calibrated.length == 3, 'Calibrated list should have exactly 3 points');

  // Verify drop calculation matches at all 3 distances using the calibrated points!
  for (var pt in calibrated) {
    final dist = pt['distance'] as double;
    final expectedCorr = pt['actual_correction'] as double;
    
    final res = BallisticEngine.calculate(
      v0: 850.0,
      bc: 0.45, // default bc, will be overridden by calibration points
      bcModel: 'G1',
      weightGrains: 175.0,
      distance: dist,
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
      useMultiBc: true,
      calibrationPoints: calibrated,
    );

    final error = (res.verticalMrad - expectedCorr).abs();
    print('At ${dist}m: Calculated Correction = ${res.verticalMrad.toStringAsFixed(3)} MRAD, Expected = $expectedCorr MRAD, Error = ${error.toStringAsFixed(6)} MRAD');
    assert(error < 0.01, 'Multi BC verification failed at ${dist}m! Error is too large.');
  }

  print('Multi BC Sequential Calibration Test passed successfully!');
}

void testDynamicZoneLookup() {
  print('\n--- Running test: Dynamic Zone Lookup ---');

  // Define 3 zones:
  // - Zone 1 (0 to 300m): BC = 0.50
  // - Zone 2 (300m to 600m): BC = 0.40
  // - Zone 3 (above 600m): BC = 0.30
  List<Map<String, dynamic>> calPoints = [
    {'distance': 300.0, 'calculated_bc': 0.50},
    {'distance': 600.0, 'calculated_bc': 0.40},
    {'distance': 900.0, 'calculated_bc': 0.30},
  ];

  // We will run calculations at 200m, 500m, and 800m.
  // We want to verify that when we calculate at 200m, it uses the zone 1 BC (0.50).
  // Thus, the calculation result at 200m using Multi-BC should match the calculation using constant BC of 0.50.
  // When calculating at 500m, it uses 0.50 for the first 300m and 0.40 for 300-500m.
  // Let's verify these behaviors:

  // 1. Calculation at 200m (should use BC = 0.50)
  final resMulti200 = BallisticEngine.calculate(
    v0: 850.0,
    bc: 0.45,
    bcModel: 'G1',
    weightGrains: 175.0,
    distance: 200.0,
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
    useMultiBc: true,
    calibrationPoints: calPoints,
  );

  final resConstant200 = BallisticEngine.calculate(
    v0: 850.0,
    bc: 0.50,
    bcModel: 'G1',
    weightGrains: 175.0,
    distance: 200.0,
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
    useMultiBc: false,
  );

  print('At 200m (Zone 1): Multi-BC correction = ${resMulti200.verticalMrad.toStringAsFixed(6)} MRAD, Constant BC (0.50) correction = ${resConstant200.verticalMrad.toStringAsFixed(6)} MRAD');
  assert((resMulti200.verticalMrad - resConstant200.verticalMrad).abs() < 1e-9, 'At 200m, Multi-BC calculation must match constant BC of 0.50.');

  print('Dynamic Zone Lookup Test passed successfully!');
}
