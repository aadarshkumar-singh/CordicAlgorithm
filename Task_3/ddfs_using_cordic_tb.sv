// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)
// System Verilog testbench for testing the implemented DDFS using cordic algorithm
// to generate sine and cosine waveform
// The angles are in radians . 
// Fixed point representation is used to represent the angles.
// Fixed point representation <1 bit(sign): 3 bits(decimal part) : 28 bits (fractional part) > 


`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD 10  // Defination of constants used for clock
`define RESET_PERIOD 100
`define SIM_DURATION 5000000
module ddfs_using_cordic_tb();

    // The output value for sine after rotation
	logic signed [31:0] sine_out_val;
	
	// The output value for cosine after rotation
	logic signed [31:0] cos_out_val;
	
	// clock of the testbench
	logic tb_clk = 0;
	
	// Used to display the output , It represents the step while angle is rotated from 0 to 360 
	// Initially set to -1 , because we increment the iteration and then display
	// To start from 0 we implement it this way
	logic signed [10:0] iteration = -1;
	
	//Used for Displaying the resultant cosine for angles from 0 to 360 
	real outputValue_cos ;
	
	//Used for Displaying the resultant sine for angles from 0 to 360
	real outputValue_sin;
	
	// Clock generation for testbench
	initial
	begin: clock_generation_process
		tb_clk = 0;
		forever begin
			#`HALF_CLOCK_PERIOD tb_clk = ~tb_clk;
		end
	end
	
	logic tb_reset_n = 0;
	initial
	begin: testbench_scheduler
		$display ("Simulation starts ...");
		#`RESET_PERIOD
		tb_reset_n = 1;
		#`SIM_DURATION
		$stop();
	end

	// Testing the implementation of ddfs using cordic algorithm
	ddfs_using_cordic inst_dut (.clk(tb_clk),
								.reset_n(tb_reset_n),
								.SINout(sine_out_val),
								.COSout(cos_out_val));
	
	// displaying the resultant cosine and sine value from angle 0 to 360 with step of 1 degree
	always_comb
	begin
		outputValue_cos = (cos_out_val /268435456.0);
		outputValue_sin = (sine_out_val /268435456.0);
		iteration = (iteration + 1) % 360;
		$display (" cos (%d) = %f" , iteration, outputValue_cos);	
        $display (" sin (%d) = %f" , iteration, outputValue_sin);	
				
		
	end
	
endmodule