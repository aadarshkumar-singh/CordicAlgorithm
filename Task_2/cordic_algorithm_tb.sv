// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)
// System Verilog testbench for testing the implemented cordic algorithm
// to compute sine and cosine values for given angle. 
// The angles are in radians . 
// Fixed point representation is used to represent the angles.
// Fixed point representation <1 bit(sign): 3 bits(decimal part) : 28 bits (fractional part) > 

module cordic_algorithm_tb;

  // The width of x and y coordinates of the vector
  localparam width = 32; 
  
  // Pre-scaling of the initial vector coordinates
  // K * initial value of x, where K is the gain factor = 0.60725
  // Fixed point representation of 0.60725 is 163007430
  localparam Ax = 163007430 * 1;  
  localparam Ay = 163007430 * 0;

  // Initial Vector with 32 bit width 
  logic signed [width-1:0] Xin, Yin;
  
  // angle to be rotated
  logic signed [31:0] angle;

  // The output value for sine and cosine after rotation
  logic signed [width-1:0] COSout, SINout;
  
  cordic_algorithm TEST_RUN(.cosine(COSout), .sine(SINout), .x_start(Xin), .y_start(Yin), .angle(angle));
 
    // test bench  
   initial begin

    // rotation angle - 30 degree 
	angle = 32'd140552357; 
    Xin = Ax;  			   // pre-scaled x - axis coordinates  
    Yin = Ay;  			   // pre-scaled y - axis coordinates  
	#20; 				   // wait for a period
	
	$display ("  cos (30) = %f" , (COSout /268435456.0) );
	$display ("  sin (30) = %f\n" , (SINout /268435456.0) );
	
	// rotation angle - 60 degree 
	angle = 32'd281104715; 
    Xin = Ax;  			   // pre-scaled x - axis coordinates  
    Yin = Ay;  			   // pre-scaled y - axis coordinates  
	#20; 				   // wait for a period

	$display ("  cos (60) :%f" , (COSout /268435456.0) );
	$display ("  sin (60) :%f\n" , (SINout /268435456.0) );
	
	// rotation angle - 120 degree
	angle = 32'd562209429;  
    Xin = Ax;  			    // pre-scaled x - axis coordinates  
    Yin = Ay;  			    // pre-scaled y - axis coordinates  
	#20; 				    // wait for a period
	
	$display ("  cos (120) :%f" , (COSout /268435456.0) );
	$display ("  sin (120) :%f\n" , (SINout /268435456.0) );	
	
	// rotation angle - 210 degree
	angle = 32'd983866501;  
    Xin = Ax;  			    // pre-scaled x - axis coordinates  
    Yin = Ay;  			    // pre-scaled y - axis coordinates  
	#20; 				    // wait for a period
	
	$display ("  cos (210) :%f" , (COSout /268435456.0) );
	$display ("  sin (210) :%f\n" , (SINout /268435456.0) );	

	
	// rotation angle - 300 degree
	angle = 32'd1405523573; 
    Xin = Ax;  			    // pre-scaled x - axis coordinates  
    Yin = Ay;  			    // pre-scaled y - axis coordinates  
	#20; 				    // wait for a period
	
	$display ("  cos (300) :%f" , (COSout /268435456.0) );
	$display ("  sin (300) :%f\n" , (SINout /268435456.0) );	

   $display("Simulation has finished");  

  end
endmodule