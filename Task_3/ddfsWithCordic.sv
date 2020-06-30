// System Verilog Implementation for deriving DDFS using Cordic Algorithm
// values using Cordic Algorithm
// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)

module ddfs (input logic clk,
			 input logic reset_n,
			 output logic signed [31:0] SINout,
			 output logic signed [31:0] COSout );

logic enable;

localparam Ax = 163007430 * 1; // initial value of x
localparam Ay = 163007430 * 0;
logic signed [31:0] angle = 32'd4685084 ;
logic [8:0] count = 9'b0;

timeBaseGeneration #(.L(5)) time_base (.clk(clk),.reset_n(reset_n),.q(enable));

 always_ff@ (posedge clk)
	if(enable == 1) begin
		angle <= angle + 32'd4685084;
		count <= (count+1) % 360;
		if (count == 0) begin
			angle <= 32'd4685084;
		end
	end 
				

CORDIC_ALGO #(.width(32)) cordic( 
					.cosine(COSout),
					.sine(SINout),
					.x_start(Ax),
					.y_start(Ay),
					.angle(angle));

endmodule