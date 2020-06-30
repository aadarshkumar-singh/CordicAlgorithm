// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)
// System Verilog Implementation for cordic algorithm to compute sine and cosine values for given angle. 
// The angles are in radians . 
// Fixed point representation is used to represent the angles.
// Fixed point representation <1 bit(sign): 3 bits(decimal part) : 28 bits (fractional part) > 

// The width has to be 32 as we have used 32 bit fixed point representation for calculation of 
// sine and cosine values  
module cordic_algorithm #(parameter width = 32)( output signed [width-1:0] cosine,
												 output signed [width-1:0] sine,
												 input signed  [width-1:0] x_start,
												 input signed  [width-1:0] y_start,
												 input signed  [width-1:0]angle);


  // lookup table for cordic angles (atan values), 
  // each value is 32 bit wide and totally 12 values are used.
  logic signed [width-1:0] atan_table [11:0];
  
  // Fixed point representation is used to represent the angles in radians.
  // Fixed point representation used is described as  <1 bit(sign): 3 bits(decimal part) : 28 bits (fractional part) > 
  assign atan_table[0]  = 32'd210828714;  // atan(2^0) = 45.000 (degrees) = 0.78540(radians)
  assign atan_table[1]  = 32'd124459457;  // atan(2^-1) = 26.565 (degrees) = 0.4636(radians)
  assign atan_table[2]  = 32'd65760959;   // atan(2^-2) = 14.036 degrees =0.2449(radians)
  assign atan_table[3]  = 32'd33381289;   
  assign atan_table[4]  = 32'd16755421;
  assign atan_table[5]  = 32'd8385878;
  assign atan_table[6]  = 32'd4193962;
  assign atan_table[7]  = 32'd2097109;;
  assign atan_table[8]  = 32'd1048570;
  assign atan_table[9]  = 32'd524287;;
  assign atan_table[10] = 32'd262143;
  assign atan_table[11] = 32'd131071;


  // Stores the rotation cordinates for x-axis
  logic signed [width -1 :0] x [11:0];
  
  // Stores the rotation cordinates for y-axis
  logic signed [width -1 :0] y [11:0];
  
  // Stores the rotation angles
  logic signed [width -1 :0] z [11:0];

  // direction of the rotation <Decision operator>
  logic signed z_sign;
  
  // Stores the shifted values of x and y after rotation
  logic signed [width-1:0] x_shiftRight, y_shiftRight;

  always_comb
  begin 
	if(angle <= 32'd421658414) begin // Initial vector coordinates when the rotation angle < 90
        x[0] = x_start;
        y[0] = y_start;
        z[0] = angle;
	end
	else if (angle > 32'd421658414 && angle <= 32'd843314144) begin // Initial vector coordinates when the rotation angle > 90 and <180
        x[0] = -y_start;
        y[0] = x_start;
        z[0] = angle - 32'd421658414; // subtract pi/2 for angle when the rotation angle > 90 and <180
	end
	else if (angle > 32'd843314144 && angle <= 32'd1264972559) begin // Initial vector coordinates when the rotation angle > 180 and <270
        x[0] = - x_start;
        y[0] = - y_start;
        z[0] = angle - 32'd843314144; // subtract pi for angle when the rotation angle > 180 and <270
	
	end
	else if (angle > 32'd1264972559 && angle <= 32'd1686630973) begin // Initial vector coordinates when the rotation angle > 270 and <360
        x[0] = y_start;
        y[0] = - x_start;
        z[0] = angle - 32'd1264972559; // subtract 3pi/2 for angle in this when the rotation angle > 270 and <360
	end
	
	for (int i=0; i < (12); i=i+1) begin
		x_shiftRight = x[i] >>> i; // x coordinate signed shift right
		y_shiftRight = y[i] >>> i; // y coordinate signed shift right
		z_sign = z[i][31];	 // Decide the direction of the rotation
		
		// shifted coordinates are added/subtracted based on the direction of rotation
		x[i+1] = z_sign ? x[i] + y_shiftRight : x[i] - y_shiftRight;
		y[i+1] = z_sign ? y[i] - x_shiftRight : y[i] + x_shiftRight;
		z[i+1] = z_sign ? z[i] + atan_table[i] : z[i] - atan_table[i];	
	end
	
  end
 
  // The x coordinates and y coordinates after final rotation is the output
  assign cosine = x[11];
  assign sine = y[11];
  


endmodule