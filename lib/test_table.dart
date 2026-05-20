import 'dart:math' as math;
import 'ballistic_engine.dart';

void main() {
  final distances = [100.0, 300.0, 500.0, 700.0, 850.0, 1000.0];

  print('Distance(m) | Vertical(MRAD) | Drop(cm) | Time(s) | Vel(m/s) | Energy(J)');
  print('-' * 75);

  for (final dist in distances) {
    final result = BallisticEngine.calculate(
      v0: 850.0,
      bc: 0.408,
      bcModel: 'G1',
      weightGrains: 148.0,
      distance: dist,
      zeroDistance: 100.0,
      windSpeed: 0.0, 
      windDirectionHours: 3.0,
      temperatureC: 15.0,
      pressureHpa: 992.0,
      humidity: 39.0,
      angleDegrees: 0.0,
      sightHeightMm: 90.0, 
      clickValue: 0.1,
    );

    final vMrad = result.verticalMrad.toStringAsFixed(2).padLeft(14);
    final drop = result.dropCm.toStringAsFixed(1).padLeft(8);
    final time = result.timeOfFlight.toStringAsFixed(3).padLeft(7);
    final vel = result.velocityAtTarget.toStringAsFixed(1).padLeft(8);
    final energy = result.energyAtTarget.toStringAsFixed(0).padLeft(9);

    print('${dist.toStringAsFixed(0).padLeft(11)} | $vMrad | $drop | $time | $vel | $energy');
  }
}
