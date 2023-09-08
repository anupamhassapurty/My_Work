module tb;

	add_if aif();
	
	add dut(aif.clk,aif.a,aif.b,aif.sum,aif.carry);
	
	initial begin
		aif.clk <=0;
	end
	
	always #5 aif.clk <= ~aif.clk;
	
	test t;
	
	initial begin
		t = new(aif);
		t.run;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end

endmodule
