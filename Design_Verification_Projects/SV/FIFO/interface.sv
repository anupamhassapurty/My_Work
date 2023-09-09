interface fifo_if(input logic clk);
	parameter DEPTH = 16;
    parameter WIDTH = 8;
	
    logic rst;
    logic write_enable;
    logic read_enable;
    logic [WIDTH-1:0] data_in;
    
	logic [WIDTH-1:0] data_out;
    logic full;
    logic empty;
    logic overflow;
    logic underflow;
    logic overrun;
    logic underrun;
  
  clocking driver_cb @(posedge clk);
		default input #0 output #0;
		output rst;
    	output write_enable;
    	output read_enable;
    	output data_in;
    
    	input data_out;
    	input full;
    	input empty;
    	input overflow;
    	input underflow;
    	input overrun;
    	input underrun;
	endclocking

	clocking monitor_cb @(posedge clk);
		default input #0 output #0;
		input rst;
    	input write_enable;
    	input read_enable;
    	input data_in;
    
    	input data_out;
    	input full;
    	input empty;
    	input overflow;
    	input underflow;
    	input overrun;
    	input underrun;
	endclocking

	modport DRIVER(clocking driver_cb, input clk);
	modport MONITOR(clocking monitor_cb, input clk);
  
      endinterface

