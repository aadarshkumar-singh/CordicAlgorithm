// System Verilog Testbecnh for deriving sine and cosine 
// values using Cordic Algorithm
// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)

module CORDIC_ALGO_TESTBENCH;

  localparam width = 32; //width of x and y

  // CORDIC
  reg [width-1:0] Xin, Yin;
  reg [31:0] angle;
  reg clk;
  reg signed [63:0] i;

  wire [width-1:0] COSout, SINout;

  localparam Ax = 163007430 * 1;
  localparam Ay = 163007430 * 0;

  initial begin

    //set initial values
	angle = 32'd140552336;
    Xin = Ax;     
    Yin = Ay;     

    //set clock
    clk = 'b0;
    forever
    begin
      #5 clk = !clk;
    end

    #50

    // Test 1
    #1000
	angle = 32'd140552336;	

   #1000
   $write("Simulation has finished");
   $stop;

  end

  CORDIC_ALGO TEST_RUN(clk, COSout, SINout, Xin, Yin, angle);

  // Monitor the output
  initial
  $monitor($time, , COSout, , SINout, , angle);

endmodule