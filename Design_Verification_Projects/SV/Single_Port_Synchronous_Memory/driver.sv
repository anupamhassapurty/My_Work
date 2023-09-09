class driver;

	virtual mem_if mif;
	
	mailbox #(transaction) mbx;
	
	transaction t2;
		
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
      	t2 = new;
	endfunction

	//reset dut
	task reset;
      @(posedge mif.clk);
      t2.display("DRV","RESET");
			mif.addr <= 'b0;
			mif.wr_enb <= 'b0;
			mif.wr_data <= 'b0;
      @(posedge mif.clk);
	endtask
	
	//Apply random stimulus to DUT
	task run;
		forever begin
			mbx.get(t2);
			
			t2.display("DRV","SENT");
			
			mif.addr <= t2.addr;
			mif.wr_enb <= t2.wr_enb;
			mif.wr_data <= t2.wr_data;
			
          repeat(2) @(posedge mif.clk);
			
		end

	endtask

endclass
