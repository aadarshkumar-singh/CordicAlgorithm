// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)
// System Verilog Code for Implementation of DDFS using cordic algorithm
// to generate sine and cosine waveform
// The angles are in radians . 
// Fixed point representation is used to represent the angles.
// Fixed point representation <1 bit(sign): 3 bits(decimal part) : 28 bits (fractional part) > 


// The width has to be 32 as we have used 32 bit fixed point representation for calculation of 
// sine and cosine values  
module ddfs_using_cordic (input logic clk,
						  input logic reset_n,
			              output logic signed [31:0] SINout,
			              output logic signed [31:0] COSout );

logic enable;

 // Pre-scaling of the initial vector coordinates 
 // By multiplying initial vector with K , where K is the gain factor = 0.60725
 // Fixed point representation of 0.60725 is 163007430
localparam Ax = 163007430 * 1;  // Initial x coordinate of vector 1
localparam Ay = 163007430 * 0;  // Initial x coordinate of vector 0

// angle to be rotated , Initially set to fixed point representation for 1 degree in radians
logic signed [31:0] angle = 32'd4685084 ;

// Count to increase the angle till 360 degrees is reached 
logic [8:0] count = 9'b0;

// Time base generation to generate 10 MHz enable signal 
timeBaseGeneration #(.L(5)) time_base (.clk(clk),.reset_n(reset_n),.q(enable));

// Increment the angle by 1 degree from 0 till 360 degree 
// This angle will be used by cordic algorithm to calculate sine and cosine for each of the angles
// Angle are in radians and fixed point representation is used.
 always_ff@ (posedge clk)
	if(enable == 1) begin
		angle <= angle + 32'd4685084;
		count <= (count+1) % 360;
		if (count == 0) begin
			angle <= 32'd4685084;
		end
	end 
				
// Cordic Algorithim to calculate sine and cosine for each angle
cordic_algorithm #(.width(32)) cordic( 
					.cosine(COSout),
					.sine(SINout),
					.x_start(Ax),
					.y_start(Ay),
					.angle(angle));

endmodule