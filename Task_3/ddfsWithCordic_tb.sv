// System Verilog Testbecnh for deriving DDFS using Cordic Algorithm
// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)

`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD 10
`define RESET_PERIOD 100
`define SIM_DURATION 5000000
module ddfs_tb();

	logic signed [31:0] sine_out_val;
	logic signed [31:0] cos_out_val;
	logic tb_clk = 0;
	logic[8:0] iteration = 0;
	
	real outputValue_cos ;
	real outputValue_sin;
	
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

	ddfs inst_dut (
	.clk(tb_clk),
	.reset_n(tb_reset_n),
	.SINout(sine_out_val),
	.COSout(cos_out_val));
	
	always_comb
	begin
		outputValue_cos = (cos_out_val /268435456.0);
		outputValue_sin = (sine_out_val /268435456.0);
		$display (" cos (%d) = %f" , iteration, outputValue_cos);	
        $display (" sin (%d) = %f" , iteration, outputValue_sin);	
		iteration = (iteration + 1) % 360;		
		
	end
	
endmodule