import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "pkg.sv"

import mul_pkg::*;

module tb;

	mul_if mif();

  mul dut(mif.clk,mif.m,mif.n,mif.mul);

	initial begin
		uvm_config_db#(virtual mul_if)::set(null, "*", "mif",mif);

		run_test("test");
	end

	initial begin 
		mif.clk = 0;
	end

	always #10 mif.clk = ~mif.clk;

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end

endmodule
