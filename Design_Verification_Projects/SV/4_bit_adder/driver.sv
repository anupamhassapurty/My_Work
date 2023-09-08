class driver;

	virtual add_if aif;
	
	mailbox #(transaction) mbx;
	
	transaction t2;
		
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
      	t2 = new;
	endfunction

	//reset dut
	task reset;
      @(posedge aif.clk);
      		t2.display("ENV","RESET");
			aif.a <= 8'b0;
			aif.b <= 8'b0;
      @(posedge aif.clk);
	endtask
	
	//Apply random stimulus to DUT
	task run;
		forever begin
			mbx.get(t2);
			
			t2.display("DRV","SENT");
			
			aif.a <= t2.a;
			aif.b <= t2.b;
			
          repeat(2) @(posedge aif.clk);
			
		end

	endtask

endclass	
