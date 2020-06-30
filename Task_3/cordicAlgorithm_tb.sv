// System Verilog Testbecnh for deriving sine and cosine 
// values using Cordic Algorithm
// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)

module CORDIC_ALGO_TESTBENCH;

  localparam width = 32; //width of x and y
  localparam Ax = 163007430 * 1; // initial value of x
  localparam Ay = 163007430 * 0;

  // CORDIC
  logic signed [width-1:0] Xin, Yin;
  logic signed [31:0] angle;
  logic signed [63:0] i;

  logic signed [width-1:0] COSout, SINout;
  real outputValue_cos ;
  real outputValue_sin;
  
  CORDIC_ALGO TEST_RUN(.cosine(COSout), .sine(SINout), .x_start(Xin), .y_start(Yin), .angle(angle));
  
  assign outputValue_cos = (COSout /268435456.0);
  assign outputValue_sin = (SINout /268435456.0);
  


  initial begin

    //set initial values - 30 degree
	angle = 32'd140552357;
    Xin = Ax;     
    Yin = Ay;
	#20;
	
	$display ("  cos (30) = %f" , (COSout /268435456.0) );
	$display ("  sin (30) = %f" , (SINout /268435456.0) );
	
	 //set initial values - 60 degree
	angle = 32'd281104715;
    Xin = Ax;     
    Yin = Ay;
	#20;

	$display ("  cos (60) :%f" , (COSout /268435456.0) );
	$display ("  sin (60) :%f" , (SINout /268435456.0) );
	
	//set initial values - 120 degree
	angle = 32'd562209429;
    Xin = Ax;     
    Yin = Ay;
	#20;
	$display ("  cos (120) :%f" , (COSout /268435456.0) );
	$display ("  sin (120) :%f" , (SINout /268435456.0) );	
	
	//set initial values - 210 degree
	angle = 32'd983866501;
    Xin = Ax;     
    Yin = Ay;
	#20;
	$display ("  cos (210) :%f" , (COSout /268435456.0) );
	$display ("  sin (210) :%f" , (SINout /268435456.0) );	

	
	//set initial values - 300 degree
	angle = 32'd1405523573;
    Xin = Ax;     
    Yin = Ay;
	#20;
	$display ("  cos (300) :%f" , (COSout /268435456.0) );
	$display ("  sin (300) :%f" , (SINout /268435456.0) );	

	

   $display("Simulation has finished");
   //$stop;

  end
endmodule