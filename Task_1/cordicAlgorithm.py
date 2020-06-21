###########################################################
# Author : Aadarsh Kumar Singh
# Date : 21/06/2020
###########################################################
import math


# Gain Factor of the iterative process
K = 0.6072

# Number of iterations
N = 12

#List of X coordinate for 12 iterations
x_coordinate_list = []

#List of Y coordinate for 12 iterations
y_coordinate_list = []

#List of Z coordinate for 12 iterations
z_angle_list = []




#Look up table for rotation angle
def rotationAngleLookUpTable(iteration) :
    return math.degrees(math.atan(2 ** (-1 * iteration)))

def cordicAlgorithmProcess(x,y,z):

    i = 0   # counter for the iterations
    sigma = 0 # direction of the rotation <Decision operator>

    x_current = x
    y_current = y
    z_current = z

    while (i<N):

        if z_current >= 0 :
            sigma = 1
        else :
            sigma = -1

        z_next = (z_current - (sigma * rotationAngleLookUpTable(i)))
        x_next = (x_current - (sigma * (2 ** (-1 * i)) * y_current))
        y_next = (y_current + (sigma * (2 ** (-1 * i)) *  x_current))

        x_current = x_next
        y_current = y_next
        z_current = z_next

        x_coordinate_list.append(x_current)
        y_coordinate_list.append(y_current)
        z_angle_list.append(z_current)

        i=i+1

cordicAlgorithmProcess(1,0,70)

print ("After the rotating the vector by angle ")
print ("x: ", (x_coordinate_list[N-1] * K))
print ("y: ", (y_coordinate_list[N-1] * K))