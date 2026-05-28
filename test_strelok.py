import math

def calculate_g7():
    v0 = 787
    bc = 0.218 # G7 BC for 168gr SMK
    distance = 914.4
    angleDegrees = 0
    temperatureC = 15.0
    pressureHpa = 29.53 * 33.8639
    humidity = 78

    temperatureK = temperatureC + 273.15
    es = 6.112 * math.exp((17.67 * temperatureC) / (temperatureC + 243.5))
    ev = (humidity / 100.0) * es
    pd = pressureHpa - ev
    rho = (pd * 100) / (287.058 * temperatureK) + (ev * 100) / (461.495 * temperatureK)
    speedOfSound = math.sqrt(1.4 * 287.058 * temperatureK)

    g = 9.80665
    dt = 0.001
    
    machG7 = [0.0, 0.2, 0.4, 0.6, 0.7, 0.8, 0.9, 0.95, 1.0, 1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.8, 2.0, 2.2, 2.5, 3.0, 3.5, 4.0, 5.0]
    cdG7 = [0.115, 0.115, 0.115, 0.116, 0.118, 0.123, 0.141, 0.183, 0.276, 0.355, 0.376, 0.370, 0.355, 0.342, 0.330, 0.320, 0.301, 0.285, 0.271, 0.252, 0.228, 0.208, 0.192, 0.168]

    def interpolateCd(mach):
        if mach <= machG7[0]: return cdG7[0]
        if mach >= machG7[-1]: return cdG7[-1]
        for i in range(len(machG7) - 1):
            if machG7[i] <= mach <= machG7[i + 1]:
                t = (mach - machG7[i]) / (machG7[i + 1] - machG7[i])
                return cdG7[i] + t * (cdG7[i + 1] - cdG7[i])
        return cdG7[-1]

    x, y, z = 0.0, 0.0, 0.0
    vx, vy, vz = v0, 0.0, 0.0
    y_at_zero = 0.0
    passed_zero = False
    
    while x <= distance + (vx * dt * 2):
        if not passed_zero and x >= 100:
            y_at_zero = y
            passed_zero = True
            
        if x >= distance:
            climb_angle = (0.05 - y_at_zero) / 100.0
            drop = y + climb_angle * distance - 0.05
            mrad = -(drop * 100) / (distance / 10.0)
            v = math.sqrt(vx*vx+vy*vy+vz*vz)
            return mrad, v

        vr = math.sqrt(vx*vx + vy*vy + vz*vz)
        cdStd = interpolateCd(vr / speedOfSound)
        
        dragAccel = (0.00055855 * rho * vr * vr * cdStd) / max(bc, 0.01)
        ax = -(dragAccel * (vx / vr))
        ay = -(dragAccel * (vy / vr)) - g

        vx += ax * dt
        vy += ay * dt
        x += vx * dt
        y += vy * dt

    return 0, 0

print("G7 with BC 0.218:")
print(calculate_g7())

