`define DRIV_IF mif.DRIVER.driver_cb

class driver;

	virtual mul_if mif;

	mailbox #(transaction) mbx;
	transaction t2;

	int no_transactions;

	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
		t2 = new;
	endfunction

	//reset DUT
	task reset;
		@(posedge mif.DRIVER.clk);
			t2.display("ENV","RESET");
			`DRIV_IF.m <= 8'b0;
			`DRIV_IF.n <= 8'b0;
		@(posedge mif.DRIVER.clk);
	endtask

	//Apply random stimulus to DUT
	task run;
		forever begin
			mbx.get(t2);

			t2.display("DRV", "SENT");

			`DRIV_IF.m <= t2.m;
			`DRIV_IF.n <= t2.n;

			repeat(2) @(posedge mif.clk);
		
		end
	endtask

endclass
