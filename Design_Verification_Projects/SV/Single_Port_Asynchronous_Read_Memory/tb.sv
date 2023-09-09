`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

//Uncomment the required testcase to check the respective operation

`include "test_basic.sv"  // Basic Test
//`include "test1.sv"       //Test case 1: Write and Read Data
//`include "test2.sv"       //Test case 2: Write and Read from Different Addresses
//`include "test3.sv"       //Test case 3: Read Data Immediately After Write

        
module tb;

	mem_if mif();
	
  memory dut(mif.clk,mif.addr,mif.wr_enb,mif.wr_data,mif.rd_data);
	
	initial begin
		mif.clk <=0;
	end
	
	always #5 mif.clk <= ~mif.clk;
	
    test  t;   	
	
	initial begin
		t = new(mif);
		t.run;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end

endmodule
