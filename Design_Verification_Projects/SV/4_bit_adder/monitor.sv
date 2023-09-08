class monitor;

	virtual add_if aif;
	
	transaction t3;
	mailbox #(transaction) mbx;
	
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
		t3 = new;
	endfunction

	task run;
		forever begin
          repeat(2) @(posedge aif.clk);
			t3.a = aif.a;
			t3.b = aif.b;
			t3.sum = aif.sum;
          	t3.carry = aif.carry;
			
			mbx.put(t3);
			
			t3.display("MON","RCVD");
		end
	endtask
	
endclass
