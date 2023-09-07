class scoreboard;

	transaction t4;
	mailbox #(transaction) mbx;
	
	event next;

	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
	endfunction

	task compare(input transaction t4);
		if(t4.mul == t4.m * t4.n)
			$display("[SCB] : Multiplication Data Matched");
		else
			$display("[SCB] : Error in Multiplcation");
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

