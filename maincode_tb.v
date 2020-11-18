`timescale 1ns / 1ps
module maincode_tb;

	// Inputs
	reg [7:0] in1;
	reg [7:0] in2;
	reg clk;
	reg rst;

	// Outputs
	wire [15:0] mult;

	// Instantiate the Unit Under Test (UUT)
	main_code uut (
		.mult(mult), 
		.in1(in1), 
		.in2(in2), 
		.clk(clk), 
		.rst(rst)
	);
	initial begin
	clk = 1'b1;
	end
	always #2 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		in1 = 1; in2 = 1; rst = 0;
		#4 in1 = 1; in2 = 1; rst = 1;
		#4 in1 = 1; in2 = 1; rst = 0;
		#4 in1 = 1; in2 = 2;
		#4 in1 = 2; in2 = 3;
		#4 in1 = 3; in2 = 4;
		#4 in1 = 4; in2 = 5;
		#4 in1 = 5; in2 = 6;
		#4 in1 = 8'b11111110; in2 = 4;
		#4 in1 = 8'b11111101; in2 = 6;
		#4 in1 = 4; in2 = 10;
		#4 in1 = 12; in2 = 4;
	end
      
endmodule

