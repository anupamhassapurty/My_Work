// Code your design here
module add (input clk, 
	input [3:0]a,b, 
	output reg [3:0]sum, 
	output reg carry
	); 

	always@(posedge clk) begin 
		{carry , sum } <= a + b; 
	end 

endmodule