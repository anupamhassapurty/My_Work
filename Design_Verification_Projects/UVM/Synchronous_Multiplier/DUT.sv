module mul(input clk, 
	input [7:0]m,n, 
	output reg [15:0]mul, 
	); 
	
	always@(posedge clk) begin 
		mul <= m * n; 
	end 

endmodule