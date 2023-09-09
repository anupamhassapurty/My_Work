interface ram_if();
	parameter DATA = 72; 
	parameter ADDR = 10;
	
// Port A 
	logic a_clk;
	logic a_wr;
	logic [ADDR-1:0] a_addr; 
	logic [DATA-1:0] a_din;
	logic [DATA-1:0] a_dout; 
 
// Port B 
	logic b_clk; 
	logic b_wr;
	logic [ADDR-1:0] b_addr; 
	logic [DATA-1:0] b_din; 
	logic [DATA-1:0] b_dout; 
endinterface

