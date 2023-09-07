module tb;

	mul_if mif(clk);

	bit clk;

	mul_dut(mif.clk,mif.m,mif.n,mif.mul);

	initial begin
		clk <= 0 ;
	end

	always #5 clk <= ~clk;

	test t;

	initial begin
		t = new(mif);
		t.run;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end

endmodule
