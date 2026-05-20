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
  final List<math.Point<double>> trajectoryPoints;

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
    required this.trajectoryPoints,
  });
}

class BallisticEngine {
  static const double g = 9.80665; // Standard gravity (m/s^2)
  static const double rho0 = 1.225; // Standard air density (kg/m^3)

  /// Calculates ballistic corrections using an approximate numerical integration model.
  /// This is an MVP-level engine and should not be considered as high-precision (like Applied Ballistics).
  static BallisticResult calculate({
    required double v0,               // Initial velocity (m/s)
    required double bc,               // Ballistic coefficient
    required String bcModel,          // G1 or G7
    required double weightGrains,     // Bullet weight (grains)
    required double distance,         // Target distance (meters)
    required double zeroDistance,     // Zero distance (meters)
    required double windSpeed,        // Wind speed (m/s)
    required double windDirectionHours, // Wind direction (1-12 o'clock)
    required double temperatureC,     // Temperature (Celsius)
    required double pressureHpa,      // Air pressure (hPa)
    required double humidity,         // Humidity (%)
    required double angleDegrees,     // Target inclination angle (degrees)
    required double sightHeightMm,    // Sight height above bore (mm)
    required double clickValue,       // Scope click value (e.g. 0.1 for MRAD)
  }) {
    // 1. Environmental correction (Air Density & Speed of Sound)
    final double temperatureK = temperatureC + 273.15;
    
    // Saturation vapor pressure (Tetens formula)
    final double es = 6.112 * math.exp((17.67 * temperatureC) / (temperatureC + 243.5));
    // Actual vapor pressure
    final double ev = (humidity / 100.0) * es;
    final double pd = pressureHpa - ev;
    
    // Air density using ideal gas law for moist air
    final double rho = (pd * 100) / (287.058 * temperatureK) + (ev * 100) / (461.495 * temperatureK);
    
    // Speed of sound (approximate in moist air, but dry air formula is very close)
    final double speedOfSound = math.sqrt(1.4 * 287.058 * temperatureK);

    // 2. Wind vector calculation (assuming X is Line of Sight)
    final double windAngleRad = (windDirectionHours % 12) * (math.pi / 6);
    final double windX = windSpeed * math.sin(windAngleRad); // Crosswind (orthogonal to LOS)
    final double windZ = windSpeed * math.cos(windAngleRad); // Head/Tailwind (parallel to ground)
    
    // 3. Inclination Angle (LOS angle)
    final double angleRad = angleDegrees * (math.pi / 180.0);
    // Gravity components relative to Line of Sight
    final double gx = g * math.sin(angleRad); // pulls bullet backwards/forwards
    final double gy = g * math.cos(angleRad); // pulls bullet downwards perpendicular to LOS

    // 4. Numerical Integration (Approximate Euler Method)
    double x = 0.0;
    double y = 0.0; // Raw physical drop perpendicular to LOS
    double z = 0.0; // Wind drift perpendicular to LOS
    
    double vx = v0;
    double vy = 0.0; 
    double vz = 0.0;
    
    double t = 0.0;
    const double dt = 0.002; 
    
    List<math.Point<double>> rawTrajectory = [];
    double nextSaveDist = 0.0;
    double saveInterval = distance > 0 ? distance / 50.0 : 10.0; 
    
    double zD = zeroDistance > 0 ? zeroDistance : 100.0;
    double maxDist = math.max(distance, zD);
    
    double yRawAtZero = 0.0;
    bool passedZero = false;
    
    double yRawAtTarget = 0.0;
    double zAtTarget = 0.0;
    double tAtTarget = 0.0;
    double finalVel = v0;
    bool passedTarget = false;
    
    while (x <= maxDist + (vx * dt * 2)) {
      if (x <= distance && x >= nextSaveDist) {
         rawTrajectory.add(math.Point(x, y));
         nextSaveDist += saveInterval;
      }
      
      if (!passedZero && x >= zD) {
         yRawAtZero = y;
         passedZero = true;
      }
      
      if (!passedTarget && x >= distance) {
         yRawAtTarget = y;
         zAtTarget = z;
         tAtTarget = t;
         finalVel = math.sqrt(vx*vx + vy*vy + vz*vz);
         passedTarget = true;
      }

      // Air resistance
      double vrx = vx + windZ * math.cos(angleRad); // headwind adjusted for inclination
      double vrz = vz - windX;
      double vry = vy + windZ * math.sin(angleRad); // vertical wind component
      
      double vr = math.sqrt(vrx * vrx + vry * vry + vrz * vrz);
      double mach = vr / speedOfSound;
      
      // Look up standard drag coefficient
      double cdStd = _interpolateCd(mach, bcModel);
      
      // Calculate deceleration scalar based on BC form factor
      // Formula: a = 0.5 * rho * v^2 * Cd_std * A_ref / m
      // Using BC (lb/in^2) definition standardizes area and mass.
      // Constant 0.00055855 resolves pi/8 * (0.0254^2 / 0.453592)
      double safeBc = bc > 0.01 ? bc : 0.01;
      double dragAccel = (0.00055855 * rho * vr * vr * cdStd) / safeBc;
      
      double ax = -(dragAccel * (vrx / vr)) - gx;
      double ay = -(dragAccel * (vry / vr)) - gy;
      double az = -(dragAccel * (vrz / vr));

      vx += ax * dt;
      vy += ay * dt;
      vz += az * dt;
      
      x += vx * dt;
      y += vy * dt;
      z += vz * dt;
      t += dt;

      if (vx < 50) break;
    }
    
    if (distance > 0 && (rawTrajectory.isEmpty || rawTrajectory.last.x < distance)) {
        rawTrajectory.add(math.Point(distance, yRawAtTarget));
    }

    // 5. Extract Results
    double sHeightM = sightHeightMm / 1000.0;
    
    // Barrel tilt to hit LOS at zero distance
    double climbAngle = (sHeightM - yRawAtZero) / zD;
    
    // Drop at target (relative to LOS)
    double correctionDropMeters = yRawAtTarget + (climbAngle * distance) - sHeightM;
    double correctionDropCm = -correctionDropMeters * 100; 
    
    List<math.Point<double>> correctedTrajectory = [];
    for (var p in rawTrajectory) {
       double yCorr = p.y + (climbAngle * p.x) - sHeightM;
       correctedTrajectory.add(math.Point(p.x, yCorr * 100));
    }

    final double driftCm = zAtTarget * 100;
    final double weightKg = weightGrains * 0.00006479891;
    final double energy = 0.5 * weightKg * finalVel * finalVel;

    final double verticalMrad = distance > 0 ? (correctionDropCm / (distance / 10.0)) : 0.0;
    final double horizontalMrad = distance > 0 ? (driftCm / (distance / 10.0)) : 0.0;

    final int vClicks = clickValue > 0 ? (verticalMrad / clickValue).round() : 0;
    final int hClicks = clickValue > 0 ? (horizontalMrad / clickValue).round() : 0;

    return BallisticResult(
      verticalMrad: verticalMrad,
      horizontalMrad: horizontalMrad,
      verticalClicks: vClicks,
      horizontalClicks: hClicks,
      dropCm: correctionDropCm, 
      windDriftCm: driftCm,
      timeOfFlight: tAtTarget,
      velocityAtTarget: finalVel,
      energyAtTarget: energy,
      trajectoryPoints: correctedTrajectory,
    );
  }

  /// Linear interpolation of standard G1/G7 drag coefficients (Source: JBM / McCoy standard tables)
  static double _interpolateCd(double mach, String bcModel) {
    final List<double> machG1 = [
      0.0, 0.2, 0.4, 0.6, 0.7, 0.8, 0.85, 0.9, 0.95, 1.0, 1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 2.0, 2.2, 2.5, 3.0, 3.5, 4.0, 5.0
    ];
    final List<double> cdG1 = [
      0.162, 0.162, 0.162, 0.163, 0.169, 0.184, 0.203, 0.244, 0.334, 0.428, 0.485, 0.505, 0.508, 0.490, 0.468, 0.448, 0.431, 0.415, 0.401, 0.375, 0.354, 0.327, 0.292, 0.266, 0.245, 0.214
    ];

    final List<double> machG7 = [
      0.0, 0.2, 0.4, 0.6, 0.7, 0.8, 0.9, 0.95, 1.0, 1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.8, 2.0, 2.2, 2.5, 3.0, 3.5, 4.0, 5.0
    ];
    final List<double> cdG7 = [
      0.115, 0.115, 0.115, 0.116, 0.118, 0.123, 0.141, 0.183, 0.276, 0.355, 0.376, 0.370, 0.355, 0.342, 0.330, 0.320, 0.301, 0.285, 0.271, 0.252, 0.228, 0.208, 0.192, 0.168
    ];

    List<double> mArr = bcModel == 'G7' ? machG7 : machG1;
    List<double> cArr = bcModel == 'G7' ? cdG7 : cdG1;

    if (mach <= mArr.first) return cArr.first;
    if (mach >= mArr.last) return cArr.last;

    for (int i = 0; i < mArr.length - 1; i++) {
      if (mach >= mArr[i] && mach <= mArr[i + 1]) {
        double t = (mach - mArr[i]) / (mArr[i + 1] - mArr[i]);
        return cArr[i] + t * (cArr[i + 1] - cArr[i]);
      }
    }
    return cArr.last;
  }
}
