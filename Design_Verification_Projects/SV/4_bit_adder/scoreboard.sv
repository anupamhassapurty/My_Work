class scoreboard;

	transaction t4;
	mailbox #(transaction) mbx;
	
	event next;
	
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
	endfunction

	task compare(input transaction t4);
      if(({t4.carry,t4.sum}) == (t4.a + t4.b))
			$display("[SCB] : Adder Data Matched");
		else
			$error("[SCB] : Error In Addition");
	endtask		
	
	task run;
		forever begin
			mbx.get(t4);
			
			t4.display("SCB","RCVD");
			
          compare(t4);
		
		->next;	
		end
		
	endtask	
endclass
	
