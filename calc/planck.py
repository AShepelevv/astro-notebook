import numpy as np

h = np.float64(6.626 * 10 ** (-34))
c = np.float64(3 * 10 ** 8)
k = np.float64(1.381 * 10 ** (-23))


def B(l, T):
    return np.pi * 2 * h * c ** 2 / l ** 5 / (np.exp(h * c / (np.float64(l) * k * np.float64(T))) - 1)


def vin(l):
    t = np.float64(0.0029) / np.float64(l)
    return B(l, t)


l_min = 20  # нм
l_max = 2000  # нм

T = [i * 100 for i in range(30, 300 + 1)]

N = 50

with open("../data/planck.csv", "w") as f:
    f.write("l,")
    for t in T:
        f.write("t{},".format(t))
    f.write("tl\n")
    for i in np.linspace(0, np.log(N), num=N):
        l = np.float64(l_min) + np.float64((l_max - l_min) * (np.exp(i) - 1)) / np.float64(N - 1)
        f.write("{},".format(np.format_float_scientific(l, precision=3)))
        for t in T:
            f.write("{},".format(np.format_float_scientific(B(l * 10 ** (-9), t), precision=3)))
        f.write("{}\n".format(np.format_float_scientific(vin(l * 10 ** (-9)), precision=3)))
