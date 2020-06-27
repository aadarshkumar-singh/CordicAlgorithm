// System Verilog Implementation for deriving sine and cosine 
// values using Cordic Algorithm
// Authors : Aadarsh Kumar Singh(766499), Hari Krishna Yelchuri (766518)

module CORDIC_ALGO #(parameter width = 32)( 
					input clock,
					output signed [width-1:0] cosine,
					output signed [width-1:0] sine,
					input signed  [width-1:0] x_start,
					input signed  [width-1:0] y_start,
					input signed  [width-1:0]angle);


  // Generate lookup table for atan values 32 is the width and upto 12 values 
  logic signed [width-1:0] atan_table [11:0];
                          
  assign atan_table[0]  = 32'd210828714; 	// 45.000 degrees -> atan(2^0)
  assign atan_table[1]  = 32'd124459457;  	// 26.565 degrees -> atan(2^-1)
  assign atan_table[2]  = 32'd65760959; 	// 14.036 degrees -> atan(2^-2)
  assign atan_table[3]  = 32'd33381289; 	// atan(2^-3)
  assign atan_table[4]  = 32'd16755421;
  assign atan_table[5]  = 32'd8385878;
  assign atan_table[6]  = 32'd4193962;
  assign atan_table[7]  = 32'd2097109;;
  assign atan_table[8]  = 32'd1048570;
  assign atan_table[9]  = 32'd524287;;
  assign atan_table[10] = 32'd262143;
  assign atan_table[11] = 32'd131071;


  logic signed [width -1 :0] x [11:0];
  logic signed [width -1 :0] y [11:0];
  logic signed [width -1 :0] z [11:0];


  // make sure rotation angle is in -pi/2 to pi/2 range

  always @(posedge clock)
  begin // make sure the rotation angle is in the -pi/2 to pi/2 range    
	if(angle < 32'd421658414) begin
        x[0] <= x_start;
        y[0] <= y_start;
        z[0] <= angle;
		$display (" In 90");
	end
	else if (angle > 32'd421658414 && angle < 32'd843314144) begin
        x[0] <= -y_start;
        y[0] <= x_start;
        z[0] <= angle - 32'd421658414; // subtract pi/2 for angle in this 
	end
	else if (angle > 32'd843314144 && angle < 32'd1264972559) begin
        x[0] <= - x_start;
        y[0] <= - y_start;
        z[0] <= angle - 32'd843314144; // subtract pi for angle in this 	
	end
	else if (angle > 32'd1264972559 && angle < 32'd1686630973) begin
        x[0] <= y_start;
        y[0] <= - x_start;
        z[0] <= angle - 32'd1264972559; // subtract 3pi/2 for angle in this	
	end	
  end


  // run through iterations
  genvar i;

  generate
  for (i=0; i < (12); i=i+1)
  begin: xyz
    wire z_sign;
    logic signed [width-1:0] x_shr, y_shr;

    assign x_shr = x[i] >>> i; // signed shift right
    assign y_shr = y[i] >>> i;
    
	//the sign of the current rotation angle
    assign z_sign = z[i][31];
	
    always @(posedge clock)
    begin
	  // add/subtract shifted data
      x[i+1] <= z_sign ? x[i] + y_shr : x[i] - y_shr;
      y[i+1] <= z_sign ? y[i] - x_shr : y[i] + x_shr;
      z[i+1] <= z_sign ? z[i] + atan_table[i] : z[i] - atan_table[i];
    end
  end
  endgenerate

  // assign output
  assign cosine = x[11];
  assign sine = y[11];

endmodule