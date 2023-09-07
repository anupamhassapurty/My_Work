interface mul_if(input logic clk);
	logic [7:0]m,n;
	logic [15:0]mul;

	clocking driver_cb @(posedge clk);
		default input #1 output #1;
		output m;
		output n;
		input mul;
	endclocking

	clocking monitor_cb @(posedge clk);
		default input #0 output #1;
		input m;
		input n;
		input mul;
	endclocking

	modport DRIVER(clocking driver_cb, input clk);
	modport MONITOR(clocking monitor_cb, input clk);

endinterface