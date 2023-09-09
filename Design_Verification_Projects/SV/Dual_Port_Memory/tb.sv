`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

//Uncomment the required testcase to check the respective operation

`include "test_basic.sv"  // Basic Test
//`include "test1.sv"       //Test case 1: Write and Read Data

        
/////////////////////////////////////////////////////tb
module tb;

	ram_if rif();
	
	dual_port_RAM dut(
		rif.a_clk,rif.a_wr,rif.a_addr,rif.a_din,rif.a_dout,
		rif.b_clk,rif.b_wr,rif.b_addr,rif.b_din,rif.b_dout
	);
	
	initial begin
		rif.a_clk <=0;
		rif.b_clk <=0;
	end
	
	always begin
	#5 ;
     rif.a_clk <= ~rif.a_clk;
	 rif.b_clk <= ~rif.b_clk;
	end
	
  	test t;		
  	
	initial begin
      	t = new(rif);
		t.run;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end

endmodule
