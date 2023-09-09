`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

//Uncomment the required testcase to check the respective operation

`include "test_basic.sv"  // Basic Test
//`include "test1.sv"       //Test case 1 : Full
//`include "test2.sv"       //Test case 2 : Empty
//`include "test3.sv"       //Test case 3 : Overflow
//`include "test4.sv"       //Test case 4 : Overrun
//`include "test5.sv"       //Test case 5 : Underflow
//`include "test6.sv"       //Test case 6 : Underrun

/////////////////////////////////////////////////////tb
module tb;

  
  bit clk;
	
	initial begin
		clk =0;
	end
	
	always #5 clk = ~clk;
	
    fifo_if fif(clk);
  
  	test  t; 
  
  fifo dut(
    .clk         (fif.clk),
    .rst         (fif.rst),
    .write_enable(fif.write_enable),
    .read_enable (fif.read_enable),
    .data_in     (fif.data_in),
    .data_out    (fif.data_out),
    .full        (fif.full),
    .empty       (fif.empty),
    .overflow    (fif.overflow),
    .underflow   (fif.underflow),
    .overrun     (fif.overrun),
    .underrun    (fif.underrun)
);
	
	initial begin
		t = new(fif);
		t.run;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end

endmodule
