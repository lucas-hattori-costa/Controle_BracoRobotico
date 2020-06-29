# Alocacao de polos
import numpy as np

def PID_AP():
    # Kd, Ki, Kp
    A = np.array([[7.281, 0, 0], # s^7
    [0.501/50, 0, 7.281], # s^6
    [238.1, 7.281, 0.501/50], # s^5
    [0.339/2, 0.501/50, 238.1], # s^4
    [0,238.1,0.339/2], # s^3
    [0,0.339/2,0]] # s^2
    )

    B = np.array([
    [0  -1], # s^7
    [-0.001017  + 67.5], # s^6
    [-343.9/5   + 1578.25], # s^5
    [-0.2959/5  + 14129.625], # s^4
    [-1168  + 32322.625], # s^3
    [-1.663/2   + 19704.75]]) # s^2

    [KD, KI, KP] = np.linalg.lstsq(A,B, rcond=None)[0]

    return KD, KI, KP