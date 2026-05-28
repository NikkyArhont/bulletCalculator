import math

def calculate_jbm_equivalent():
    v0 = 850
    bc = 0.408
    distance = 1000
    angleDegrees = 0
    temperatureC = 15
    pressureHpa = 992
    humidity = 39

    temperatureK = temperatureC + 273.15
    es = 6.112 * math.exp((17.67 * temperatureC) / (temperatureC + 243.5))
    ev = (humidity / 100.0) * es
    pd = pressureHpa - ev
    rho = (pd * 100) / (287.058 * temperatureK) + (ev * 100) / (461.495 * temperatureK)
    speedOfSound = math.sqrt(1.4 * 287.058 * temperatureK)

    g = 9.80665
    dt = 0.0001 # 0.1 ms
    
    machG1 = [0.0, 0.2, 0.4, 0.6, 0.7, 0.8, 0.85, 0.9, 0.95, 1.0, 1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 2.0, 2.2, 2.5, 3.0, 3.5, 4.0, 5.0]
    cdG1 = [0.162, 0.162, 0.162, 0.163, 0.169, 0.184, 0.203, 0.244, 0.334, 0.428, 0.485, 0.505, 0.508, 0.490, 0.468, 0.448, 0.431, 0.415, 0.401, 0.375, 0.354, 0.327, 0.292, 0.266, 0.245, 0.214]

    def interpolateCd(mach):
        if mach <= machG1[0]: return cdG1[0]
        if mach >= machG1[-1]: return cdG1[-1]
        for i in range(len(machG1) - 1):
            if machG1[i] <= mach <= machG1[i + 1]:
                t = (mach - machG1[i]) / (machG1[i + 1] - machG1[i])
                return cdG1[i] + t * (cdG1[i + 1] - cdG1[i])
        return cdG1[-1]

    x, y, z = 0.0, 0.0, 0.0
    vx, vy, vz = v0, 0.0, 0.0
    t = 0.0
    y_at_zero = 0.0
    passed_zero = False
    
    print("Dist(m) | MRAD | V(m/s) | TOF(s)")
    for target in [100, 300, 500, 700, 850, 1000]:
        while x < target:
            if not passed_zero and x >= 100:
                y_at_zero = y
                passed_zero = True
            
            vr = math.sqrt(vx*vx + vy*vy + vz*vz)
            cdStd = interpolateCd(vr / speedOfSound)
            
            dragAccel = (0.00055855 * rho * vr * vr * cdStd) / bc
            ax = -(dragAccel * (vx / vr))
            ay = -(dragAccel * (vy / vr)) - g
            
            vx += ax * dt
            vy += ay * dt
            x += vx * dt
            y += vy * dt
            t += dt

        if not passed_zero and target == 100:
            y_at_zero = y
            passed_zero = True

        climb_angle = (0.09 - y_at_zero) / 100.0
        drop = y + climb_angle * target - 0.09
        mrad = -(drop * 100) / (target / 10.0) if target > 0 else 0
        v = math.sqrt(vx*vx + vy*vy + vz*vz)
        print(f"{target} | {mrad:.2f} | {v:.1f} | {t:.3f}")

calculate_jbm_equivalent()
