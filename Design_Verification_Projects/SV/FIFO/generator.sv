class generator;
	transaction t1;
	mailbox #(transaction) mbx;
	
	event next;
	event done;
	
	int count = 1;
	
	function new(mailbox #(transaction) mbx);
		this.mbx = mbx;
		
	endfunction	
	
	virtual task run;
		repeat(count) begin
          	t1 = new;
			assert(t1.randomize) else $error("Randomization Failed !");
			mbx.put(t1);
			t1.display("GEN","SENT");
			
			@(next);
		end

		->done;
	endtask
endclass

