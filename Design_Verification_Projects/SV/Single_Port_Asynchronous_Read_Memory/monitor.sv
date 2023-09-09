class monitor;

	virtual mem_if mif;
	
	transaction t3;
	mailbox #(transaction) mbx;
	
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
		t3 = new;
	endfunction

	task run;
		forever begin
          repeat(2) @(posedge mif.clk);
			t3.addr = mif.addr;
			t3.wr_enb = mif.wr_enb;
			t3.wr_data = mif.wr_data;
          	t3.rd_data = mif.rd_data;
			
			mbx.put(t3);
			
			t3.display("MON","RCVD");
		end
	endtask
	
endclass
