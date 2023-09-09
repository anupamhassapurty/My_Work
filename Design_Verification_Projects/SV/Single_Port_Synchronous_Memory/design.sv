 // Single Port Synchronous Read and Write Memory 
module memory (clk, addr, wr_enb, wr_data, rd_data); 

	parameter M=3, N=4; 
	
	input [M-1: 0] addr; 
	input clk, wr_enb; 
	input [N-1: 0] wr_data; 
	output reg [N-1:0] rd_data; 
	
	reg [N-1:0] mem [0: (2**M)- 1]; 
	
	always@ (posedge clk) 
		rd_data <= mem [addr]; // Syn Read 

	always@ (posedge clk) begin 
		if (wr_enb) 
			mem [addr] <= wr_data; 
	end 

endmodule
