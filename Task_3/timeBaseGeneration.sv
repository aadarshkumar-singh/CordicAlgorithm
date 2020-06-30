// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)
// System Verilog code for implementation of time base generation

// parameter L is the modulo value required for time base generation
// In this example we do 10MHz time base generation 
 module timeBaseGeneration #(parameter L = 5) (
							input logic clk, reset_n,
							output logic q );

// Calculation of bitwidth from modulo value 
localparam BITWIDTH = $clog2(L);

logic [BITWIDTH-1:0] time_base = 0;

always_ff@(posedge clk)
	if(reset_n == 1'b0)
		time_base <= 1'b0;
	else
		time_base <= (time_base + 1'b1) % L;

// Enable signal is set when required frequency is obtained		
assign q = (time_base == (L - 1'b1)) ? 1 : 0;

endmodule