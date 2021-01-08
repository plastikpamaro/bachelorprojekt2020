import numpy as np
import matplotlib.pyplot as plt

input_file = open("./input.csv")

#print(input_file.readline())

input = []
for i in range(0,1024):
    input.append(float(input_file.readline()))

plt.plot(input)
plt.ylabel('some numbers')
plt.show()