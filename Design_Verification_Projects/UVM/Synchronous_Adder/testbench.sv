import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "pkg.sv"

import add_pkg::*;

module tb;

	add_if aif();

	add dut(aif.clk,aif.a,aif.b,aif.sum,aif.carry);

	initial begin
		uvm_config_db#(virtual add_if)::set(null,"*","aif",aif);

		run_test("test");
	end

	initial begin
		aif.clk = 0;
	end

	always #10 aif.clk = ~aif.clk;

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end

endmodule
