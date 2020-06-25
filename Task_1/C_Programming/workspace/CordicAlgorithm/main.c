/*
 * main.c
 *
 *  Created on: Jun 22, 2020
 *  Author: Aadarsh Kumar Singh
 *  		Hari Krishna Yelchuri
 */

#include <stdio.h>
#include <math.h>
#include <stdint.h>

/*
 * Float values are represented as 32-bit signed integer
 * using Fixed-point Representation, we use 3 bits for representing decimal
 * and 28 bits for fractional part
 */

/* 0.60725 * (2 ^28 ) */
#define GAIN_FACTOR_K 163007430

/* 3.14159 * (2**28) */
#define PI_CONST 843314144

/* Number of Iterations : 12 */
#define NUMBER_OF_ITERATIONS 12

/* Angles represented in radians */
static const int32_t restrictedAngles[] =
{
		210828714,   /* tan-1(1) = 45(degrees) = PI/4(radians) = 0.78540 */
		124459457,
		65760959,
		33381289,
		16755421,
		8385878,
		4193962,
		2097109,
		1048570,
		524287,
		262143,
		131071
};

int x_axisRotationList[NUMBER_OF_ITERATIONS] ;
int y_axisRotationList[NUMBER_OF_ITERATIONS] ;
int32_t convertIntoRadian(float angle);

void cordicAlgorithm( int32_t x,int32_t y ,int32_t targetAngle);

int main ()
{
	/*user enters input value in float*/

	float angle;
	int targetAngle ;
	setvbuf(stdout,NULL,_IONBF,0);
	int32_t x = 1 ,y = 0;
	angle = 30;

//	1. x1, y1 => x2 = -y1, y2 = x1. //90 degree rotation
//    2. angle = angle - 90
//	3. cordic(x,y,angle)

	if(angle <= 90)
	{
		targetAngle = convertIntoRadian(angle);
		printf("%d\n", targetAngle);
		printf("%d\n", x );
		printf("%d\n", y);
		cordicAlgorithm(x, y, targetAngle);
	}
	else if (angle > 90 && angle <= 180)
	{
		angle = angle - 90;
		targetAngle = convertIntoRadian(angle);
		printf("%d\n", targetAngle);
		printf("%d\n", -y );
		printf("%d\n", x);
		cordicAlgorithm(-y, x, targetAngle);
	}
	else if (angle > 180 && angle <= 270)
	{
		angle = angle - 180;
		targetAngle = convertIntoRadian(angle);
		printf("%d\n", targetAngle);
		printf("%d\n", -x );
		printf("%d\n", -y);
		cordicAlgorithm(-x, -y, targetAngle);
	}
	else if (angle > 270 && angle <= 360)
	{
		angle = angle - 180;
		targetAngle = convertIntoRadian(angle);
		printf("%d\n", targetAngle);
		printf("%d\n", -x );
		printf("%d\n", y);
		cordicAlgorithm(-x, y, targetAngle);
	}


	printf("%f\n", (x_axisRotationList[NUMBER_OF_ITERATIONS-1]) * pow(2,-28) );
	printf("%f\n", (y_axisRotationList[NUMBER_OF_ITERATIONS-1]) * pow(2,-28) );

	return 0 ;
}

int32_t convertIntoRadian(float angle)
{
	return ((angle * (PI_CONST/180)));
}

void cordicAlgorithm(int32_t x, int32_t y ,int32_t targetAngle)
{
	 int32_t i = 0    ;  // counter for the iterations
	 int32_t sigma = 0 ; // direction of the rotation <Decision operator>

	 int32_t x_next = 0;
	 int32_t y_next = 0;
	 int32_t z_next = 0;


	 int32_t x_current = 163007430 * x;
	 int32_t y_current = 163007430 * y;
	 int32_t z_current = targetAngle ;

	 while (i < NUMBER_OF_ITERATIONS)
	 {
		if (z_current >= 0)
		{
			sigma = 1;
		}
		else
		{
			sigma = -1;
		}

        z_next = (z_current - (sigma * restrictedAngles[i]));
        x_next = (x_current - (sigma * (y_current >> i)));
        y_next = (y_current + (sigma * (x_current >> i)));

        x_current = x_next;
        y_current = y_next;
        z_current = z_next;

        x_axisRotationList[i] = x_current ;
        y_axisRotationList[i] = y_current ;

		i=i+1 ;
	 }
}

