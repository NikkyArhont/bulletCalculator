import 'dart:math' as math;

/// BallisticResult stores the calculated parameters for a specific shot.
class BallisticResult {
  final double verticalMrad;
  final double horizontalMrad;
  final int verticalClicks;
  final int horizontalClicks;
  final double dropCm;
  final double windDriftCm;
  final double timeOfFlight;
  final double velocityAtTarget;
  final double energyAtTarget;

  BallisticResult({
    required this.verticalMrad,
    required this.horizontalMrad,
    required this.verticalClicks,
    required this.horizontalClicks,
    required this.dropCm,
    required this.windDriftCm,
    required this.timeOfFlight,
    required this.velocityAtTarget,
    required this.energyAtTarget,
  });
}

class BallisticEngine {
  static const double g = 9.80665; // Standard gravity (m/s^2)
  static const double rho0 = 1.225; // Standard air density (kg/m^3)

  /// Calculates ballistic corrections using an approximate numerical integration model.
  /// This is an MVP-level engine and should not be considered as high-precision (like Applied Ballistics).
  static BallisticResult calculate({
    required double v0,               // Initial velocity (m/s)
    required double bc,               // Ballistic coefficient (approximate usage)
    required double weightGrams,      // Bullet weight (grams)
    required double distance,         // Target distance (meters)
    required double windSpeed,        // Wind speed (m/s)
    required double windDirectionHours, // Wind direction (1-12 o'clock)
    required double temperatureC,     // Temperature (Celsius)
    required double pressureHpa,      // Air pressure (hPa)
    required double sightHeightMm,    // Sight height above bore (mm)
    required double clickValue,       // Scope click value (e.g. 0.1 for MRAD)
  }) {
    // 1. Environmental correction (Air Density)
    final double temperatureK = temperatureC + 273.15;
    // Simple air density formula: rho = P / (R * T)
    final double rho = (pressureHpa * 100) / (287.058 * temperatureK);
    final double densityFactor = rho / rho0;

    // 2. Wind vector calculation
    // Convert hours to radians. 12 o'clock is 0 rad (headwind), 3 is pi/2 (right wind)
    final double windAngleRad = (windDirectionHours % 12) * (math.pi / 6);
    final double windX = windSpeed * math.sin(windAngleRad); // Crosswind component
    final double windZ = windSpeed * math.cos(windAngleRad); // Head/Tailwind component

    // 3. Numerical Integration (Approximate Euler Method)
    double x = 0.0;
    double y = -(sightHeightMm / 1000.0); // Start at sight height below bore
    double z = 0.0; // Horizontal drift (not windage yet)
    
    double vx = v0;
    double vy = 0.0; // Assuming zero angle for simplified drop
    double vz = 0.0;
    
    double t = 0.0;
    const double dt = 0.002; // 2ms step
    
    // We iterate until we reach the target distance
    while (x < distance) {
      // Relative velocity to wind for drag
      // Simplified: wind only affects horizontal drift (z) and velocity loss (x)
      double vrx = vx + windZ; // Headwind slows down more
      double vrz = vz - windX; // Crosswind pushes side
      double vry = vy;
      
      double vr = math.sqrt(vrx * vrx + vry * vry + vrz * vrz);
      
      // Approximate Drag Model
      // Force = 0.5 * rho * v^2 * Cd * A. Here we use BC as a shortcut.
      // a_drag = approximateDragModel(vr, bc, densityFactor)
      double dragAccel = _approximateDragModel(vr, bc, densityFactor);
      
      double ax = -(dragAccel * (vrx / vr));
      double ay = -g - (dragAccel * (vry / vr));
      double az = -(dragAccel * (vrz / vr));

      // Update state
      vx += ax * dt;
      vy += ay * dt;
      vz += az * dt;
      
      x += vx * dt;
      y += vy * dt;
      z += vz * dt;
      t += dt;

      // Break if velocity drops too low
      if (vx < 150) break;
    }

    // 4. Extract Results
    final double dropCm = -y * 100;
    final double driftCm = z * 100;
    final double finalVelocity = math.sqrt(vx * vx + vy * vy + vz * vz);
    final double weightKg = weightGrams / 1000.0;
    final double energy = 0.5 * weightKg * finalVelocity * finalVelocity;

    // Corrections in MRAD (approximate)
    // 1 MRAD at D meters = D / 1000 meters = D / 10 cm
    final double verticalMrad = (dropCm / (distance / 10.0));
    final double horizontalMrad = (driftCm / (distance / 10.0));

    // Clicks
    final int vClicks = (verticalMrad / clickValue).round();
    final int hClicks = (horizontalMrad / clickValue).round();

    return BallisticResult(
      verticalMrad: verticalMrad,
      horizontalMrad: horizontalMrad,
      verticalClicks: vClicks,
      horizontalClicks: hClicks,
      dropCm: dropCm,
      windDriftCm: driftCm,
      timeOfFlight: t,
      velocityAtTarget: finalVelocity,
      energyAtTarget: energy,
    );
  }

  /// Approximate drag model based on ballistic coefficient.
  /// This is a simplified fallback when G1/G7 drag tables are not available.
  static double _approximateDragModel(double v, double bc, double densityFactor) {
    // k = drag coefficient proxy. Increased to ~0.00018 for more realistic
    // velocity decay in standard calibers (matching MVP expectations).
    double k = 0.00018;
    return (k * v * v * densityFactor) / bc;
  }
}
