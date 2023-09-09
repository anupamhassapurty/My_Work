`define DRIV_IF fif.DRIVER.driver_cb

class driver;
	virtual fifo_if fif;
	
	mailbox #(transaction) mbx;
	
	transaction t2;
		
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
      	//t2 = new;
	endfunction

	//reset dut
	task reset;
      t2 = new;
      $display("---------------- DUT RESET ----------------");
      		`DRIV_IF.rst 		 <= 1'b1;
			`DRIV_IF.write_enable <= 1'b0;
			`DRIV_IF.read_enable  <= 1'b0;
			`DRIV_IF.data_in 	 <= 'b0;
      		
      @(posedge fif.DRIVER.clk);

			`DRIV_IF.rst 		 <= 1'b0;
      		t2.display("DRV","RESET");
			$display("--------------- RESET DONE ------------------");
	endtask
	
	//Apply random stimulus to DUT
	task run;
		forever begin
			mbx.get(t2);
			
			t2.display("DRV","SENT");
          //repeat(1) @(posedge fif.DRIVER.clk);
			`DRIV_IF.write_enable <= t2.write_enable;
			`DRIV_IF.read_enable  <= t2.read_enable;
			
          	`DRIV_IF.data_in 	 <= t2.data_in;
          repeat(1) @(posedge fif.DRIVER.clk);
          	  	
		end
	endtask
endclass

